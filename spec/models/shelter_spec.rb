require "rails_helper"

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it { should have_many(:pets) }

  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

  describe "admin class methods" do
    describe "reverse_alpha_order" do
      it "orders shelter name alphabetically by reverse" do
        expect(Shelter.reverse_alpha_order).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end
  end

  describe "admin instance methods" do
    describe "#pending_applications?" do
      it "displays only shelters with pending applications" do
        # Pet.delete_all
        # Shelter.delete_all
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
        
        
        pet1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
        pet2 = shelter_1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 
        pet3 = shelter_3.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Pantera") 
        pet4 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

        application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person", status: "Pending")
        application2 = Application.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.", status: "Pending")

        application_pet_1 = ApplicationPet.create!(application_id: application1.id, pet_id: pet1.id)
        application_pet_2 = ApplicationPet.create!(application_id: application2.id, pet_id: pet3.id)
        expect(Shelter.pending_applications).to eq([shelter_1, shelter_3])
        # expect(shelter_3.pending_applications?).to be(true)
        # expect(shelter_2.pending_applications?).to be(false)
      end
    end
  end

    describe "#order_by_recently_created" do
      it "returns shelters with the most recently created first" do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe "#order_by_number_of_pets" do
      it "orders the shelters by number of pets they have, descending" do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end
  end

  describe "instance methods" do
    describe ".adoptable_pets" do
      it "only returns pets that are adoptable" do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe ".alphabetical_pets" do
      it "returns pets associated with the given shelter in alphabetical name order" do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe ".shelter_pets_filtered_by_age" do
      it "filters the shelter pets based on given params" do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe ".pet_count" do
      it "returns the number of pets at the given shelter" do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end
  end
end
