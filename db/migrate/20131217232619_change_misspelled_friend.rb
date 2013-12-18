class ChangeMisspelledFriend < ActiveRecord::Migration
  def change
    rename_column :friend_circle_memberships, :frield_circle_id, :friend_circle_id
  end

end
