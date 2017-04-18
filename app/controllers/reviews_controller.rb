class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @idea = Idea.find(params[:idea_id])
    review_params = params.require(:review).permit(:body)
    @review = @idea.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea), notice: 'Review created!'
    else
      render '/ideas/show'
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to idea_path(review.idea), notice: 'Review deleted'
  end
end
