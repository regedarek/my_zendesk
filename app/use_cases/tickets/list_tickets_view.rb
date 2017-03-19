module Tickets
  class ListTicketsView
    attr_reader :entries

    def initialize(create_ticket_form:)
      @create_ticket_form = create_ticket_form
    end

    def fetch_data!
      @entries = Tickets::ListTicketsFetcher.fetch
    end
  end
end
