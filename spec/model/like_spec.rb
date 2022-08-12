require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user1 = User.create(name: 'Juan', photo: 'http://www.photos.com/user1/photo2.jpg', bio: 'My bio', posts_counter: 0)
    @post1 = Post.create(author: @user1, title: 'Post 1', text: 'This is the first post', likes_counter: 0,
                         comments_counter: 0)
  end

  it 'Adding a like to post should increment its likes_counter' do
    counter = @post1.likes_counter
    Like.create(author: @user1, post: @post1)
    expect(@post1.likes_counter).to eq(counter + 1)
  end
end
