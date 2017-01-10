class ReviewHousesController < ApplicationController
  before_action :set_review_house, only: [:show, :edit, :update, :destroy]

  # GET /review_houses
  # GET /review_houses.json
  def index
    @review_houses = ReviewHouse.all
    # binding pry
  end

  # GET /review_houses/1
  # GET /review_houses/1.json
  def show
  end

  # GET /review_houses/new
  def new
    @review_house = ReviewHouse.new
  end

  # GET /review_houses/1/edit
  def edit
  end

  # POST /review_houses
  # POST /review_houses.json
  def create
    @review_house = ReviewHouse.new(review_house_params)

    respond_to do |format|
      if @review_house.save
        format.html { redirect_to @review_house, notice: 'Review house was successfully created.' }
        format.json { render :show, status: :created, location: @review_house }
      else
        format.html { render :new }
        format.json { render json: @review_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_houses/1
  # PATCH/PUT /review_houses/1.json
  def update
    respond_to do |format|
      if @review_house.update(review_house_params)
        format.html { redirect_to @review_house, notice: 'Review house was successfully updated.' }
        format.json { render :show, status: :ok, location: @review_house }
      else
        format.html { render :edit }
        format.json { render json: @review_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_houses/1
  # DELETE /review_houses/1.json
  def destroy
    @review_house.destroy
    respond_to do |format|
      format.html { redirect_to review_houses_url, notice: 'Review house was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review_house
      @review_house = ReviewHouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_house_params
      params.fetch(:review_house, {})
    end
end
