class CreateFacts < ActiveRecord::Migration[5.0]
  def change
    create_table :facts do |t|
      t.string :text
      t.string :type
      t.integer :number
      t.string :year, :default => nil
      t.integer :count
  end
end
