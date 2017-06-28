class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :admin_or_user, only: [:destroy]
  before_action :only_user, only: [:edit, :update]

  def index
    
    
       @posts = Post.paginate(:page => params[:page], :per_page => 5)

  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post #post_path(@post)
    else
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to :back
    end
  end

  def destroy
    if @post.destroy
      redirect_to :posts #posts_path랑 같아요
    else
      redirect_to :back
    end
    
   
  end
  
  def admin_or_user
    unless current_user.has_role?(:admin) or @post.user == current_user
      redirect_to :back
    end
  end

    def only_user
    unless @post.user == current_user
      redirect_to :back
    end
    end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end