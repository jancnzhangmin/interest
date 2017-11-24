module ApplicationHelper

  def authen(authkey)
    auths = session[:auth].to_s.split(':')
    if auths.include?authkey
      return true
    else
      return false
    end
  end

end
