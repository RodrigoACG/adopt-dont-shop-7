class ApplicationPetsController < ApplicationController 
  def create 
    app_pets = ApplicationPet.create( application_id: params[:id], pet_id: params[:pet_id])
  # require 'pry'; binding.pry
    redirect_to("/applications/#{params[:id]}")
  end
end