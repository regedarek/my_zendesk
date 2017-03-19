require 'zendesk_api'

class Zendesk
  class << self
    def client
      @client ||= ZendeskAPI::Client.new do |config|
        config.url = 'https://rockcodehelp.zendesk.com/api/v2'
        config.username = "dariusz.finster@gmail.com/token"
        config.token = "2PjNEunsJF7dzKK8Jw2XKf7nVLb0sFSm9faqOwA6"

        require 'logger'
        config.logger = Logger.new(STDOUT)
        config.cache = Rails.cache
      end
    end
  end
end
