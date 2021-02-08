include Rails.application.routes.url_helpers

class PrivateLandmarksController < ApplicationController
  before_action :authenticate_user

  def show
    # Check whether there is currently a landmark gallery for this user/landmark
    landmark = PrivateLandmark.where(user_id: current_user.id).where(title: params[:landmark_title])
    if landmark.length == 0 then
      # redirect to new
      render json: {message: "no_landmark"}
      p "redirected to form page"
    # end
    else
      
      image_url = []
      landmark[0].image_attachments.map do |img| 
        image_url.push(url_for(img))
      end

      render json: { 
        landmark: {
          message: "landmark",
          title: landmark[0].title,
          image_urls: image_url,
          latest_visit: landmark[0].latest_visit,
          city: landmark[0].city,
          notes: landmark[0].notes
        } 
      }
    end
  end

  def create
    landmark = PrivateLandmark.new({
      title: params[:title],
      latest_visit: params[:latest_visit],
      notes: params[:notes],
      city: params[:city]
      })
    landmark.user_id = current_user.id
    p landmark
    if landmark.save

      for i in 0..(params[:image_number].to_i-1)
        landmark.image.attach(params[:"file_#{i}"])
      end
      
      render status: :ok
    else 
      render status: :bad_request
    end    
  end

  def destroy
    landmark = PrivateLandmark.where(user_id: current_user.id).where(title: params[:landmark_title])
    landmark[0].destroy
  end

end
