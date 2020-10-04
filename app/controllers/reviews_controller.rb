class ReviewsController < ApplicationController

  def create
  	game = Game.find(params[:game_id])
    review  = current_user.reviews.new(review_params)
    review.game_id = game.id
    review.save
    redirect_back(fallback_location: root_path)
  end


  def destroy
	Review.find_by(id: params[:id], game_id: params[:game_id]).destroy
	redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end

end
