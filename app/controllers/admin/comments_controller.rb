class Admin::CommentsController < ApplicationController
  def index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    @search_categories = params[:search_categories]
    @index = params[:index].to_i
    redirect_to admin_knowledge_path(params[:knowledge_id], search_categories: @search_categories, index: @index)
  end
end
