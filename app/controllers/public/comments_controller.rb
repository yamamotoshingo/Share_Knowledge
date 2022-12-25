class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @comment = Comment.new
    @search_categories = params[:categories_id]
    @index = params[:index].to_i
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.knowledge_id = params[:knowledge_id].to_i
    if @comment.save
      redirect_to knowledge_path(@comment.knowledge_id, search_categories: params[:comment][:categories_id], index: params[:comment][:index].to_i )
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to knowledge_path(params[:knowledge_id], search_categories: params[:categories_id], index: params[:index].to_i)
  end

  private

  def comment_params
    params.require(:comment).permit(:rate, :content)
  end
end
