class PolygonsController < ApplicationController

  def index
    polygons = Polygon.all
    render json: polygons.to_json
  end

  # to do: this method was created for an AJAX request in rules#show view
  # this ways of 'delivering' the polygon is too slow when using the real life
  # polygons. The workaround was implemented in rules#show through Well Known Text.
  def show
    # to do: this method should allow the user to show more than only 1 polygon.
    # to do: prevent sql injection here. SQLite gem? http://ruby.bastardsbook.com/chapters/sql/#placeholders-sqlite-gem
    sql = "SELECT ST_AsText(geography) From polygons Where id = #{params[:id]};"
    wkts_arrays = ActiveRecord::Base.connection.execute(sql).values
    wkts_hash = {}
    wkts_arrays.each_with_index { |array, index| wkts_hash[index + 1] = array[0] }
    @wkts_json = wkts_hash.to_json
    render json: { polygons: @wkts_json }.to_json
    # render json: {coordinates: coordinates}.to_json
  end

end
