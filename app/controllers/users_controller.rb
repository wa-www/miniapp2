class UsersController < ApplicationController

  def show
    @name=current_user.name
    # @blogs=Blog.where(user_id:current_user.id.page(params[:page]).per(5).order("created_at DESC"))
    @blogs=Blog.where(user_id:current_user.id).order("created_at DESC")
    @blogs=Kaminari.paginate_array(@blogs).page(params[:page]).per(5)
    
  end

end
