require 'rails_helper'

RSpec.describe 'Main (users) page.', type: :system do
  subject!(:tom) { User.where(name: 'Tom').first }

  before(:all) do
    driven_by(:selenium_chrome_headless)
    Rails.application.load_seed
  end

  it 'Shows all users' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
  end

  it 'Shows the profile picture of all users' do
    visit('http://localhost:3000/')
    image = page.all('img')
    expect(image.size).to eq(2)
  end

  it 'Shows the number of posts for each user' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Number of posts: 0')
    expect(page).to have_content('Number of posts: 4')
  end

  it 'Click on a user redirects to his show page' do
    visit('http://localhost:3000/')
    click_link('Tom')
    expect(page).to have_current_path user_path(tom.id)
    expect(page).to have_content(tom.bio)
  end
end

RSpec.describe 'User Show page.', type: :system do
  subject!(:tom) { User.where(name: 'Tom').first }
  subject!(:post) { Post.all.last }

  before(:all) do
    driven_by(:selenium_chrome_headless)
  end

  it 'Shows username' do
    visit("http://localhost:3000/users/#{tom.id}/")
    expect(page).to have_content('Tom')
  end

  it 'Shows picture' do
    visit("http://localhost:3000/users/#{tom.id}/")
    expect(page.all('img').size).to eq(1)
  end

  it 'Shows number of posts and bio' do
    visit("http://localhost:3000/users/#{tom.id}/")
    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content(tom.bio)
  end

  it 'Shows the first 3 posts' do
    visit("http://localhost:3000/users/#{tom.id}/")
    posts = page.all('.onepost')
    expect(posts.size).to eq(3)
  end

  it 'Shows button that leads to the user\'s posts' do
    visit("http://localhost:3000/users/#{tom.id}/")
    link = find_link('See all posts', href: "/users/#{tom.id}/posts")
    expect(link).not_to be_nil
  end

  it 'When a post is clicked it redirects to that post page' do
    visit("http://localhost:3000/users/#{tom.id}/")
    click_link(post.title)
    expect(page).to have_current_path "http://localhost:3000/users/#{tom.id}/posts/#{post.id}"
  end

  it 'When See all posts is clicked it redirects to the users\' posts page' do
    visit("http://localhost:3000/users/#{tom.id}/")
    click_link('See all posts')
    expect(page).to have_current_path "http://localhost:3000/users/#{tom.id}/posts"
  end
end

RSpec.describe 'Posts page.', type: :system do
  subject!(:tom) { User.where(name: 'Tom').first }

  before(:all) do
    driven_by(:selenium_chrome_headless)
  end

  it 'Shows username' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Tom')
  end

  it 'Shows profile picture' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    image = page.all('img')
    expect(image[0]['src']).to eq('https://acolombo1.github.io/Portfolio/foto1.jpg')
  end

  it 'Show the number of posts the user has written.' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Number of posts: 4') 
  end

  it 'Show a posts title' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Hello')
  end

  it 'Show some of the posts body' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('This is my first post')
  end

  it 'show the first comments on a post' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Hi, how are you?')
  end

  it 'Show how many comments a post has' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Comments: 6')
  end

  it 'Show how many likes a post has' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Likes: 0')
  end
  
  it 'section for pagination if there are more posts than fit on the view' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    expect(page).to have_content('Pagination')
  end
  
  it 'When I click on a post, it redirects me to that posts show page' do
    visit("http://localhost:3000/users/#{tom.id}/posts")
    click_link('Hello')
    expect(page).to have_content('Hello by Tom')
  end
end

RSpec.describe 'Posts page.', type: :system do
  subject!(:tom) { User.where(name: 'Tom').first }
  subject!(:post) { Post.where(author_id: 1).first}

  before(:all) do
    driven_by(:selenium_chrome_headless)
  end
  
  it 'Show posts title' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('Hello by Tom')
  end

  it 'Show who wrote the post' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('by Tom')
  end

  it 'Show many comments it has' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('Comments: 6')
  end

  it 'Show many likes it has' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('Likes: 0')
  end

  it 'Show post body' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('This is my first post')
  end

  it 'show username of each commentor' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('Lilly: ')
    expect(page).to have_content('Tom: ')
  end

  it 'show comment each commentor left' do
    visit("http://localhost:3000/users/#{tom.id}/posts/#{post.id}")
    expect(page).to have_content('Hi Tom!')
    expect(page).to have_content('Hi, how are you?')
  end
end
