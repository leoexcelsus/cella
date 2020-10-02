class RulesController < ApplicationController

skip_before_action :authenticate_user!, only: [:index, :show, :index_search, :spatial_search]

  def index_search
    @rules = Rule.all
    @rules = @rules.sample(3)
  end

  def show
  end

  def spatial_search
  end

end
