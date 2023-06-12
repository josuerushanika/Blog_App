require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  describe 'posts\index' do
    before(:each) do
      @user1 = User.create(name: 'some name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 1.')
      @user2 = User.create(name: 'some other name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 2.')
      @user3 = User.create(name: 'some other other name', photo: 'https://bit.ly/3ILKEv7',
                           bio: 'Isome bio for user 3.')

      @post1 = Post.create(title: 'Post 1', text: 'some post 1 .', author: @user1)
      @post2 = Post.create(title: 'post2', text: 'some post 2 .', author: @user1)
      @post3 = Post.create(title: 'post3', text: 'some post 3 .', author: @user1)
      @post4 = Post.create(title: 'post4', text: 'some post 5 .', author: @user3)
      @post5 = Post.create(title: 'post5', text: 'some post 5 .', author: @user2)

      @comment1 = Comment.create(text: 'first comment', author: @user3, post: @post2)
      @comment2 = Comment.create(text: 'ssecond comment', author: @user3, post: @post2)
      @comment3 = Comment.create(text: 'third comment', author: @user3, post: @post2)
      @comment4 = Comment.create(text: 'fourth comment', author: @user2, post: @post1)
      @comment5 = Comment.create(text: 'fifth comment',author: @user3, post: @post2)
    end

    it 'shuould have user1\'s profile picture' do
      visit user_posts_path(@user1)
      expect(page).to have_css("img[src*=\"#{@user1.photo}\"]")
    end
    it 'shuoul gave user 1 present' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@user1.name)
    end
    it 'Shows the right number of posts' do
      visit user_posts_path(@user1)
      expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    end

    it 'Shows the right number of   comment' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post1.comments_counter)
    end
    it 'Shows the right no of comment' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post2.comments_counter)
    end

    it 'Shows the right no of likes' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post2.likes_counter)
    end

    it 'Shows the pagination' do
      visit user_posts_path(@user1)
      expect(page).to have_content('Pagination')
    end

    it 'Should redirect to user post show page' do
      visit user_posts_path(@user1)
      click_link(@post2.title)
      expect(page).to have_current_path(user_post_path(@post2.author, @post2))
    end
  end

  describe 'posts\show' do
    before(:each) do
      @user1 = User.create(name: 'some name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 1.')
      @user2 = User.create(name: 'some other name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 2.')
      @user3 = User.create(name: 'some other other name', photo: 'https://bit.ly/3ILKEv7', bio: 'Isome bio for user 3.')

      @post1 = Post.create(title: 'Post 1', text: 'some post 1 .', author: @user1)
      @post2 = Post.create(title: 'post2', text: 'some post 2 .', author: @user1)
      @post3 = Post.create(title: 'post3', text: 'some post 3 .', author: @user1)
      @post4 = Post.create(title: 'post4', text: 'some post 5 .', author: @user3)
      @post5 = Post.create(title: 'post5', text: 'some post 5 .', author: @user2)

      @comment1 = Comment.create(text: 'first comment', author: @user3, post: @post2)
      @comment2 = Comment.create(text: 'ssecond comment', author: @user3, post: @post2)
      @comment3 = Comment.create(text: 'third comment', author: @user3, post: @post2)
      @comment4 = Comment.create(text: 'fourth comment', author: @user2, post: @post1)
      @comment5 = Comment.create(text: 'fifth comment', author: @user3, post: @post2)
    end
    it 'test to see a POST TITLE' do
      visit user_post_path(@post2.author, @post2)
      expect(page).to have_content(@post2.title)
    end
    it 'test to see a POST BODY' do
      visit user_post_path(@post2.author, @post2)
      expect(page).to have_content(@post2.text)
    end

    it 'shuoul gave user 1 present as  the user who wrote it' do
      visit user_post_path(@post2.author, @post2)
      expect(page).to have_content(@user1.name)
    end

    it 'Shows the right no of comment' do
      visit user_post_path(@post2.author, @post2)
      expect(page).to have_content(@post2.comments_counter)
    end
    it 'Shows the right no of likes' do
      visit user_post_path(@post2.author, @post2)
      expect(page).to have_content(@post2.likes_counter)
    end

    it 'Shows thepost body' do
      visit user_post_path(@post2.author, @post2)
      expect(page).to have_content(@post2.text)
    end

    it 'displays the username and comment text of each commenter' do
      visit user_post_path(@post2.author, @post2)

      @post2.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
        expect(page).to have_content(comment.text)
      end
    end
  end
end
