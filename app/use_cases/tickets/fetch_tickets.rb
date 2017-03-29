module Tickets
  class FetchTickets
    class << self
      def fetch_latest
        latest_tickets = Zendesk.client.search(query: 'type:ticket updated>24hours', reload: true) # updated => created || updated
        # posibly Failure.new on connection issues
        parsed_tickets = latest_tickets.map do |ticket_data|
          zendesk_ticket = Tickets::ZendeskTicket.new(
            id: ticket_data.id,
            title: ticket_data.subject,
            description: ticket_data.description,
            status: ticket_data.status,
            recorded_at: ticket_data.created_at.to_s
          )
        end
        # we could also handle and log invalid tickets
        Success.new(parsed_tickets: parsed_tickets.select(&:valid?))
      end
    end
  end
end
