namespace :periodic do
  desc "Import tickets from Zendesk"
  task import_tickets: :environment do
    Tickets::ImportTickets.import

    puts 'Tickets imported'
  end
end
