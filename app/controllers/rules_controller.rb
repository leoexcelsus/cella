require 'csv'

class RulesController < ApplicationController

  before_action :set_rule, only: [:show]

  skip_before_action :authenticate_user!, only: [:index, :show, :index_search, :spatial_search]

  def index_search
    @rules = Rule.all
    @rules = @rules.sample(3)
  end

  def show
  end

  def spatial_search

  end

  def spatial_query
    @searched_polygon = "POLYGON((-52.11614218435184 -6.411085727796378,-59.58442484383378 -10.843968821105001,-53.43407441837804 -19.40872775103672,-46.05365390783119 -11.96456032658079,-52.11614218435184 -6.411085727796378))"
    @searched_industry = "rodovia"
    @sql1 = "SELECT * FROM polygons WHERE ST_Intersects('#{@searched_polygon}', polygons.geography)"
    @array_polygons = ActiveRecord::Base.connection.execute(sql1)
    @filter1 = @array_polygons.rules

    @results
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end


end
