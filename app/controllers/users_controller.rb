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
    @user = User.find(params[:id])
    @users =User.all
    @games = @user.games
    @game = Game.new
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
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

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def game_params
    params.require(:game).permit(:title, :remarks)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
