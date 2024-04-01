require "rails_helper"

RSpec.describe "Application show page" do
 

  describe '#us 1' do
    it 'has an applications attributes' do
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )
      shelter2 = Shelter.create!(foster_program: true, name: "Rescue Puppy", city: "Los angeles", rank: 5 )

      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
      pet2 = shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 
      pet3 = shelter2.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Pantera") 
      pet4 = shelter2.pets.create!(adoptable: true, age: 1, breed: "Goldendoodle", name: "Lucky") 

      applicant1 = pet4.applications.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
      applicant2 = pet3.applications.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.")
      applicant3 = pet1.applications.create!(name: "Martin", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80000, description: "Will treat dog as its own kid")
      applicant4 = pet2.applications.create!(name: "Ezequiel", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80001, description: "Has had one in the past and alway treated them with love")
      # When I visit an applications show page
      visit "/applications/#{applicant1.id}"
      # Then I can see the following:
      # - Name of the Applicant
      # - Full Address of the Applicant including street address, city, state, and zip code
      # - Description of why the applicant says they'd be a good home for this pet(s)
      # - names of all pets that this application is for (all names of pets should be links to their show page)
      # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

      expect(page).to have_content("Name: Tyara")
      expect(page).to have_content("Address: 1234 Washington st")
      expect(page).to have_content("Los Angeles")
      expect(page).to have_content("California")
      expect(page).to have_content("90028")
      expect(page).to have_content("Description: Very loving person")
      expect(page).to have_content("Status: In Progress")
      expect(page).to have_link("Lucky")

      click_on("Lucky")

      expect(page).to have_current_path("/pets/#{pet4.id}")

      expect(page).to have_content("Name: Lucky")
      expect(page).to have_content("Age: 1 years old")
      expect(page).to have_content("Breed: Goldendoodle")
      expect(page).to have_content("Adoptable? true")
      expect(page).to have_content("Name of Shelter: Rescue Puppy")
    end
  end

  describe '#us 4' do
    it 'Searching for pets for an application' do
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )
      shelter2 = Shelter.create!(foster_program: true, name: "Rescue Puppy", city: "Los angeles", rank: 5 )

      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
      pet2 = shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 
      pet3 = shelter2.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Pantera") 
      pet4 = shelter2.pets.create!(adoptable: true, age: 1, breed: "Goldendoodle", name: "Lucky") 

      applicant1 = pet4.applications.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
      applicant2 = pet3.applications.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.")
      applicant3 = pet1.applications.create!(name: "Martin", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80000, description: "Will treat dog as its own kid")
      applicant4 = pet2.applications.create!(name: "Ezequiel", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80001, description: "Has had one in the past and alway treated them with love")

      # As a visitor
      # When I visit an application's show page
      visit "/applications/#{applicant1.id}"
      # And that application has not been submitted,
      # Then I see a section on the page to "Add a Pet to this Application"
      expect(page).to have_content("Add a Pet to this Application:")
      # In that section I see an input where I can search for Pets by name
      expect(page).to have_field(:search)
      # When I fill in this field with a Pet's name
      fill_in :search, with: "Chop"
      # And I click submit,

      click_on("Submit Search")
      expect(current_path).to eq("/applications/#{applicant1.id}")
      expect(page).to have_content("Chop")
      # Then I am taken back to the application show page
      # And under the search bar I see any Pet whose name matches my search
    end
  end

  describe '#us 5' do
    it 'Add a pet to an application' do
      shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 8 )
      pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 

      applicant1 = Application.create!(name: "Martin", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80000, description: "Will treat dog as its own kid")

      # When I visit an application's show page
      visit "/applications/#{applicant1.id}"
      # And I search for a Pet by name
      fill_in :search, with: "Chop"
      # And I see the names Pets that match my search
      click_on("Submit Search")
      expect(page).to have_content("Chop")
      # Then next to each Pet's name I see a button to "Adopt this Pet"
      expect(page).to have_button("Adopt #{pet1.name}")
      # When I click one of these buttons
      click_on("Adopt #{pet1.name}")
      # Then I am taken back to the application show page
      expect(current_path).to eq("/applications/#{applicant1.id}")
      # And I see the Pet I want to adopt listed on this application
      expect(page).to have_content("Chop")

    end

    describe '#us 6' do
      it 'Has a section to submit an application' do
        shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )
        pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
        pet2 = shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 

        applicant1 = pet1.applications.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
        applicant1 = pet2.applications.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")

        visit "/applications/#{applicant1.id}"
        
        # And I have added one or more pets to the application
        fill_in :search, with: "Chop"
        click_on("Submit Search")
        click_on("Adopt Chop")

        fill_in :search, with: "Princess"
        click_on("Submit Search")
        click_on("Adopt Princess")


        within '.submit_application' do
            
          # Then I see a section to submit my application
          expect(page).to have_button("Submit")
          # And in that section I see an input to enter why I would make a good owner for these pet(s)
          expect(page).to have_field("Please tell us why you would be a good pet owner")

          # When I fill in that input
          fill_in :description, with: "Prefers dogs"
          # And I click a button to submit this application
          click_on "Submit Application" 
        end

        # Then I am taken back to the application's show page
        expect(current_path).to eq("/applications/#{applicant1.id}")

        # And I see an indicator that the application is "Pending"
        expect(page).to have_content("Pending") #check enums, don't know if Rodrigo did this
        # And I see all the pets that I want to adopt
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)
        # And I do not see a section to add more pets to this application

        expect(page).not_to have_content("Add a Pet to this Application") # remove header and + label, text field and button
      end
    end
  end
end