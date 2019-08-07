class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.date :deadline
      t.string :screen_shot
      t.string :bug_type
      t.string :bug_status
    end
  end
end
