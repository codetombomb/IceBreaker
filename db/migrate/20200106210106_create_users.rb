class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :secret_number
      t.integer :birth_year
    end
  end
end
