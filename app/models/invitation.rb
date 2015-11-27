class Invitation < ActiveRecord::Base


  has_one :list

  has_one :user


end
