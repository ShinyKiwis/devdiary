class CreateBugs < ActiveRecord::Migration[7.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.string :status
      t.text :context
      t.string :difficulty_level
      t.integer :time_to_resolve

      t.timestamps
    end
  end
end
