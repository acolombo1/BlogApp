class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  validates :title, presence: true
  validates :text, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_5_comments
    comments.order(created_at: :desc).limit(5).reverse
  end

  after_create do
    inc_author_posts_counter
  end

  after_destroy do
    dec_author_posts_counter
  end

  def inc_author_posts_counter
    author.posts_counter.nil? ? author.update(posts_counter: 1) : author.update(posts_counter: author.posts_counter + 1)
  end

  def dec_author_posts_counter
    if author.posts_counter.zero?
      author.update(posts_counter: 0)
    else
      author.update(posts_counter: author.posts_counter - 1)
    end
  end
end
