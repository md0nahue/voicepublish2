class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.text :body
      t.decimal :fees, array: true, precision: 15, scale: 7, default: []  # Array of small decimal fees
      t.timestamps
    end
  end
end
