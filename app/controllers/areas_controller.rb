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
    @area = Area.find_or_create_by(postcode: area_params["postcode"].upcase.gsub(/\s+/,""))
    @property = @area.properties.create(rent: area_params["property_rent"], investment: area_params["landlord_investment"])
    @property.user = current_user
    @property.save
    redirect_to root_path
  end

  private
  def area_params
    params[:area].permit(:postcode, :property_rent, :landlord_investment)
  end
end
