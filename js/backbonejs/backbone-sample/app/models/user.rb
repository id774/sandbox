# user.rb: User model with list scopes
#
# Description:
# Define the User model of the Backbone.js sample application, with scopes
# that limit a listing to 50 records and order it by creation time, and with
# name as the mass-assignable attribute.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

class User < ActiveRecord::Base
  scope :limited, :limit => 50
  scope :ordered, :order => 'created_at asc'

  attr_accessible :name
end
