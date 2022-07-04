class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :username
      t.string :email
      t.text :phone
      t.integer :age
      t.string :language
      t.string :gender
      t.string :role

      t.timestamps
    end
  end
end
