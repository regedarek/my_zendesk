class TicketsController < ApplicationController
  def index
    @view = Tickets::ListTicketsView.new(params: params.fetch(:tickets_create_ticket_form, {}))
    @view.fetch_data!
  end

  def create
    @view = Tickets::ListTicketsView.new(params: ticket_params)
    @view.fetch_data!

    result = Tickets::CreateTicket.create(form: @view.create_ticket_form)
    result.on!(
      form_invalid: proc { |form:| render :index },
      already_exist: proc { redirect_to(tickets_path, alert: 'Ticket already exists.') },
      bad_data: proc { redirect_to(tickets_path, alert: 'Fetched wrong data from Zendesk API.') },
      success:      proc { redirect_to(tickets_path, notice: 'Ticket created.') }
    )
  end

  private

  def ticket_params
    params.require(:tickets_create_ticket_form).permit(:title, :description)
  end
end
