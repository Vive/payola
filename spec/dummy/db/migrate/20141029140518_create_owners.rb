class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners, &:timestamps
  end
end
