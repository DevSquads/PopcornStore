class CreatePopcorns < ActiveRecord::Migration[6.0]
  def change
    create_table :popcorns do |t|
      t.string :flavor
      t.decimal :price, precision: 12, scale: 2

      t.timestamps
    end
  end
end
