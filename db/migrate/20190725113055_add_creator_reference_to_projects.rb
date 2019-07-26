class AddCreatorReferenceToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :creator,foreign_key: { to_table: :users }
  end

end
