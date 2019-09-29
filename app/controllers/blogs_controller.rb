class BlogsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    @blogs = Blog.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @blog=Blog.new
  end

  def show
    @blog=Blog.find(params[:id])
  end

  def create
    # binding.pry
    Blog.create(title: test_params[:title], text: test_params[:text], user_id: current_user.id)
    # user_id: current_user.idがなかったら保存できない！
    # binding.pry
    redirect_to action: :index
  end

  def edit
    @blog=Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      # binding.pry
      blog.update(update_params)
      redirect_to action: :index
    end
  end

  def destroy
    blog=Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.destroy
      render 'destroy'
    end
  end



  def move_to_index
    redirect_to action: :index  unless user_signed_in?
  end 

  private
  def test_params
    params.require(:blog).permit(:title, :text)
    # binding.pry
  end

  def update_params
    params.permit(:title, :text)
  end

end
