class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    
    if @user.save
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :company)
  end


end
