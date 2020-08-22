class TodosController < ApplicationController
  skip_before_action :editor_required, only: [:index, :show]
  before_action :set_selected_todo, only: [:show, :edit, :update, :destroy]

  def index
    @q = set_my_todos.order(created_at: :desc).ransack(params[:q])
    @todos = @q.result(distinct: true).page(params[:page]).per(15)
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = set_my_todos.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Todo「#{@todo.name}」を登録しました。"
    else
      render :new
    end    
  end

  def edit
  end

  def update
    @todo.update(todo_params)
    redirect_to todos_url, notice: "Todo「#{@todo.name}」を編集しました。"
  end

  def destroy
    @todo.destroy!
    redirect_to todos_url, notice: "Todo「#{@todo.name}」を削除しました。"
  end

  private
    
    def todo_params
      params.require(:todo).permit(:name, :description, :category_id)
    end

    # 関係するcategoriesをsetする独自メソッドを作成
    def set_my_todos
      set_editor.todos
    end

    # 関係するtodosの中で、該当のtodoをsetする独自メソッドを作成
    def set_selected_todo
      @todo = set_my_todos.find(params[:id])
    end
end
