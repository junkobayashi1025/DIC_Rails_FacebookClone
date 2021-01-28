class CommentsController < ApplicationController
  def create
     comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.blog
    else
    end
  end

  def destroy
     comment = Comment.find(params[:id])
     comment.delete
    flash[:danger] = 'コメントを削除しました'
    redirect_to comment.blog
  end

  private

  def comment_params
    params.require(:comment).permit(:blog_id, :name, :comment)
  end
end
