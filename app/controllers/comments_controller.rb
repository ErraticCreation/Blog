class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author_name = "#{current_user.first_name} #{current_user.last_name}"

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@comment.post), notice: 'Comment was successfully created.' }
        format.json { head :no_content }
      else
        format.html { redirect_to post_path(@comment.post), alert: "Comment wasn't created successfully."  }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end

  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :body)
    end

end
