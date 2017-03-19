class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :status, null: false
      t.datetime :recorded_at, null: false
      t.timestamps
    end
  end
end
