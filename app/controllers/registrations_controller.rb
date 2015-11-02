class RegistrationsController < Devise::RegistrationsController


  protected


  #def after_update_path_for(user)
  #  edit_user_registration_path
  #end


  def after_sign_in_path_for(user)
    root_path
  end


  def after_sign_up_path_for(user)

    #--- send an email back to HQ that a new user has registered!
    new_user_email = NewUserEmail.new
    new_user_email.name = user.name
    new_user_email.email = user.email
    new_user_email.message = user.name + " ( " + user.email + " ) just joined the site."
    new_user_email.request = request
    new_user_email.deliver

    #--- create the new user his first list
    l = List.new(:user_id=>user.id, :name=>'Your first list!')
    l.save!
    l.items.create(:name=>'Your first todo!')

    #authenticated_root_path
    root_path

  end


  private


  def configure_permitted_parameters

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :avatar)
    end

  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end


end
