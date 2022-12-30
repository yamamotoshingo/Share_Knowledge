class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search] && params[:search] != ""
      @users = User.where("nickname LIKE ? ",'%' + params[:search] + '%')
      @knowledges = Knowledge.where("title LIKE ? ",'%' + params[:search] + '%')
      @comments = Comment.where("user_id = ? or knowledge_id = ?", @users.pluck(:id), @knowledges.pluck(:id)).page(params[:page]).per(10)
    else
      @comments = Comment.all.page(params[:page]).per(10)
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    @search_categories = params[:search_categories]
    @index = params[:index].to_i
    redirect_to admin_knowledge_path(params[:knowledge_id], search_categories: @search_categories, index: @index)
  end

  def destroy_all
    @comments = Comment.where(id: params[:comment])
    @comments.delete_all
    redirect_to admin_comments_path
  end
end
