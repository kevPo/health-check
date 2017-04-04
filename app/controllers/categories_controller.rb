class CategoriesController < ApplicationController
  before_action :signed_in_user, only: [:index, :destroy]
  before_action :admin_user,     only: :destroy
  skip_before_action :verify_authenticity_token
  
  def new
    @category = Category.new
  end

  def index
    @categories = current_team.categories
    respond_to do |format|
      format.html
      format.json { render :json => @categories }
    end
  end

  def create
    @category = current_user.teams[0].categories.build(category_params)
    respond_to do |format|
      format.json do
        if @category.save
          render :json => @category
        else
          render :json => { :errors => @category.errors.messages }, :status => 422
        end
      end
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    head :no_content
  end

  private

  def category_params
    params.require(:category).permit(:name, :awesome, :crappy)
  end

  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless logged_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end