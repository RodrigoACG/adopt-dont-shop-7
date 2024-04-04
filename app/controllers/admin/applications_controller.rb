class Admin::ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    # if @application.status =! "Accepted"
      
    # end
  end

  # def update

  #   require 'pry'; binding.pry
  #   app_pet = ApplicationPets.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
  #   app_pet.update(status: params[:status])
  #   redirect_to "/admin/applications/#{params[:application.id]}"
  # end
end