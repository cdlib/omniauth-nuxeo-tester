# frozen_string_literal: true

class SessionsController < s

  def create
    session[:omniauth] = request.env['omniauth.auth']

    p "OMNIAUTH RESULT: #{request.env['omniauth.auth'].inspect}"

    #@user = User.find_or_create_from_auth_hash(auth_hash)
    #self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end