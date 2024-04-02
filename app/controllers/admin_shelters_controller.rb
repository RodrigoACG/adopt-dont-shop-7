class AdminSheltersController < ApplicationController
  def index 
    require 'pry' ; binding.pry
    @shelters = Shelter.reverse_alpha_order # need to make this method
  end
end
