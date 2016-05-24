class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index, :archives]
  before_filter :nav_post_month, :only => :read
  load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    nav_post_month
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    nav_post_month
    @post = Post.find(params[:id])
    @comments = @post.comments.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    @comment = Comment.new
    @comment.post_id = @post.id
    @comment.user = current_user
  end

  # GET /posts/new
  def new
    nav_post_month
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    nav_post_month
  end

  # POST /posts
  # POST /posts.json
  def create
    nav_post_month
    @post = Post.new(post_params)
    @post.user = current_user
    @post.author = "#{current_user.first_name} #{current_user.last_name}"

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    nav_post_month
    @post.author = "#{current_user.first_name} #{current_user.last_name}"

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    nav_post_month
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def archives
    nav_post_month
    @archive_post_months = Post.all.order('created_at DESC').group_by { |t| t.created_at.beginning_of_month }
  end

  private
    def nav_post_month
      @post_months = Post.all.limit(8).order('created_at DESC').group_by { |t| t.created_at.beginning_of_month }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body, :picture)
    end
end
