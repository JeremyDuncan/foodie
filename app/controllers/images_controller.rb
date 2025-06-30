# app/controllers/images_controller.rb
class ImagesController < ApplicationController
  before_action :set_restaurant
  before_action :set_image

  def edit
  end

  def update
    if @image.update(image_params)
      redirect_to edit_restaurant_path(@restaurant),
                  notice: "Image details updated."
    else
      render :edit
    end
  end

  def destroy
    @image.destroy
    redirect_to edit_restaurant_path(@restaurant),
                notice: "Image deleted."
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_image
    @image = @restaurant.images.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:title, :description)
  end
end
