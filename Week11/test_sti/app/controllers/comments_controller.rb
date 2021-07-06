class CommentsController < ApplicationController
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_params)
    if @comment.save
      redirect_to @discussion, notice: "Comment Created"
    else
      render discussion_path(@discussion)
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
