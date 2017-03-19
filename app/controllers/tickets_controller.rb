class TicketsController < ApplicationController
  def index
    @ticket_create_form = Tickets::CreateTicketForm.new
    @view = Tickets::ListTicketsView.new(create_ticket_form: @create_ticket_form)
    @view.fetch_data!
  end

  def create
  end
end
