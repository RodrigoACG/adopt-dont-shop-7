require 'rails_helper'

RSpec.describe Application, type: :model do
  describe '#method_name' do
    it { should have_many :application_pets} 
    it { should have_many(:pets).through(:application_pets)}
    
    
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_numericality_of :zip_code }
    it { should validate_presence_of :description }
  end

  describe "instance methods" do
    it "#num_pets" do
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )

      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
      pet2 = shelter1.pets.create!(adoptable: true, age: 6, breed: "Poodle", name: "Princess") 

      application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
      
      application_pet = ApplicationPet.create!(application: application1, pet: pet1)
      application_pet2 = ApplicationPet.create!(application: application1, pet: pet2)

      expect(application1.num_pets).to eq(2)
    end
  end
end
