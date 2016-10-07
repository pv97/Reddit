class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = params[:post_id]
    if comment.save
      redirect_to post_url(comment.post_id)
    else
      flash[:erros] = comment.errors.full_messages
      redirect_to post_url(comment.post_id)
    end
  end

  def nested_create
    flash["nc#{params[:id]}".to_sym] = true
    redirect_to post_url(params[:post_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    post_id = comment.post_id
    comment.destroy
    redirect_to post_url(post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id)
  end
end
