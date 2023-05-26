class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
  
    after_create :increment_like_counter
  
    private
  
    def increment_like_counter
      self.post.increment!(:likes_counter)
    end
  end
  