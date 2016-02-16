class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    [self.first_name, self.middle_name, self.last_name].join(" ")
  end

  def country_name
    country = self.country
    ISO3166::Country[country]
  end

  def self.set_location(params, lat, long)
    @user = User.find_by(email: params[:user][:email])
    if lat.nil? && long.nil?
      @user.lat = Geocoder.search(@user.location)[0].latitude
      @user.long = Geocoder.search(@user.location)[0].longitude
    else
      @user.lat = lat.nil? ? '0.00' : lat
      @user.long = long.nil? ? '0.00' : long
      lat = lat.to_f
      long = long.to_f
      @user.location = Geocoder.search("#{lat}, #{long}")[0].formatted_address
    end
    @user.save
  end

end
