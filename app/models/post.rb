class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_author_posts_counter
    author.increment!(:posts_counter)
  end
end
