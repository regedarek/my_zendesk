class ZendeskTicketsFetchJob < ApplicationJob
  queue_as :default

  def perform
    Tickets::TicketsFetcher.fetch
  end
end
