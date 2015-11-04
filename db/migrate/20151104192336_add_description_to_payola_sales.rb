class AddDescriptionToPayolaSales < ActiveRecord::Migration
  def change
    add_column :payola_sales, :description, :string
  end
end
