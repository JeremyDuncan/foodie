class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def new
    puts ""
    puts "###################################"
    puts "params: #{params.inspect}"
    puts "current_user: #{current_user.inspect}"

    @restaurant = Restaurant.new
  end

  def edit
    debug(params, "Restaurant EDIT PARAMS")
    info_msg("Current User: #{current_user.inspect}")
    # @restaurant is already set by set_restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if params[:restaurant][:new_images].present?
      params[:restaurant][:new_images].each do |upload|
        @restaurant.images.build(file: upload)
      end
    end

    if @restaurant.save
      redirect_to @restaurant, notice: "Restaurant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # pull out new_images and remove from params hash
    rp      = restaurant_params
    uploads = rp.delete(:new_images)

    if @restaurant.update(rp)
      Array(uploads).each do |upload|
        @restaurant.images.create(file: upload)
      end

      redirect_to @restaurant, notice: "Restaurant was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @restaurant.destroy!
    redirect_to restaurants_path,
                status:   :see_other,
                notice:   "Restaurant was successfully destroyed."
  end



  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant)
          .permit(
            :name,
            :address,
            :phone,
            new_images: [],
            images_attributes: [:id, :file, :_destroy]
          )
  end
end

