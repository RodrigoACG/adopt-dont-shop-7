class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, numericality: true
  validates :description, presence: true

  # enum status: [
  #   "In Progress", 
  #   "Pending",
  #   "Accepted"
  #   ]
end

application1 = Application.find(params[:id])
# get pets using associations
if application1.pets.count > 0 && status: "In Progress" #syntax 
  #then change status to Pending ==> update
end