class Public::CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    @knowledge = Knowledge.new
    @knowledge.title = params[:category][:title]
    @knowledge.content = params[:category][:content]
    @knowledge.classification = params[:category][:classification]
    @category.save
    @category = Category.new
    render template: "public/knowledges/new"
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to edit_knowledge_path(params[:category][:knowledge_id].to_i)
    else
      @knowledge = Knowledge.find(params[:category][:knowledge_id].to_i)
      @categories = Category.all
      render edit_knowledge_path(params[:category][:knowledge_id].to_i)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
