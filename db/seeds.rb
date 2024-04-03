# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
shelter1 = Shelter.create!(foster_program: true, name: "Adopt a Pet", city: "Denver", rank: 5 )
shelter2 = Shelter.create!(foster_program: true, name: "Rescue Puppy", city: "Los angeles", rank: 5 )
shelter3 = Shelter.create!(foster_program: true, name: "ARMPR", city: "Denver", rank: 2 )

pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: "Dobermann", name: "Chop") 
pet2 = shelter1.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Princess") 
pet3 = shelter2.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Pantera") 
pet4 = shelter2.pets.create!(adoptable: true, age: 1, breed: "Goldendoodle", name: "Lucky") 
pet5 = shelter2.pets.create!(adoptable: true, age: 7, breed: "Shepherd", name: "Mick") 
pet6 = shelter2.pets.create!(adoptable: true, age: 10, breed: "Doberman", name: "Luna") 
pet7 = shelter2.pets.create!(adoptable: true, age: 2, breed: "Labrador", name: "Sunny") 

applicant1 = Application.create!(name: "Tyara", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90028, description: "Very loving person")
applicant2 = Application.create!(name: "Clarisa", street_address: "1234 Washington st", city: "Los Angeles", state: "California", zip_code: 90029, description: "Has one and looking for another and wanted one since a kid.")
applicant3 = Application.create!(name: "Martin", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80000, description: "Will treat dog as its own kid")
applicant4 = Application.create!(name: "Ezequiel", street_address: "4532 Washington st", city: "Denver", state: "Colorado", zip_code: 80001, description: "Has had one in the past and alway treated them with love")