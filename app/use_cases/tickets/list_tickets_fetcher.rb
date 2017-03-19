module Tickets
  class ListTicketsFetcher
    class << self
      def fetch
        Zendesk.client.search(query: 'type:ticket created>24hours')
      end
    end
  end
end
