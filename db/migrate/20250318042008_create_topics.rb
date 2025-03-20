class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.text :body
      t.decimal :llm_fee, precision: 15, scale: 7  # Allows precision down to e-6
      t.timestamps
    end
  end
end
