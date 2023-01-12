class Public::KnowledgesController < ApplicationController
  before_action :authenticate_user!, except: [:choose, :index, :show]
  def choose
  end

  def index
    if params[:search]
      @knowledges = Knowledge.where("title LIKE ?  OR content LIKE ?", '%' + params[:search] + '%', '%' + params[:search] + '%')
      @knowledges = @knowledges.where(classification: params[:classification].to_i).page(params[:page]).per(10)
      @knowledges_classification = Knowledge.where(classification: params[:classification].to_i)
    else
      if params[:categories_id] && params[:categories_id] != "0"
        @knowledges = Knowledge.where(classification: params[:classification].to_i, category_id: params[:categories_id]).page(params[:page]).per(10)
        @knowledges_classification = Knowledge.where(classification: params[:classification].to_i)
      else
        @knowledges = Knowledge.where(classification: params[:classification].to_i).page(params[:page]).per(10)
        @knowledges_classification = Knowledge.where(classification: params[:classification].to_i)
      end
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    if params[:search_categories] == "0"
      @search_categories = params[:search_categories].to_i
    else
      @search_categories = params[:search_categories]
    end
    if @search_categories == 0
      @knowledges = Knowledge.where(classification: @knowledge.classification_before_type_cast)
    else
      @knowledges = Knowledge.where(classification: @knowledge.classification_before_type_cast, category_id: @search_categories)
    end
    @index = params[:index].to_i
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
    if @knowledge.user_id == current_user.id
      @categories = Category.all
      @category = Category.new
      @category = @knowledge.category
      @search_categories = params[:categories_id]
      @index = params[:index].to_i
    else
      redirect_to knowledge_path(@knowledge.id, search_categories: 0, index: -1)
    end
  end

  def new
    @knowledge = Knowledge.new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @knowledge = Knowledge.new(knowledge_params)
    @knowledge.user_id = current_user.id
    if @knowledge.save
      @classification_num = Knowledge.where(classification: @knowledge.classification_before_type_cast).count
      @index = @classification_num - 1
      redirect_to knowledge_path(@knowledge.id, search_categories: 0, index: @index)
    else
      @categories = Category.all
      render :new
    end

  end

  def update
    @knowledge = Knowledge.find(params[:id])
    @knowledge.user_id = current_user.id
    if @knowledge.update(knowledge_params)
      redirect_to knowledge_path(@knowledge.id, search_categories: params[:knowledge][:search_categories_id], index: params[:knowledge][:index].to_i)
    else
      @categories = Category.all
      @category = Category.new
      @category = @knowledge.category
      render :edit
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to knowledges_path(classification: params[:classification], categories_id: params[:categories_id])
  end

  private

  def knowledge_params
    params.require(:knowledge).permit(:classification, :title, :content, :image, :category_id)
  end
end
