class BlogsController < ApplicationController
  before_action :authenticate_user,  {only: [:index, :new, :create, :edit, :confirm, :update, :show, :destroy]}
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new

  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        flash[:notice] = "「#{@blog.title}」のブログを作成しました！"
        redirect_to blogs_path
      else
        render :new
      end
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  def show
    @comment = Comment.new(blog_id: @blog.id)
  end

  def edit
    @blog = Blog.find(params[:id])
     if @blog.user != current_user
        redirect_to blogs_path
     end
   end

  def update
    @blog.update(blog_params)
    flash[:success] = "「#{@blog.title}」のブログを編集しました！"
    redirect_to blogs_path
  end

  def destroy
    if @blog.user != current_user
       redirect_to blogs_path
    else
    @blog.delete
    flash[:danger] = "「#{@blog.title}」のブログを削除しました！"
    redirect_to blogs_path
    end
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :image, :image_cache)
  end


end
