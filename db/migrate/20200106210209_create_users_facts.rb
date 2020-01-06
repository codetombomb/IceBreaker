class CreateUsersFacts < ActiveRecord::Migration[5.0]
  def change
    create_table :users_facts do |t|
      t.integer :user_id
      t.integer :fact_id
    end
  end
end
