module Tickets
  class TicketsFetcher
    class << self
      def fetch
        tickets = Zendesk.client.search(query: 'type:ticket created>24hours', reload: true)

        tickets.map do |ticket_data|
          ticket = Db::Ticket.new(
            zendesk_id: ticket_data.id,
            title: ticket_data.subject,
            description: ticket_data.description,
            status: ticket_data.status,
            recorded_at: ticket_data.created_at
          )
          ticket.save if ticket.valid?
        end
      end
    end
  end
end
