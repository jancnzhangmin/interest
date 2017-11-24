class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authen(authkey)

    auths = session[:auth].split(':')

    if !auths.include?authkey
      redirect_to noauths_path
    end
  end

end
