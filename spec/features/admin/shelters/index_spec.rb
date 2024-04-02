require 'rails_helper'

RSpec.describe 'admin shelter index page', type: :feature do
  describe ' USER STORY #10' do
    describe ' as a admin when I visit /admin/shelters' do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

        visit "/admin/shelters"
      end
      
      it 'displays shelters in reverse alphabetical order' do
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end
    end 
  end
end