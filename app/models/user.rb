class User < ActiveRecord::Base


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable


  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email


  #--- adding avetar to user
  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 5.megabytes }

  has_attached_file :avatar,
                    :styles => { :square => "100x100#", :thumb => "25x25>", :medium => "300x300>" },
                    :url => ":s3_domain_url",
                    :path => 'users/:id/avatars/:style_:basename.:extension',
                    :storage => :s3,
                    :bucket => ENV['ALLOURLISTS_S3_BUCKET_NAME'],
                    :s3_credentials => {
                        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                    }

end
