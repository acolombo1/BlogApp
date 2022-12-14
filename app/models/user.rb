class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :generate_api_token

  def admin?
    role == 'admin'
  end

  def last_3_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def generate_api_token
    self.api_token = Devise.friendly_token
    save
  end
end
