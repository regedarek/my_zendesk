class ZendeskTicketsFetchJob < ApplicationJob
  queue_as :default

  def perform
    Tickets::ImportTickets.import
  end
end
