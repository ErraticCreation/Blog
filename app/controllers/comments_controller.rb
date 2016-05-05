class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]

    @comment.save

    respond_to do |format|
      format.html { redirect_to post_path(@comment.post), notice: 'Comment was successfully created.' }
      format.json { head :no_content }
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
      params.require(:comment).permit(:author_name, :body)
    end

end
