class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :pri
      t.string :qu_title
      t.string :team_stages
      t.integer :appears
      t.string :frequency
      t.string :qus_type
      t.string :required
      t.string :conditions
      t.integer :role_id
      t.integer :mapping_id
      t.timestamps
    end
  end
end
