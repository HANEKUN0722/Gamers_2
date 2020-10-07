class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates_uniqueness_of :game_id, scope: :user_id
end
