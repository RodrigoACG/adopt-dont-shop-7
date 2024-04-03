class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :application_pets, through: :pets
  has_many :applications, through: :application_pets


  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where("age >= ?", age_filter)
  end

  def self.reverse_alpha_order
    # Shelter.order(name: :desc).to_sql
    find_by_sql("SELECT * FROM shelters ORDER BY name desc")
  end

  def pending_applications?
    #how do I make this a boolean
    Shelter.joins(:pets, :applications).where("status ='Pending'").count > 0
  end
end
