class ProfilesController < ApplicationController
  before_action :authenticate_user

  def show
    # Check whether there is currently a profile for this user
    profile = Profile.where(user_id: current_user.id)
    if profile.length == 0 then
      render json: {message: "no_profile"}
    else
      render json: {
        message: "profile",
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
    profile.user_id = current_user.id
    if profile.save
      profile.image.attach(params[:file])
      render status: :created
    else 
      render status: :bad_request
    end    
  end

  def destroy 
    profile = Profile.where(user_id: current_user.id)
    profile[0].destroy
  end

end
