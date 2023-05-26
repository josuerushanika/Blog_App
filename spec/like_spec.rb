require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { Like.new(author_id: 1, post_id: 1) }

  it 'has an author id' do
    expect(like.author_id).to_not eql(5)
    expect(like.author_id).to eql(1)
  end

  it 'has a post id' do
    expect(like.post_id).to_not eql(-5)
    expect(like.post_id).to eql(1)
  end
   
  it 'increases likes_counter for the associated post' do
    User.new(name: 'Mert', photo: 'www.unsplash.com', bio: 'Lorem ipsum', posts_counter: 5)
  
    post = Post.new(author_id: 1, title: 'first post', text: 'this is the first post', comments_counter: 3, likes_counter: 2)
    post.save
  
    like = Like.new(author_id: 1, post: post)
    like.save
  
    like.increase_like_counter
  
    expect(post.likes_counter).to eq(3)
  end
  
 
end

