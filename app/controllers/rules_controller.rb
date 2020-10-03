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
    raise
    if (params1 && params2)
      @searched_polygon =
      @searched_industry =
      @sql1 = "Select r.id "\
              "From polygons p FULL OUTER JOIN spatial_domains s ON p.id = s.polygon_id "\
              "FULL OUTER JOIN rules r ON s.rule_id = r.id FULL OUTER JOIN industry_rules "\
              "ir ON r.id = ir.rule_id FULL OUTER JOIN industries i ON i.id = ir.industry_id "\
              "WHERE ST_Intersects('#{@searched_polygon}', p.geography) AND "\
              "i.name = '#{@searched_industry}';"

      @rules_id_pg_array = ActiveRecord::Base.connection.execute(@sql1)
      @rules_id = []
      @rules_id_array.each do |r| @rules_id << r['id'] end
      @rules = Rule.find(@rules_id)

      redirect_to index_search_path(@rules)
    else
      redirect_to :spatial_search
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end
end
