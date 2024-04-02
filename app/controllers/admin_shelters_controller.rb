class AdminSheltersController < ApplicationController
  def index 
    @shelters = Shelters.reverse_alpha_order # need to make this method
  end
end
