module Tickets
  class TicketsFetcher
    class << self
      def fetch_latest
        tickets = Zendesk.client.search(query: 'type:ticket updated>24hours', reload: true)

        tickets.map do |ticket_data|
          ticket = Db::Ticket.find_by(zendesk_id: ticket_data.id).update(
            title: ticket_data.subject,
            description: ticket_data.description,
            status: ticket_data.status,
            recorded_at: ticket_data.created_at
          )
        end

        Success.new(count: tickets.count)
      end
    end
  end
end
