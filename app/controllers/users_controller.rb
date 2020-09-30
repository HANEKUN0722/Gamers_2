class UsersController < ApplicationController

  def index
    if user_signed_in?
    @users = User.all
    @game = Game.new
    else
      redirect_to new_user_session_path
    end
  end


  def show
    if user_signed_in?

    @user = User.find(params[:id])
    @users =User.all
    @games = @user.game
    @game = Game.new

    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if @user = User.find(params[:id])

      if user_signed_in? == true
        if current_user.id != @user.id
          redirect_to user_path(current_user)
        end
      else
        redirect_to new_user_session_path
      end

    else
      redirect_to new_user_session_path
    end
  end

  def update
    @user = User.find(params[:id])
  if  @user.update(user_params)
    redirect_to user_path , notice: 'Your information was successfully updated.'
  else

    render "edit"
  end
  end

  private
  def game_params
    params.require(:game).permit(:title, :remarks)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
