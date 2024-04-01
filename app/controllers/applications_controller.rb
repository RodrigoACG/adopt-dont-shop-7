class ApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def create 
    application =Application.new(application_params)
    if application.save 
      redirect_to "/applications/#{application.id}"
    else
      redirect_to"/applications/new"
      flash[:alert] = "Error: All fields must be filled out"
    end
  end

  def new 

  end

  def update
    application = Application.find(params[:id])

    # if application.num_pets > 0 #&& status: "In Progress" 
      # application.update!(application_params)
      application.update!(status: "Pending")
      redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end