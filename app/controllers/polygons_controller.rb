class PolygonsController < ApplicationController

  def index
    polygons = Polygon.all
    render json: polygons.to_json
  end

  def show
    polygon = Polygon.find_by(id: params[:id])
    hash = RGeo::GeoJSON.encode(polygon.geography)
    coordinates = hash["coordinates"][0][0]
    render json: {coordinates: coordinates}.to_json
  end

end
