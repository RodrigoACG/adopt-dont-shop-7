require 'rails_helper'

RSpec.describe 'admin/application show page', type: :feature do
  describe ' USER STORY #11' do
    describe 'as an admin when I visit the application show page' do
      before(:each) do
        @shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )

        @pet1 = @shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
        @pet2 = @shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 
        @pet3 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Pantera") 

        @application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
        # @application2 = Application.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.")
        # @application2.pets << @pet1

        visit "/admin/applications/#{@application1.id}"
      end

      #US11
      it 'does not display submit application section if application does not have pets' do
        expect(page).to_not have_content(@pet1.name)
        expect(page).to_not have_content(@pet2.name)        
        expect(page).to_not have_button("Submit Application")
      end
    end 
  end
end