module Tickets
  class ZendeskTicket
    include AttributedObject::Strict

    attribute :title, :string
    attribute :description, :string
    attribute :status, :string
    attribute :created_at
  end
end
