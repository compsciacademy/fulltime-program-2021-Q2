class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_params)
    if @comment.save
      redirect_to [@discussion.project, @discussion], notice: "Comment Created"
    else
      render project_discussion_path([@discussion.project, @discussion])
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
