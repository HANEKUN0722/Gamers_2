class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    # ストロングパラメーターを使用
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    # DBへ保存する
    if @game.save
      redirect_to game_path(@game.id) , notice: 'game was successfully created'
    else
      @games =Game.all
      render "index", notice:' error'
    end
  end

  def index
    if user_signed_in?
    @games = Game.all
    @game = Game.new
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if user_signed_in?
    @games = Game.find(params[:id])
    @game = Game.new

    else
      redirect_to new_user_session_path
    end
  end

  def edit

    @game = Game.find(params[:id])

      if user_signed_in? == true
        if current_user.id != @game.user_id.to_i
          redirect_to games_path
        end
      else
        redirect_to new_user_session_path
      end
end


  def update
    @game = Game.find(params[:id])
    if  @game.update(game_params)
      redirect_to game_path , notice: 'game was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
       # dbから削除する命令
    # リダイレクトする命令
    game = Game.find(params[:id]) #データ(レコード)を1件取得
    game.destroy #データ（レコード）を削除
    redirect_to games_path #List一覧画面へリダイレクト
  end

  private
  def game_params
    params.require(:game).permit(:title, :remarks,:user_id)
end
  def user_pramas
    params.require(:user).permit(:name, :introduction,:profile_image)
  end
end