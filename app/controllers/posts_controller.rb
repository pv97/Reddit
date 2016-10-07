class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @comments = Hash.new { |h,k| h[k]=[] }
    @post.comments.includes(:user).each do |comment|
      if comment.parent_id.nil?
        @comments[0] << comment
      else
        @comments[comment.parent_id] << comment
      end
    end

  end

  def index
    @posts = Post.all
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to edit_post_url(params[:id])
    end
  end

  def destroy
    post = Post.find(params[:id])
    sub_id = post.sub_id
    post.destroy
    redirect_to sub_url(sub_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end
end
