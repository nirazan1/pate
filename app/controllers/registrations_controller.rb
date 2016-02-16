class RegistrationsController < Devise::RegistrationsController
  include Geocoder
  def new
    super
  end

  def create
    super
    User.set_location(params , cookies[:latitudine], cookies[:longitudine])
  end

  def update
    super
    User.set_location(params , cookies[:latitudine], cookies[:longitudine])
  end


  protected
  def user_params
    params.require(:user).permit(:first_name,:middel_name, :last_name, :location, :email, :password, :password_confirmation, :username )
  end

end