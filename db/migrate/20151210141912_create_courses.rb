class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.date :begindatum
      t.date :einddatum
      t.references :soortcourse, index:true

      t.timestamps null: false
    end
  end
end
