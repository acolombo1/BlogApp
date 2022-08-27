class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create do
    inc_post_comments_counter
  end

  after_destroy do
    dec_post_comments_counter
  end

  def dec_post_comments_counter
    if post.comments_counter.zero?
      post.update(comments_counter: 0)
    else
      post.update(comments_counter: post.comments_counter - 1)
    end
  end

  def inc_post_comments_counter
    if post.comments_counter.nil?
      post.update(comments_counter: 1)
    else
      post.update(comments_counter: post.comments_counter + 1)
    end
  end

  def as_json(_options = {})
    super(only: %i[author_id text])
  end
end
