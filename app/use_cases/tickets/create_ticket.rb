module Tickets
  class CreateTicket
    class << self
      def create(form:)
        return Failure.new(:form_invalid, form: form) unless form.valid?

        Zendesk.client.tickets.create(subject: form.title, description: form.description)
        Rails.cache.clear

        return Success.new
      end
    end
  end
end
