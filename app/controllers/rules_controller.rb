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
    redirect_to rules_path, notice: 'A norma foi removida'
  end

  def show_rules
    @rules = Rule.where(user_id: current_user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

end
