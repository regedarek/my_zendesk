module Tickets
  class ListTicketsFetcher
    class << self
      def fetch
        tickets = Zendesk.client.search(query: 'type:ticket created>24hours', reload: true)

        tickets.map do |ticket|
          Tickets::ZendeskTicket.new(
            title: ticket.subject,
            description: ticket.description,
            status: ticket.status,
            created_at: ticket.created_at
          )
        end
      end
    end
  end
end
