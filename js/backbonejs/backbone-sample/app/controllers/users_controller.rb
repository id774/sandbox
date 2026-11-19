# users_controller.rb: JSON API for users
#
# Description:
# Serve the users of the Backbone.js sample application as a JSON API, with
# index, show, create, update, and destroy actions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

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
