class Admin::KnowledgesController < ApplicationController
  def index
    if params[:search]
      @knowledges = Knowledge.where("title LIKE ? OR content LIKE ?",'%' + params[:search] + '%', '%' + params[:search] + '%').page(params[:page]).per(10)
      @categories = Category.all
    else
      if params[:categories_search]
        @knowledges = Knowledge.where(category_id: params[:categories_search]).page(params[:page]).per(10)
        @categories = Category.all
      else
        @knowledges = Knowledge.all.page(params[:page]).per(10)
        @categories = Category.all
      end
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    @search_categories = params[:search_categories]
    @knowledges = Knowledge.where(category_id: @search_categories)
    @index = params[:index].to_i
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.delete
    @search_categories = params[:search_categories]
    redirect_to knowledges_path(categories_search: @search_categories)
  end
end
