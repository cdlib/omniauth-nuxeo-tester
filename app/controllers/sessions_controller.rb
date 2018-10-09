# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    session[:omniauth] = request.env['omniauth.auth']

    p "OMNIAUTH RESULT: #{request.env['omniauth.auth'].inspect}"

    #@user = User.find_or_create_from_auth_hash(auth_hash)
    #self.current_user = @user
    redirect_to '/', notice: "You are now logged in: #{request.env['omniauth.auth'].inspect}}"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end