class CreateSoortCourses < ActiveRecord::Migration
  def change
    create_table :soortcourses do |t|
      t.string :cursussoort
      t.integer :prijs

      t.timestamps null: false
    end
  end
end
