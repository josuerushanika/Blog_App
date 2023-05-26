require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Josue', photo: 'www.unsplash.com', bio: 'Lorem ipsum', posts_counter: 5)

  it 'name is present' do
    expect(user).to be_valid
    expect(user.name).to eql 'Josue'
  end

  it 'should have a link for photo' do
    expect(user.photo).to_not eql ''
    expect(user.photo).to eql 'www.unsplash.com'
  end

  it 'should have a bio text' do
    expect(user.bio).to_not eql ''
    expect(user.bio).to eql 'Lorem ipsum'
  end

  it 'has a number greater than zero for the post counter' do
    user.posts_counter = -5
    expect(user).to_not be_valid
    expect(user.posts_counter).to eql(-5)
  end

  it 'brings last three posts for the user' do
    user = User.new(name: 'Mert', posts_counter: 0)
    user.save!

    user.posts.create!(title: 'Post 1', text: 'First post', likes_counter: 5, comments_counter: 2)
    user.posts.create!(title: 'Post 2', text: 'Second post', likes_counter: 5, comments_counter: 2)
    post3 = user.posts.create!(title: 'Post 3', text: 'Third post', likes_counter: 5, comments_counter: 2)
    post4 = user.posts.create!(title: 'Post 4', text: 'Fourth post', likes_counter: 5, comments_counter: 2)
    post5 = user.posts.create!(title: 'Post 5', text: 'Fifth post', likes_counter: 5, comments_counter: 2)

    expect(user.last_posts).to eq([post5, post4, post3])
  end
end
