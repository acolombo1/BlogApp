class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: 'posts_counter'
  has_many :comments
  has_many :likes
  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end
end
