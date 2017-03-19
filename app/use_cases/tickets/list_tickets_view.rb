module Tickets
  class ListTicketsView
    attr_reader :tickets
    attr_reader :create_ticket_form

    def initialize(params:)
      @create_ticket_form = Tickets::CreateTicketForm.new(params)
    end

    def fetch_data!
      ZendeskTicketsFetchJob.perform_later
      @tickets = Db::Ticket.order(recorded_at: :desc)
    end
  end
end
