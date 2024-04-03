require 'rails_helper'

RSpec.describe 'admin shelter index page', type: :feature do
  describe ' USER STORY #10' do
    describe ' as a admin when I visit /admin/shelters' do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

        @pet1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
        @pet2 = @shelter_1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 
        @pet3 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Pantera") 

        @application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
        @application2 = Application.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.")

        

        visit "/admin/shelters"

      end
      
      it 'displays shelters in reverse alphabetical order' do
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end

      it "displays shelters with pending applications" do
        
      end
    end 
  end
end