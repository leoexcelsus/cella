class RulesController < ApplicationController

  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, only: [:index, :show, :index_search, :spatial_search]

  def index_search
    if (s_query_params_i && s_query_params_g)
      @searched_polygon = s_query_params_g[:geography]
      @searched_industry = s_query_params_i[:industry]
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
      @rules = Rule.find(@rules_id)
    else
      redirect_to :spatial_search
    end
  end

  def show
  end
  # TO DO: rename to 'spatial_search_form'. Watch out for existing cross-references.
  def spatial_search
  end

  def edit
  end

  def update
    if @rule.update(rule_params)
      @rule.save
      redirect_to @rule, notice: 'As informações foram atualizadas.'
    else
      render :edit
    end
  end

  def destroy
    @rule.destroy
    redirect_to myrules_path(current_user), notice: 'A norma foi removida.'
  end

  def myrules
    @rules = Rule.where(user_id: current_user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

  def s_query_params_i
    # raise
    params.require(:search).permit(:industry)
  end

  def s_query_params_g
    # raise
    params.require(:search).permit(:geography)
  end
end
