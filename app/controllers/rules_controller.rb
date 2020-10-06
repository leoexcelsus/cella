class RulesController < ApplicationController

  before_action :set_rule, only: [:show]

  skip_before_action :authenticate_user!, only: [:index, :show, :index_search, :spatial_search]

  def index
  end

  def index_search
    @rules = Rule.all
    @rules = @rules.sample(3)
  end

  def show
  end

  def spatial_search
  end

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(rule_params, polygon_params, industry_params)
    @rule.user = current_user

    if @rule.save
      redirect_to @rule, notice: 'Norma cadastrada.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

  def rule_params
    params.require(:rule).permit(:jurisdiction, :issuer, :category, :number, :pub_date, :ed_date, :long_title, :hyperlink, :source)
  end

  def polygon_params
    params.require(:polygon).permit(:name)
  end

  def industry_params
    params.require(:industry).permit(:name)
  end

end
