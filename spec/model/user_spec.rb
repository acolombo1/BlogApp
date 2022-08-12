require 'rails_helper'

RSpec.describe User, type: :model do
  # tests go here
  before do
    @user1 = User.new(name: 'Juan', photo: 'http://www.photos.com/user1/photo2.jpg', bio: 'My bio')
    @user1.save
  end

  it 'posts_counter should be an integer' do
    expect(@user1).to_not be_valid
  end

  it 'posts_counter should be = or greater than 0' do
    @user1.posts_counter = -1
    expect(@user1).to_not be_valid
  end

  it 'posts_counter is ok' do
    @user1.posts_counter = 0
    expect(@user1).to be_valid
  end

  it 'user1 should have a name' do
    @user1.posts_counter = 0
    @user1.name = nil
    expect(@user1).to_not be_valid
  end

  it 'method last_3_posts should return them' do
    @user1.posts_counter = 0
    @user1.save
    Post.create(author: @user1, title: 'Title1', text: 'Text1', comments_counter: 0, likes_counter: 0)
    post2 = Post.create(author: @user1, title: 'Title2', text: 'Text2', comments_counter: 0, likes_counter: 0)
    post3 = Post.create(author: @user1, title: 'Title3', text: 'Text3', comments_counter: 0, likes_counter: 0)
    post4 = Post.create(author: @user1, title: 'Title4', text: 'Text4', comments_counter: 0, likes_counter: 0)
    expect(@user1.last_3_posts).to eq([post4, post3, post2])
  end

  it 'Adding a post to user should increment its posts_counter' do
    @user1.posts_counter = 0
    @user1.save
    counter = @user1.posts_counter
    Post.create(author: @user1, title: 'Title1', text: 'Text1', comments_counter: 0, likes_counter: 0)
    expect(@user1.posts_counter).to eq(counter + 1)
  end
end
