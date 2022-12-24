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
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.delete
    redirect_to knowledges_path
  end
end
