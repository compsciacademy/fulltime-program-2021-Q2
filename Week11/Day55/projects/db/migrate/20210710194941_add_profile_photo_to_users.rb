class AddProfilePhotoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_photo, :attachment
  end
end
