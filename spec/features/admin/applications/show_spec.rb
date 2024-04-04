require "rails_helper"

RSpec.describe "Admin Show Page" do

  describe '#US 12' do
    it 'Accepts an application' do
      # As a visitor
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )
      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
      pet2 = shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 

      application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")

      application1.pets.push(pet1,pet2)
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{application1.id}"
      # For every pet that the application is for, I see a button to approve the application for that specific pet
      within "#AppPet-#{pet2.id}" do
        expect(page).to have_button("Approve #{pet2.name}")
      end

      within "#AppPet-#{pet1.id}" do
        expect(page).to have_button("Approve #{pet1.name}")
        # When I click that button
        click_on("Approve #{pet1.name}")
      end
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/applications/#{application1.id}")
      # And next to the pet that I approved, I do not see a button to approve this pet

      within "#AppPet-#{pet1.id}" do
        expect(page).to_not have_button("Approve#{pet1.name}")
        # And instead I see an indicator next to the pet that they have been approved
        expect(page).to have_content("Approved")

      end
      
    end
  end

  describe '#us 13' do
    it 'Rejects an application' do
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )
      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
      pet2 = shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 

      application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")

      application1.pets.push(pet1,pet2)
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{application1.id}"
      # For every pet that the application is for, I see a button to reject the application for that specific pet

      within "#AppPet-#{pet2.id}" do
        expect(page).to have_button("Reject #{pet2.name}")
      end  

      within "#AppPet-#{pet1.id}" do
        expect(page).to have_button("Reject #{pet1.name}")
        # When I click that button
        click_on("Reject #{pet1.name}")
        # When I click that button
      end
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/applications/#{application1.id}")

      within "#AppPet-#{pet1.id}" do
        expect(page).to_not have_button("Reject #{pet1.name}")
        # And instead I see an indicator next to the pet that they have been Rejected
        expect(page).to have_content("Rejected")
        # save_and_open_page
      end
      # And next to the pet that I rejected, I do not see a button to approve or reject this pet
      # And instead I see an indicator next to the pet that they have been rejected
    end
  end

  describe '#us 14' do
    it 'will not affect another app for same pet is it is approved on another ap' do
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )

      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
      pet2 = shelter1.pets.create!(adoptable: true, age: 7, breed: "Shepherd", name: "Mick") 
      pet3 = shelter1.pets.create!(adoptable: true, age: 10, breed: "Doberman", name: "Luna") 
      
      application1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
      application2 = Application.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.")

      # When there are two applications in the system for the same pet
      application1.pets.push(pet1)
      application2.pets.push(pet1, pet2, pet3)

      # When I visit the admin application show page for one of the applications
      visit "/admin/applications/#{application1.id}"

      # And I approve or reject the pet for that application
      within "#App-#{application1.id}" do
        click_on("Approve #{pet1.name}")
      end

      # When I visit the other application's admin show page
      visit "/admin/applications/#{pet2}"

      # Then I do not see that the pet has been accepted or rejected for that application
      within "#App-#{application2.id}" do
        expect(page).to have_button("Approve #{pet2.name}")
        expect(page).to have_button("Approve #{pet3.name}")
      end
    
    # And instead I see buttons to approve or reject the pet for this specific application
      within "#luna-#{pet1.id}" do
        expect(page).to_not have_content("Approved")
        expect(page).to_not have_content("Rejected")
        expect(page).to have_button("Approve #{pet1.name}")
        expect(page).to have_button("Reject #{pet1.name}")
      end
    end
  end
end