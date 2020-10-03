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

  def new
    @rule = Rule.new
  end

  def create
    @rule = Product.new(rule_params)
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

end
