class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # Index action for listing posts and handling search
  def index
    @q = Post.ransack(params[:q])
    
    # Set the page number and posts per page
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @per_page = 6
    
    # Calculate total posts and apply offset and limit
    @total_posts = @q.result.count
    @posts = @q.result.includes(:user)
                .offset((@page - 1) * @per_page)
                .limit(@per_page)
  end


  # New action for displaying the post creation form
  def new
    @post = Post.new
  end

  # Show action for displaying a single post's details
  def show
  end

  # Edit action for displaying the post edit form
  def edit
  end

  # Create action for saving a new post to the database
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # Update action for saving changes to an existing post
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # Destroy action for deleting a post
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  # Set post for show, edit, update, and destroy actions
  def set_post
    @post = Post.find(params[:id])
  end

  # Strong parameter method for post attributes
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
