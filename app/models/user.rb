class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable

  has_many :games, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # フォロー関連
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  # DM関連
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # お気に入り関連
  has_many :favorites, dependent: :destroy

  attachment :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, presence: { message: 'error,enter your name 2 to 20 characters' }
  validates :introduction, length: { maximum: 50 }

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

end
