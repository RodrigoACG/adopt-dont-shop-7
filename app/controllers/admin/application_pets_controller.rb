class Admin::ApplicationPetsController < ApplicationController

  def update
    app_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    app_pet.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end