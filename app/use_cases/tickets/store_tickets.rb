module Tickets
  class StoreTickets
    class << self
      def store(parsed_tickets:)
        parsed_tickets.each do |parsed_ticket|
          ticket = Db::Ticket.where(zendesk_id: parsed_ticket.id).first_or_initialize
          ticket.update!(
            title: parsed_ticket.title,
            description: parsed_ticket.description,
            status: parsed_ticket.status,
            recorded_at: parsed_ticket.recorded_at
          )
        end
      end
    end
  end
end
