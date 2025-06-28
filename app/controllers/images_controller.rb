class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]

  # GET /images or /images.json
  def index
    @images = Image.all
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

  # POST /images or /images.json
  # def create
  #   @image = Image.new(image_params)
  #
  #   respond_to do |format|
  #     if @image.save
  #       format.html { redirect_to @image, notice: "Image was successfully created." }
  #       format.json { render :show, status: :created, location: @image }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @image.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy!

    respond_to do |format|
      format.html { redirect_to images_path, status: :see_other, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:file, :user_id, :imageable_id, :imageable_type)
    end
end
