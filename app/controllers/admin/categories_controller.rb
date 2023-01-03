class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def destroy
    @categories = Category.where(id: params[:categories])
    @categories.destroy_all
    redirect_to admin_categories_path
  end
end
