class ProfilesController < ApplicationController
  before_action :authenticate_user

  def show
    # Check whether there is currently a profile for this user
    profile = Profile.where(user_id: current_user.id)
    # p profile[0].image_attached?
    if profile.length == 0 then
      # redirect to new
      render json: {message: "no_profile"}
    elsif profile[0].image_attachment
      render json: {
        message: "profile",
        name: profile[0].name,
        image_url: url_for(profile[0].image),
        favorite_place: profile[0].favorite_place,
        bio: profile[0].bio
      }
    else
      render json: {
        message: "profile",
        name: profile[0].name,
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
