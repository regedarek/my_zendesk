module Db
  class Ticket < ApplicationRecord
    validates :zendesk_id, uniqueness: true
  end
end
