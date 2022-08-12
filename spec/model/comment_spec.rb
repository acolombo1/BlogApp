require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user1 = User.create(name: 'Juan', photo: 'http://www.photos.com/user1/photo2.jpg', bio: 'My bio', posts_counter: 0)
    @post1 = Post.create(author: @user1, title: 'Post 1', text: 'This is the first post', likes_counter: 0,
                         comments_counter: 0)
  end

  it 'Adding a comment to post should increment its comments_counter' do
    counter = @post1.comments_counter
    Comment.create(author: @user1, post: @post1, text: 'Text1')
    expect(@post1.comments_counter).to eq(counter + 1)
  end
end
