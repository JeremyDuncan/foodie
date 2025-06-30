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
    # strip out the new_images arrays so AR only tries to update core attrs
    if @restaurant.update(restaurant_params.except(:new_restaurant_images, :new_menu_images))
      attach_new_images
      redirect_to @restaurant, notice: 'Restaurant updated successfully.'
    else
      render :edit
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
    params.require(:restaurant).permit(
      :name,
      :address,
      :phone,
      images_attributes: [:id, :file, :_destroy],
      new_restaurant_images: [],
      new_menu_images: []
    )
  end

  # ============================================================================
  # Create Image records from uploaded files for each category
  # ----------------------------------------------------------------------------
  def attach_new_images
    Array(params[:restaurant][:new_restaurant_images]).each do |file|
      @restaurant.restaurant_images.create(file: file)
    end

    Array(params[:restaurant][:new_menu_images]).each do |file|
      @restaurant.menu_images.create(file: file)
    end
  end

end

