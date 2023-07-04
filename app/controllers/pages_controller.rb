class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :landing ]
  before_action :load_matches, only: :home
  
  def landing; end

  def home; end

  def draw; end

  private

  def load_matches
    @matches = Match.order(created_at: :desc).all
  end
end
