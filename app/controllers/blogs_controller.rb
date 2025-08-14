class BlogsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authorize_blog!, only: %i[ edit update destroy ]

  def index
    @blogs = Blog.ordered
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to @blog, notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity, notice: "Failed to create blog."
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog was successfully updated."
    else
      render :edit, status: :unprocessable_entity, notice: "Failed to update blog."
    end
  end

  def destroy
    @blog.destroy
    redirect_to @blog, notice: "Blog deleted."
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :author, :image, :content)
    end

    def authorize_blog!
      return if current_user&.admin? || @blog.user_id == current_user&.id
      redirect_to @blog, alert: "Not authorized."
    end
end