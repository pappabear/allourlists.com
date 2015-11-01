class User < ActiveRecord::Base


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email


end
