class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  before_action :set_restaurant

  # GET /images or /images.json
  # def index
  #   @images = Image.all
  # end

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @images = @restaurant.images
  end

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  # def new
  #   @image = Image.new
  # end

  # GET /images/1/edit
  def edit
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = @restaurant.images.build(user: current_user)
  end

  # POST /images
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = @restaurant.images.build(image_params.merge(user: current_user))

    if @image.save
      redirect_to restaurant_path(@restaurant), notice: "Image added!"
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    image = @restaurant.images.find(params[:id])
    image.purge
    redirect_to @restaurant, notice: "Image removed"
  end


  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:file, :user_id, :imageable_id, :imageable_type)
    end
end
