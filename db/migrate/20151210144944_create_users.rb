class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :roepnaam
      t.string :tussenvoegsel
      t.string :achternaam
      t.string :adres
      t.string :woonplaats
      t.string :telefoon
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
