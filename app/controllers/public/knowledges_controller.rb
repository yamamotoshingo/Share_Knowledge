class Public::KnowledgesController < ApplicationController
  before_action :authenticate_user!, except: [:choose, :index, :show]
  def choose
  end

  def index
    if params[:search]
      @knowledges = Knowledge.where("searchtitle LIKE ? ",'%' + params[:search] + '%')
      @knowledges = @knowledges.where(classification: params[:classification].to_i).page(params[:page]).per(10)
      @knowledges_classification = Knowledge.where(classification: params[:classification].to_i)
    else
      if params[:categories_id]
        @knowledges = Knowledge.where(classification: params[:classification_number].to_i, category_id: params[:categories_id]).page(params[:page]).per(10)
        @knowledges_classification = Knowledge.where(classification: params[:classification].to_i)
      else
        @knowledges = Knowledge.where(classification: params[:classification].to_i).page(params[:page]).per(10)
        @knowledges_classification = Knowledge.where(classification: params[:classification].to_i)
      end
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    @search_categories = params[:search_categories]
    if @search_categories == ''
      @knowledges = Knowledge.where(classification: @knowledge.classification_before_type_cast)
    else
      @knowledges = Knowledge.where(classification: @knowledge.classification_before_type_cast, category_id: @search_categories)
    end
    @index = params[:index].to_i
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
    @categories = Category.all
    @category = Category.new
    @category = @knowledge.category
    @search_categories = params[:categoires_id]
    @index = params[:index].to_i
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
      redirect_to knowledge_path(@knowledge.id)
    else
      @categories = Category.all
      render :new
    end

  end

  def update
    @knowledge = Knowledge.find(params[:id])
    @knowledge.user_id = current_user.id
    if @knowledge.update(knowledge_params)
      redirect_to knowledge_path(@knowledge.id, search_categories: params[:knowledge][:categories_id], index: params[:knowledge][:index].to_i)
    else
      @categories = Category.all
      @category = Category.new
      @category = @knowledge.category
      render :edit
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.delete
    redirect_to knowledges_path(classification: params[:classification], categories_id: params[:categories_id])
  end

  private

  def knowledge_params
    params.require(:knowledge).permit(:classification, :title, :content, :image, :category_id)
  end
end
