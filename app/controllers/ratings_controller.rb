class RatingsController < ApplicationController
   
    def create
        @rating = Rating.new(rating_params)
        @rule = Rule.find(params[:rule_id])
        @rating.rule = @rule
        @rating.user = current_user
        @rating.save
        redirect_to rule_path(@rule)
    end
    
    private

    def rating_params
      params.require(:rating).permit(:comment, :grade, :validity)
    end    


end
