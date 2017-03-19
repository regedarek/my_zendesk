module Tickets
  class ListTicketsView
    attr_reader :tickets
    attr_reader :create_ticket_form

    def initialize(params:)
      @create_ticket_form = Tickets::CreateTicketForm.new(params)
    end

    def fetch_data!
      Rails.cache.fetch('fetched_tickets', unless_exist: true) do
        ZendeskTicketsFetchJob.perform_later
      end
      @tickets = Db::Ticket.order(recorded_at: :desc)
    end
  end
end
