class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :interview_section, null: false, foreign_key: true
      t.string :body
      t.integer :llm_fee

      t.timestamps
    end
  end
end
