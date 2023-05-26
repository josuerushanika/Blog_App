class ChangeLikeUserToAuthorReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :user, index: true, foreign_key: true
    add_reference :likes, :author, null: false, foreign_key: { to_table: :users }, index: true
  end
end
