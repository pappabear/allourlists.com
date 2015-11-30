class InvitationsController < ApplicationController


  skip_before_filter :authenticate_user!, :only => :accept


  respond_to :html, :js


  def create
    logger.info 'INFO: Entering invitations_controller.rb::create()...'
    @list = List.find(params[:list_id])
    @invitation = Invitation.new

    success_code = false

    logger.info 'INFO: params[:email] = ' + params[:email]

    user = User.find_by_email(params[:email])

    if user.nil?

      # new user

      logger.info 'INFO: User record was NOT found, creating a new user...'

      temp_password = ((0...8).map{(65+rand(26)).chr}.join).to_s
      user = User.create( :name => params[:email], :email => params[:email], :password => temp_password )

      logger.info 'INFO: User created.'

      logger.info 'INFO: Creating the invitation...'

      @invitation.list_id = @list.id
      @invitation.password_is_temp=true
      @invitation.sent_at=Time.now
      @invitation.user_id = user.id

      @invitation.save!

      logger.info 'INFO: Invitation saved.'

      logger.info 'INFO: Sending the email...'

      EmailDispatcher.new_user_invitation(user, @list, @invitation.url, current_user, temp_password).deliver_now

      logger.info 'INFO: Email sent.'

    else

      # existing user

      logger.info 'INFO: User record was found...'

      logger.info 'INFO: Creating the invitation...'

      @invitation.list_id = @list.id
      @invitation.password_is_temp=false
      @invitation.sent_at=Time.now
      @invitation.accepted_at=Time.now
      @invitation.user_id = user.id

      @invitation.save!

      logger.info 'INFO: Invitation saved.'

      logger.info 'INFO: Sending the email...'

      EmailDispatcher.existing_user_invitation(user, @list, @invitation.url, current_user).deliver_now

      logger.info 'INFO: Email sent.'

    end

    logger.info 'INFO: Leaving invitations_controller.rb::create()...'

  end


  def accept

    @list = List.find(params[:list_id])
    @invitation = Invitation.find(params[:id])
    invitee = User.find(@invitation.user_id)

    @invitation.accepted_at=Time.now
    @invitation.save!

    sign_in invitee
    redirect_to lists_path, notice: 'Thank you for accepting the invitation to join the list.'

  end


  private


  def invitation_params
    params.require(:invitation).permit(:accepted_at, :password_is_temp, :sent_at, :list_id)
  end


end
