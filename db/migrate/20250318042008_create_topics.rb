class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.text :body
      t.integer :llm_fee
      t.timestamps
    end
  end
end
