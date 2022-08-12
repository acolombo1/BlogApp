require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user1 = User.create(name: 'Juan', photo: 'http://www.photos.com/user1/photo2.jpg', bio: 'My bio', posts_counter: 0)
    @post1 = Post.new(author: @user1, title: 'Post 1', text: 'This is the first post')
    @post1.save
  end

  it 'likes_counter and comments_counter should be integers' do
    expect(@post1).to_not be_valid
  end

  it 'likes_counter and comments_counter should be = or greater than 0' do
    @post1.likes_counter = -1
    @post1.comments_counter = -1
    expect(@post1).to_not be_valid
  end

  it 'likes_counter and comments_counter are ok' do
    @post1.likes_counter = 0
    @post1.comments_counter = 0
    expect(@post1).to be_valid
  end

  it 'post1 title length should not exceed 250 chars' do
    @post1.likes_counter = 0
    @post1.comments_counter = 0
    @post1.title = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890\
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890\
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890\
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
    expect(@post1).to_not be_valid
  end

  it 'post1 should have a title' do
    @post1.likes_counter = 0
    @post1.comments_counter = 0
    @post1.title = nil
    expect(@post1).to_not be_valid
  end

  it 'post1 is valid with a title' do
    @post1.likes_counter = 0
    @post1.comments_counter = 0
    @post1.title = 'Title 1'
    expect(@post1).to be_valid
  end

  it 'method last_5_comments should return them' do
    @post1.likes_counter = 0
    @post1.comments_counter = 0
    @post1.save
    Comment.create(author: @user1, post: @post1, text: 'Text1')
    comment2 = Comment.create(author: @user1, post: @post1, text: 'Text2')
    comment3 = Comment.create(author: @user1, post: @post1, text: 'Text3')
    comment4 = Comment.create(author: @user1, post: @post1, text: 'Text4')
    comment5 = Comment.create(author: @user1, post: @post1, text: 'Text5')
    comment6 = Comment.create(author: @user1, post: @post1, text: 'Text6')
    expect(@post1.last_5_comments).to eq([comment6, comment5, comment4, comment3, comment2])
  end
end
