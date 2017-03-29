module Tickets
  class ZendeskTicket
    include ActiveModel::Model
    include AttributedObject::Strict

    attribute :id, :integer
    attribute :title, :string
    attribute :description, :string
    attribute :status, :string
    attribute :recorded_at, :string

    validates :id, :title, :description, :status, :recorded_at, presence: true
  end
end
