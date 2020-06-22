class AddPopcornToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :popcorn
  end
end
