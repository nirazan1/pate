class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :type
      t.string :breed
      t.string :sex
      t.integer :age
      t.text :info
      t.references :user, index: true, foreign_key: true
      t.references :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
