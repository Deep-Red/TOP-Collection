class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
  end

  def destroy
  end
end
