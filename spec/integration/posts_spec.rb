require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'Post index page' do
    before :each do
      @user = User.create(name: 'Bunny', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                          bio: 'Anyone in this world', posts_counter: 0)
      @user.save
      @post = Post.create(author: @user, title: 'Nonsense', text: 'This guy should stop spitting bullshit')
      @post.save
    end

    it 'should render the profile picture of the user' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it 'should render the username' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_content(@user.name)
    end

    it 'should render the number of posts written by the user' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_content(@user.posts_counter)
    end

    it 'should render the title of the post' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_content(@post.title)
    end

    it 'should render the trimmed text of the post' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_content(@post.text.truncate(40))
    end

    it 'should render the first comment of a post' do
      comment = Comment.create(author: @user, post: @post, text: 'This is a comment')
      comment.save
      visit user_post_path(user_id: @user.id, id: @post.id)
      expect(page).to have_content(comment.text)
    end

    it 'should render the number of comments of a post' do
      comment = Comment.create(author: @user, post: @post, text: 'This is a comment')
      comment.save
      visit user_post_path(user_id: @user.id, id: @post.id)
      expect(page).to have_content(@post.comments_counter)
    end

    it 'should render the number of likes of a post' do
      like = Like.create(author: @user, post: @post)
      like.save
      visit user_post_path(user_id: @user.id, id: @post.id)
      expect(page).to have_content(@post.likes_counter)
    end

    it 'should render a button pagination' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_css('.pagination-btn')
    end

    it 'should redirect to the post show page' do
      visit user_posts_path(user_id: @user.id)
      click_link @post.title
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end

  describe 'Post show page' do
    before(:each) do
      @user = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Life science',
                          posts_counter: 0)
      @user.save
      @postone = Post.create(title: 'something', text: 'hello', author: @user, comments_counter: 0, likes_counter: 0)
      @posttwo = Post.create(title: 'cool', text: 'world', author: @user, comments_counter: 0, likes_counter: 0)
      @comment1 = Comment.create(text: 'hello world', author: @user, post: @postone)
      @comment2 = Comment.create(text: 'this is amazing', author: @user, post: @postone)
      @likeone = Like.new(author: @user, post: @postone)
      @liketwo = Like.new(author: @user, post: @posttwo)
    end

    it 'show post title' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@postone.title)
    end

    it 'should show who wrote the post' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@postone.author.name)
    end

    it 'show how many comment post has' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@postone.comments_counter)
    end

    it 'show how many likes post has' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@postone.likes_counter)
    end

    it 'should show post body' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@postone.text)
    end

    it 'should show username of each commenter' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@comment1.author.name)
      expect(page).to have_content(@comment2.author.name)
    end

    it 'shows the comment of each commenter' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
  end
end
