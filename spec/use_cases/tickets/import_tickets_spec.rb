require 'rails_helper'

RSpec.describe Tickets::ImportTickets, type: :model do
  it '.import' do
    expect do
      VCR.use_cassette('import_tickets') do
        Tickets::ImportTickets.import
      end
    end.to change(Db::Ticket, :count).by(17)
  end
end
