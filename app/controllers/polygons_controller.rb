class PolygonsController < ApplicationController

  def index
    polygons = Polygon.all
    render json: polygons.to_json
  end

  # to do: this method was created for an AJAX request in rules#show view
  # this ways of 'delivering' the polygon is too slow when using the real life
  # polygons. The workaround was implemented in rules#show through Well Known Text.
  def show
    polygon = Polygon.find_by(id: params[:id])
    hash = RGeo::GeoJSON.encode(polygon.geography)
    coordinates = hash["coordinates"][0][0]
    render json: {coordinates: coordinates}.to_json
  end

end
