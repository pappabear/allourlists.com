class User < ActiveRecord::Base


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email


  #--- adding avetar to user
  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 5.megabytes }

  has_attached_file :avatar, styles: {
                               thumb: '25x25>',
                               square: '100x100#',
                               medium: '300x300>'
                           }


end
