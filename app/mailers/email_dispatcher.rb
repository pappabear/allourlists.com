class EmailDispatcher < ApplicationMailer

  default from: 'AllOurLists invitations <invitations@allourlists.com>'    #"invitations@huddleup.com"

  layout 'mailer'


  def new_user_invitation(user, list, url, list_owner, temp_password)
    @user = user
    @list = list
    @url  = url
    @pwd = temp_password
    @list_owner = list_owner
    mail(to: @user.email, subject: "You've been invited to share a list!")
  end


  def existing_user_invitation(user, list, url, list_owner)
    @user = user
    @list = list
    @url  = url
    @list_owner = list_owner
    mail(to: @user.email, subject: "You've been invited to share a list!")
  end


end
