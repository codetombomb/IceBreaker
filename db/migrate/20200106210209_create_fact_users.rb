class CreateFactUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :fact_users do |t|
      t.integer :user_id
      t.integer :fact_id
    end
  end
end
