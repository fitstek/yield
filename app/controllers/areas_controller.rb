class AreasController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @areas = Area.all
  end

  def show
    @area = Area.find params[:id]
    @properties = @area.properties
  end

  def new
    @area = Area.new
  end

  def create
    begin
      @area = Area.find_or_create_by(postcode: area_params["postcode"].upcase.gsub(/\s+/,""))
      @property = @area.properties.create!(rent: area_params["property_rent"], investment: area_params["landlord_investment"])
      @property.user = current_user
      @property.save
      redirect_to root_path
    rescue ActiveRecord::RecordNotSaved => e
      flash[:notice] = "Please check to make sure that you have provided a valid post code"
      redirect_to new_area_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:notice] = "Please check to make sure that you have provided a valid rent or investment"
      redirect_to new_area_path
    end
  end

  private
  def area_params
    params[:area].permit(:postcode, :property_rent, :landlord_investment)
  end
end
