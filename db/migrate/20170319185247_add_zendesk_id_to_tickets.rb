class AddZendeskIdToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :zendesk_id, :integer, null: false
    add_index :tickets, :zendesk_id, unique: true
  end
end
