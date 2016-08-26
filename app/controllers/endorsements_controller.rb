class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @endorsement = @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
  end

end
