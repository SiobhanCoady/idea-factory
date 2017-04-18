class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user

    if @idea.save
      redirect_to idea_path(@idea), notice: 'Idea created'
    else
      render :new
    end
  end

  def index
    @idea = Idea.new
    @ideas = Idea.all.order('id DESC')
  end

  def show
    @review = Review.new
  end

  def edit
    redirect_to root_path, alert: "Access denied" unless can? :edit, @idea
  end

  def update
    if !(can? :edit, @idea)
      redirect_to root_path, alert: 'Access denied'
    elsif @idea.update(idea_params)
      redirect_to idea_path(@idea), notice: 'Idea updated'
    else
      render :edit
    end
  end

  def destroy
    if can? :destroy, @idea
      @idea.destroy
      redirect_to ideas_path, notice: 'Idea deleted'
    else
      redirect_to root_path, alert: 'Access denied'
    end
  end

  def update_likes
    if user_signed_in?
      @idea = Idea.find params[:idea_id]
      if !session[:liked].include?(@idea.id)
        session[:liked].push(@idea.id)
        @idea.likes += 1
        @idea.save
        redirect_to root_path, notice: 'Idea liked'
      else
        redirect_to root_path, alert: 'You have already liked this idea'
      end
    else
      redirect_to root_path, alert: 'Must log in to like ideas'
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit([:title, :description])
  end
end
