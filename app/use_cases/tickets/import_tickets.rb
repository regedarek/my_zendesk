module Tickets
  class ImportTickets
    class << self
      def import
        Tickets::FetchTickets.fetch_latest.on!(
          success: proc do |parsed_tickets:|
            Tickets::StoreTickets.store(parsed_tickets: parsed_tickets)
            puts "#{parsed_tickets.count} ticket(s) updated or created"
          end
        )
      end
    end
  end
end
