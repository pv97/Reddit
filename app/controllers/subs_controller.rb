class SubsController < ApplicationController

  def create
    subb = Sub.new(sub_params)
    subb.moderator_id = current_user.id
    if subb.save
      redirect_to sub_url(subb)
    else
      flash[:errors] = subb.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def new
    @sub = Sub.new
    @current_user = current_user
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    subb = Sub.find(params[:id])
    if subb.update(sub_params)
      render :show
    else
      flash[:errors] = subb.errors.full_messages
      redirect_to edit_sub_url(params[:id])
    end
  end

  def destroy
    subb = Sub.find(params[:id])
    subb.destroy
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
