require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  render_views
  describe "#create" do
    it 'creates ticket' do
      expect do
        VCR.use_cassette('create_ticket') do
          post :create, { tickets_create_ticket_form: { title: 'test1', description: 'test description' } }
        end
      end.to change(Db::Ticket, :count).by(1)
      expect(response).to redirect_to(tickets_path)
    end

    it 'renders errors if params are invalid' do
      expect do
        VCR.use_cassette('create_ticket') do
          post :create, { tickets_create_ticket_form: { description: 'test description' } }
        end
      end.to change(Db::Ticket, :count).by(0)

      expect(response).to be_success
      expect(response.body).to be_include("Title can&#39;t be blank")
    end
  end
end
