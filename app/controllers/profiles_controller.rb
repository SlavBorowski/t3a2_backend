class ProfilesController < ApplicationController
  before_action :authenticate_user

  def show
    # Check whether there is currently a profile for this user
    profile = Profile.where(user_id: current_user.id)
    if profile.length == 0 then
      # redirect to new
      render json: {message: "no_profile"}
    else
      render json: {
        name: profile[0].name,
        image_url: url_for(profile[0].image),
        favorite_place: profile[0].favorite_place,
        bio: profile[0].bio
      }
    end
  end

  def create
    profile = Profile.new({
      name: params[:name],
      favorite_place: params[:favorite_place],
      bio: params[:bio]
      })
    # profile = Profile.new(profile_params)
    profile.user_id = current_user.id
    if profile.save
      profile.image.attach(params[:file])
      render status: :ok
    else 
      render status: :bad_request
    end    
  end

  # private 

  # def profile_params 
  #   params.require(:profile).permit(:name, :favorite_place, :bio)
  # end
  
end
