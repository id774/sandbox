class User < ActiveRecord::Base
  scope :limited, :limit => 50
  scope :ordered, :order => 'created_at asc'

  attr_accessible :name
end
