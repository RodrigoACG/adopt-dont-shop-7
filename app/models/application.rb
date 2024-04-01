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
  #   "Pendinggit push heroku master",
  #   "Accepted"
  #   ]
  def num_pets
    pets.count
  end
end

