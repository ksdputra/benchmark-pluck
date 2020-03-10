class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.string :email
      t.string :phone_number
      t.integer :age
      t.string :company
      t.string :position
      t.string :role
      t.string :status
      t.string :character
      t.string :reward
      t.string :level
      t.string :quote
      t.integer :money
      t.string :marital
      t.string :product
      t.string :food
      t.string :drink
      t.string :laptop
    end
  end
end
