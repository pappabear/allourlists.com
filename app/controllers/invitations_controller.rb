class InvitationsController < ApplicationController


  skip_before_filter :authenticate_user!, :only => :accept


  respond_to :html, :js


  def create
    logger.info 'INFO: Entering invitations_controller.rb::create()...'
    @list = List.find(params[:list_id])
    @invitation = Invitation.new
    logger.info 'INFO: Leaving invitations_controller.rb::create()...'
  end


  def accept
  end


  private


  def invitation_params
    params.require(:invitation).permit(:accepted_at, :password_is_temp, :sent_at, :list_id)
  end


end
