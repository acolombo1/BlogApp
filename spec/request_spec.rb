require 'spec_helper'

RSpec.describe '4 URLs tests', type: :request do
  it 'show the index page' do
    get '/users'
    expect(response).to have_http_status(200)
    expect(response).to render_template('users/index')
    expect(response.body).to include('list of users')
  end

  it 'show a user page' do
    get '/users/745'
    expect(response).to have_http_status(200)
    expect(response).to render_template('users/show')
    expect(response.body).to include('info page for user XX')
  end

  it "show a user's posts" do
    get '/users/745/posts'
    expect(response).to have_http_status(200)
    expect(response).to render_template('posts/index')
    expect(response.body).to include('list of posts for user XX')
  end

  it 'show a post' do
    get '/users/745/posts/3'
    expect(response).to have_http_status(200)
    expect(response).to render_template('posts/show')
    expect(response.body).to include('post NN from user XX')
  end
end
