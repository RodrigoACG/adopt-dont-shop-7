require "rails_helper"

RSpec.describe "New Application" do

  describe '#us 3' do
    it 'Makes sure the application is fully filled out' do
      # As a visitor
      visit "/applications/new"
      # When I visit the new application page#   
      fill_in :name, with: ""
      fill_in :street_address, with: "1234 Washington st"
      fill_in :city, with: "Los Angeles"
      fill_in :state, with: "California"
      fill_in :zip_code, with: 90028
      fill_in :description, with: "I would make it a great home because I have a tone of space and always loved dogs since I was younger!"
      click_on("Submit")
      # And I fail to fill in any of the form fields
      # And I click submit
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: All fields must be filled out")
      # Then I am taken back to the new applications page
      # And I see a message that I must fill in those fields.
    end
  end
end