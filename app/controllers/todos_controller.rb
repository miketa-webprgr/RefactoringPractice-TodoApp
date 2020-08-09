class TodosController < ApplicationController
  def index
    @todos = current_user.todos
  end

  def show
    @todo = current_user.todos.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.new(todo_params)

    if @todo.save
    redirect_to @todo, notice: "Todo「#{@todo.name}」を登録しました。"      
    else
      render :new
    end    
  end

  def edit
    @todo = current_user.todos.find(params[:id])
  end

  def update
    todo = current_user.todos.find(params[:id])
    todo.update!(todo_params)
    redirect_to todos_url, notice: "Todo「#{todo.name}」を編集しました。"
  end

  def destroy
    todo = current_user.todos.find(params[:id])
    todo.destroy
    redirect_to todos_url, notice: "Todo「#{todo.name}」を削除しました。"
  end

  private
    
    def todo_params
      params.require(:todo).permit(:name, :description, :category_id)
    end
end
