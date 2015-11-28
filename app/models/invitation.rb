class Invitation < ActiveRecord::Base


  has_one :list

  has_one :user


  def url

    if Rails.env.development?
      return 'http://127.0.0.1:3000/lists/' + self.list_id.to_s + '/invitations/accept/' + self.id.to_s
    else
      return 'http://allourlists.com/lists/' + self.list_id.to_s + '/invitations/accept/' + self.id.to_s
    end

  end


end
