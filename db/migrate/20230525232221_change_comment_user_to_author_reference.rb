class ChangeCommentUserToAuthorReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :user, index: true, foreign_key: true
    add_reference :comments, :author, null: false, foreign_key: { to_table: :users }, index: true
  end
end
