class CategoriesController < ApplicationController
  skip_before_action :editor_required, only: [:index, :show]
  before_action :set_selected_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = set_my_categiories
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = set_my_categiories.new(category_params)

    if @category.save
      redirect_to @category, notice: "Todo「#{@category.name}」を登録しました。"      
    else
      render :new
    end    
  end

  def edit
  end

  def update
    @category.update(category_params)
    redirect_to todos_url, notice: "カテゴリ「#{category.name}」を編集しました。"
  end

  def destroy
    @category.destroy!
    redirect_to todos_url, notice: "カテゴリ「#{@category.name}」を削除しました。"
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

    # 関係するcategoriesをsetする独自メソッドを作成
    def set_my_categiories
      set_editor.categories
    end

    # 関係するcategoriesの中で、該当のcategoryをsetする独自メソッドを作成
    def set_selected_category
      @category = set_editor.categories.find(params[:id])
    end

end
