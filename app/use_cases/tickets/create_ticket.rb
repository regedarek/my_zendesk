module Tickets
  class CreateTicket
    TICKET_TYPE = 'ticket'

    class << self
      def create(form:)
        return Failure.new(:form_invalid, form: form) if form.invalid?

        ticket_data = Zendesk.client.tickets.create(
          subject: form.title,
          description: form.description,
          type: Tickets::CreateTicket::TICKET_TYPE
        ) # possibly Failure.new for network issues

        parsed_ticket = Tickets::ZendeskTicket.new(
          id: ticket_data.id,
          title: ticket_data.subject,
          description: ticket_data.description,
          status: ticket_data.status,
          recorded_at: ticket_data.created_at.to_s
        )

        return Failure.new(:bad_data, errors: parsed_ticket.errors) if parsed_ticket.invalid?
        return Failure.new(:already_exist) if Db::Ticket.exists?(zendesk_id: parsed_ticket.id)

        Tickets::StoreTickets.store(parsed_tickets: [parsed_ticket])
        Success.new
      end
    end
  end
end
