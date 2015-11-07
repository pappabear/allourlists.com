class FeedbackEmailsController < ApplicationController
  def new
    @feedback_email = FeedbackEmail.new
    @feedback_email.name = current_user.name
    @feedback_email.email = current_user.email
  end

  def create
    @feedback_email = FeedbackEmail.new(params[:message])
    @feedback_email.request = request
    if @feedback_email.deliver
      #flash.now[:notice] = 'Thank you for your feedback!'
      #redirect_to authenticated_root_path
      redirect_to authenticated_root_path, notice: 'Thank you for your feedback!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end
