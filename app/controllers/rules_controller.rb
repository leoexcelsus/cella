class RulesController < ApplicationController
  before_action :set_rule, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show, :index_search]

  def index_search
    @rules = Rule.all
    @rules = @rules.sample(3)
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end
