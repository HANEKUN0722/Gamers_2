class FavoritesController < ApplicationController

  before_action :set_game
  before_action :authenticate_user!

  def create
    if @game.user_id != current_user.id   # 投稿者本人以外に限定
      @favorite = Favorite.create(user_id: current_user.id, game_id: @game.id)
    end
  end
  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, game_id: @game.id)
    @favorite.destroy
  end

  private
  def set_game
    @game = Game.find(params[:game_id])
  end
end
