require 'spec_helper'

RSpec.describe '4 URLs tests', type: :request do
  before(:all) do
    @user1 = User.create(name: 'Juan', photo: 'http://www.photos.com/user1/photo2.jpg', bio: 'My bio', posts_counter: 0)
    @post1 = Post.create(author: @user1, title: 'Post 1', text: 'This is the first post', likes_counter: 0,
                         comments_counter: 0)
  end

  it 'show the index page' do
    get '/users'
    expect(response).to have_http_status(200)
    expect(response).to render_template('users/index')
    expect(response.body).to include('list of users')
  end

  it 'show a user page' do
    get "/users/#{@user1.id}"
    expect(response).to have_http_status(200)
    expect(response).to render_template('users/show')
    expect(response.body).to include('info page for user XX')
  end

  it "show a user's posts" do
    get "/users/#{@user1.id}/posts"
    expect(response).to have_http_status(200)
    expect(response).to render_template('posts/index')
    expect(response.body).to include('list of posts for user XX')
  end

  it 'show a post' do
    get "/users/#{@user1.id}/posts/#{@post1.id}"
    expect(response).to have_http_status(200)
    expect(response).to render_template('posts/show')
    expect(response.body).to include('post NN from user XX')
  end
end
