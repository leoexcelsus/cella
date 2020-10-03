class RulesController < ApplicationController

  before_action :set_rule, only: [:show]

  skip_before_action :authenticate_user!, only: [:index, :show, :index_search, :spatial_search, :spatial_query]

  def index_search
    raise
    @rules = rules
    render index_search
  end

  def show
  end
  # TO DO: rename to 'spatial_search_form'. Watch out for existing cross-references.
  def spatial_search
  end

  def spatial_query
    if (s_query_params_i && s_query_params_g)
      @searched_polygon = "POLYGON((-53.67919921875001 -28.8831596093235,-53.98681640625001 -30.259067203213018,-53.37158203125001 -30.410781790845878,-52.49267578125001 -30.183121842195504,-52.14111328125001 -29.382175075145277,-53.67919921875001 -28.8831596093235))" # s_query_params_g
      @searched_industry = "rodovia" # s_query_params_i
      # TO DO: refactor this code so as to prevent SQL injection.
      @sql1 = "Select r.id "\
              "From polygons p FULL OUTER JOIN spatial_domains s ON p.id = s.polygon_id "\
              "FULL OUTER JOIN rules r ON s.rule_id = r.id FULL OUTER JOIN industry_rules "\
              "ir ON r.id = ir.rule_id FULL OUTER JOIN industries i ON i.id = ir.industry_id "\
              "WHERE ST_Intersects('#{@searched_polygon}', p.geography) AND "\
              "i.name = '#{@searched_industry}';"

      @rules_id_pg_array = ActiveRecord::Base.connection.execute(@sql1)
      @rules_id = []
      @rules_id_pg_array.each do |r| @rules_id << r['id'] end
      @rule_set = Rule.find(@rules_id)

      redirect_to index_search_path(@rule_set)
    else
      redirect_to :spatial_search
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

  def s_query_params_i
    params.require(:industry)
  end

  def s_query_params_g
    params.require(:geography)
  end
end
