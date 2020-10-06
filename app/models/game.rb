class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :title, presence: true,presence: { message: 'error,blank' }
  validates :remarks, length: { minimum: 1,maximum: 200 }, presence: { message: 'error,enter your opinion 1 to 200 characters' }

  #検索機能
  def self.search(search)
    return Game.all unless search
    Game.where(['title LIKE ?', "%#{search}%"])
  end
end
