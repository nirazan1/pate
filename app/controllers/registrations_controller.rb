class RegistrationsController < Devise::RegistrationsController
  include Geocoder
  def new
    super
  end

  def create
    super
    @user = User.find_by(email: params[:user][:email])
    if cookies[:latitudine].nil? && cookies[:longitudine].nil?
      @user.lat = Geocoder.search(@user.location)[0].latitude
      @user.long = Geocoder.search(@user.location)[0].longitude
    else
      @user.lat = cookies[:latitudine].nil? ? '0.00' : cookies[:latitudine]
      @user.long = cookies[:longitudine].nil? ? '0.00' : cookies[:longitudine]
      lat = cookies[:latitudine].to_f
      long = cookies[:longitudine].to_f
      @user.location = Geocoder.search("#{lat}, #{long}")[0].formatted_address
    end
    @user.save
    redirect_to edit_user_registration_path
  end

  def update
    super
    @user = User.find_by(email: params[:user][:email])
    if cookies[:latitudine].nil? && cookies[:longitudine].nil?
      @user.lat = Geocoder.search(@user.location)[0].latitude
      @user.long = Geocoder.search(@user.location)[0].longitude
    else
      @user.lat = cookies[:latitudine].nil? ? '0.00' : cookies[:latitudine]
      @user.long = cookies[:longitudine].nil? ? '0.00' : cookies[:longitudine]
      lat = cookies[:latitudine].to_f
      long = cookies[:longitudine].to_f
      @user.location = Geocoder.search("#{lat}, #{long}")[0].formatted_address
    end
    @user.save
  end


  protected


  def user_params
    params.require(:user).permit(:first_name,:middel_name, :last_name, :location, :email, :password, :password_confirmation, :username )
  end

end