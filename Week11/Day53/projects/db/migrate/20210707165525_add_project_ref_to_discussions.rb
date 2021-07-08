class AddProjectRefToDiscussions < ActiveRecord::Migration[6.1]
  def change
    add_reference :discussions, :project, null: false, foreign_key: true
  end
end
