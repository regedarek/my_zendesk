namespace :periodic do
  desc "Import tickets from Zendesk"
  task import_tickets: :environment do
    Tickets::TicketsFetcher.fetch_latest.on!(
      success: proc { |count:| puts "Updated #{count} tickets." }
    )
  end
end
