class CreateMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :mappings do |t|
      t.string :map_name
      t.integer :question_id
      t.timestamps
    end
  end
end
