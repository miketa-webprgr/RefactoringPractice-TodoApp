class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :editor_user
  helper_method :viewer_user
  before_action :login_required
  before_action :editor_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def editor_user
    @editor_user ||= @current_user unless @current_user&.editor_id
  end

  def viewer_user
    @viewer_user ||= @current_user if @current_user&.editor_id
  end

  # コントローラにおいて、viewer_userかeditor_userか意識しなくてよいように独自メソッドを作成した
  def set_editor
    viewer_user ? viewer_user.editor : editor_user
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def editor_required
    redirect_to root_url unless editor_user
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
