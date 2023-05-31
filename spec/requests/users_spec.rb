require 'rails_helper'

describe 'Users', type: :request do
  describe 'GET all users' do
    it 'checks whether it brings a successful response' do
      get '/users'

      expect(response).to be_successful
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'displays the body paragraph for users' do
      get '/users'
      expect(response.body).to include(' <h1>Router for all users </h1>')
    end
  end

  describe 'GET specific user' do
    user = User.create!(name: 'Josue', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)

    it 'checks whether it brings a successful response' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'displays the body paragraph for specific user' do
      get "/users/#{user.id}"
      expect(response.body).to include('<h1> Routes for a specific user with id</h1>')
    end
  end
end
