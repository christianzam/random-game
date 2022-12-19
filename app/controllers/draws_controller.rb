class DrawsController < ApplicationController
  before_action :set_draw, only: %i[ show ]
  include DrawsConcern
  
  def show
    @result = start_draw(@draw_id)
    update_giving_to
  end

  def update
    redirect_to action: "show", id: params[:id]
  end

  private
  def set_draw
    @draw_id = params[:id]
  end
end