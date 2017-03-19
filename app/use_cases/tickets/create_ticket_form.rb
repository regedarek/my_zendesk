require 'active_model'

module Tickets
  class CreateTicketForm
    include ActiveModel::Model # for validations
    include AttributedObject::Coerce # for attributes
    attributed_object(default_to: AttributedObject::TypeDefaults.new)

    attribute :title, :string
    attribute :description, :string

    validates :title, :description, presence: true
  end
end
