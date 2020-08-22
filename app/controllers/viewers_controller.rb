class ViewersController < ApplicationController
  # このコントローラはeditor_userしか使わない（viewer_userは使わない）

  skip_before_action :editor_required
  before_action :set_selected_viewer, only: [:show, :edit, :update, :destroy]

  def index
    @viewers = editor_user.viewers
  end

  def show
  end

  def new
    @viewer = User.new
  end

  def create
    @viewer = editor_user.viewers.new(viewer_params)

    if @viewer.save
      redirect_to viewer_url(@viewer), notice: "ユーザー「#{@viewer.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @viewer.update(viewer_params)
    redirect_to todos_url, notice: "ユーザー「#{@viewer.name}」を編集しました。"
  end

  def destroy
    @viewer.destroy!
    redirect_to todos_url, notice: "ユーザー「#{@viewer.name}」を削除しました。"
  end

  private
    def viewer_params
      params.require(:viewer).permit(:name, :email, :password, :password_confirmation)
    end

    # 関係するviewersの中で、該当のviewerをsetする独自メソッドを作成
    def set_selected_viewer
      @viewer = editor_user.viewers.find(params[:id])
    end
    
end

