class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def destroy
    @categories = Category.where(id: params[:categories])
    @categories.delete_all
    redirect_to admin_categories_path
  end
end
