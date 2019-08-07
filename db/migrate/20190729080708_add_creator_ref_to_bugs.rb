class AddCreatorRefToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :creator, foreign_key: { to_table: :users }
  end
end
