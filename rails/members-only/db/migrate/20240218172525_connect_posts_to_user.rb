class ConnectPostsToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user
  end
end
