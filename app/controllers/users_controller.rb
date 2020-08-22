class UsersController < ApplicationController
  # 未登録ユーザー => ユーザー作成のみできる
  # viewer_user => このコントローラを使わない
  # editor_user => newとcreateを除く5つのアクションを使っているが、実は全てviewer_userに関するもの

  # 以上を踏まえて、newとcreateアクションのみにしてみた
  # その他のアクションは、viewers_controllersに移動してみた（まあまあ大変だった笑）

  # このままの設計だと、URLを直打ちすれば、viewer_userやeditor_userとしてログインしたまま新しくeditor_userが作成できる
  # ただ、特段そのこと自体に問題がないので、そのアクションが使えるような設計にしておく
  #（細かいこと言うなら、そのような場合も想定して、ログオフさせるようなコードを書いておいた方がいい？）

  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :editor_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to root_url, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
