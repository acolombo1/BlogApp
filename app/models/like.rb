class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create do
    inc_post_likes_counter
  end

  def inc_post_likes_counter
    post.likes_counter.nil? ? post.update(likes_counter: 1) : post.update(likes_counter: post.likes_counter + 1)
  end
end
