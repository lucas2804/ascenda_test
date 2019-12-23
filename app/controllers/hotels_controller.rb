class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :update, :destroy]

  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.all
    @hotels = @hotels.where(hotel_id: params['hotel_ids']) if params['hotel_ids'].present?
    @hotels = @hotels.where(destination_id: params['destination_ids'].map(&:to_i)) if params['destination_ids'].present?

    render json: @hotels
  end

  def sync_data
    SanitizingHotel::Supplier1.new.execute
    SanitizingHotel::Supplier2.new.execute
    SanitizingHotel::Supplier3.new.execute

    render json: {
      message: 'Sync data successfully from Supplier1 2 3',
      total_hotels: Hotel.count
    }
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)

    if @hotel.save
      render :show, status: :created, location: @hotel
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    if @hotel.update(hotel_params)
      render :show, status: :ok, location: @hotel
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hotel_params
    params.require(:hotel).permit(:hotel_id, :destination_id, :name)
  end
end
