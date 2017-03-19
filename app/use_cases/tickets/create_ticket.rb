module Tickets
  class CreateTicket
    class << self
      def create(form:)
        return Failure.new(:form_invalid, form: form) unless form.valid?

        ticket_data = Zendesk.client.tickets.create(subject: form.title, description: form.description)
        ticket = Db::Ticket.new(
          zendesk_id: ticket_data.id,
          title: ticket_data.subject,
          description: ticket_data.description,
          status: ticket_data.status,
          recorded_at: ticket_data.created_at
        )

        if ticket.save
          return Success.new
        else
          return Failure.new(:invalid, errors: ticket.errors)
        end
      end
    end
  end
end
