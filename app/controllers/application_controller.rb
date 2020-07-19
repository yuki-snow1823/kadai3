class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # オンにする必要があるが、リダイレクトされるので一旦解除→再度つけた
    # deviseにまつわる画面で、beforeactionする。（下に定義）
  
  def after_sign_in_path_for(resource)
      user_path(resource)
      # ログイン後ホームではなくマイページに行かせる
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email]) 
    # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
    # 名前でログインを設定する際に必要
  end
  # 新規登録の際に、nameも入れるようにした。deviseのストロングパラメーターは直接編集できないため、ここに書く！
end
