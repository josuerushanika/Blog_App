require 'rails_helper'

describe 'Posts', type: :request do
  describe 'GET all posts for the user' do
    it 'checks whether it brings successful response' do
      get user_posts_path(:user_id)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get user_posts_path(:user_id)
      expect(response).to render_template(:index)
    end

    it 'displays the body paragraph for users' do
      get user_posts_path(:user_id)
      expect(response.body).to include(' <h1>Route for list of post</h1>')
    end
  end

  describe 'GET specific post for the user' do
    user = User.create!(name: 'Mert', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
    post = Post.create!(title: 'Test Post', author_id: user.id, comments_counter: 3, likes_counter: 5)

    it 'checks whether it brings successful response' do
      get user_posts_path(user_id: user.id, id: post.id)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'displays the body paragraph for users' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('<h1>Route for specific post id</h1>')
    end
  end
end
