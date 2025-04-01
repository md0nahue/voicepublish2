class CreateInterviewSections < ActiveRecord::Migration[7.1]
  def change
    create_table :interview_sections do |t|
      t.references :topic, null: false, foreign_key: true
      t.string :body
      t.timestamps
    end
  end
end
