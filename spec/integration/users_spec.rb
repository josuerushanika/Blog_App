require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'users\index' do
    before(:each) do
      @user1 = User.create(name: 'ted lasso', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 1.')
      @user2 = User.create(name: 'some other name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 2.')
      @user3 = User.create(name: 'some other other name', photo: 'https://bit.ly/3ILKEv7',
                           bio: 'Isome bio for user 3.')

      @post1 = Post.create(title: 'Post 1', text: 'some post 1 .', author: @user1)
      @post2 = Post.create(title: 'post2', text: 'some post 2 .', author: @user1)
      @post3 = Post.create(title: 'post3', text: 'some post 3 .', author: @user1)
      @post4 = Post.create(title: 'post4', text: 'some post 4 .', author: @user1)
      @post5 = Post.create(title: 'post5', text: 'some post 5 .', author: @user1)
      @post6 = Post.create(title: 'post6', text: 'some post 6 .', author: @user1)
    end

    it 'shuoul gave user 1 present' do
      visit users_path
      expect(page).to have_content(@user1.name)
    end

    it 'shuould have user1\'s profile picture' do
      visit users_path
      expect(page).to have_css("img[src*=\"#{@user1.photo}\"]")
    end
    it 'shuould have user2\'s profile picture' do
      visit users_path
      expect(page).to have_css("img[src*=\"#{@user2.photo}\"]")
    end
    it 'shuould have user2\'s profile picture' do
      visit users_path
      expect(page).to have_css("img[src*=\"#{@user3.photo}\"]")
    end

    it 'Shows the number of a  posts for user 1' do
      visit users_path
      expect(page).to have_content(@user1.posts_counter)
    end
    it 'Shows the number of a  posts for user 2' do
      visit users_path
      expect(page).to have_content(@user2.posts_counter)
    end
    it 'Shows the number of a  posts for user 3' do
      visit users_path
      expect(page).to have_content(@user3.posts_counter)
    end

    it 'Should redirect to user show page' do
      visit users_path
      click_link(@user1.name)
      expect(page).to have_current_path(user_path(@user1))
    end
  end
end
describe 'user\show' do
  before(:each) do
    @user1 = User.create(name: 'some name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 1.')
    @user2 = User.create(name: 'some other name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 2.')
    @user3 = User.create(name: 'some other other name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 3.')

    @post1 = Post.create(title: 'Post1', text: 'some post 1 .', author: @user1)
    @post2 = Post.create(title: 'post2', text: 'some post 2 .', author: @user1)
    @post3 = Post.create(title: 'post3', text: 'some post 3 .', author: @user2)
    @post4 = Post.create(title: 'post4', text: 'some post 4 .', author: @user1)
    @post5 = Post.create(title: 'post5', text: 'some post 5 .', author: @user1)
    @post6 = Post.create(title: 'post6', text: 'some post 6 .', author: @user1)
  end

  describe 'user\show' do
    before do
      @user1 = User.create(name: 'John Doe')
      @user2 = User.create(name: 'Jane Smith')
      @post1 = Post.create(user: @user1, title: 'Post 1', text: 'This is post 1')
      @post2 = Post.create(user: @user1, title: 'Post 2', text: 'This is post 2')
      @post3 = Post.create(user: @user2, title: 'Post 3', text: 'This is post 3')
    end

    it 'Shows the right number of posts' do
      visit user_path(@user1)
      expect(page).to have_content('Number of posts: 2')
    end
  end

  it 'Should redirect to user posts page' do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user1))
  end
end
