class CreateEnvironments < ActiveRecord::Migration[7.1]
  def change
    create_table :environments do |t|
      t.references :bug, null: false, foreign_key: true
      t.string :operating_system
      t.string :language
      t.string :language_version
      t.string :framework
      t.string :framework_version
      t.string :database
      t.string :database_version
      t.string :browser
      t.string :browser_version
      t.string :additional_context

      t.timestamps
    end
  end
end
