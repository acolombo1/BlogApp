class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_create do
    inc_author_posts_counter
  end

  def inc_author_posts_counter
    author.posts_counter.nil? ? author.update(posts_counter: 1) : author.update(posts_counter: author.posts_counter + 1)
  end
end
