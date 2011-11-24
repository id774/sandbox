class UsersController < ApplicationController
  def index
    render :json => User.limited.ordered.all
  end

  def show
    render :json => User.find(params[:id])
  end

  def create
    user = User.create! params
    render :json => user
  end

  def update
    user = User.find(params[:id])
    user.update_attributes! params
    render :json => user
  end

  def destroy
    User.destroy(params[:id])
    render :json => { id: params[:id] }
  end
end
