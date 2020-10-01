class RulesController < ApplicationController
  before_action :set_rule, only: [:show]

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end
end
