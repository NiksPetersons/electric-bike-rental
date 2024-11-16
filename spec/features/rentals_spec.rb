require "rails_helper"

RSpec.feature "Rentals", type: :feature do
  let!(:bike) { create(:bike, name: "Velosipēds 1") }
  let!(:employee) { create(:employee, first_name: "Jānis", last_name: "Vītiņš", email: "example@email.com") }

  scenario "User fails to create a rental with invalid parameters" do
    visit new_rental_path

    fill_in "Sākuma laiks", with: ""
    fill_in "Beigu laiks", with: ""
    click_button "Rezervēt velosipēdu"

    expect(page).to have_content("Darbinieks jābūt izvēlētam")
    expect(page).to have_content("Velosipēds jābūt izvēlētam")
    expect(page).to have_content("Sākuma laiks nevar būt tukšs")
    expect(page).to have_content("Beigu laiks nevar būt tukšs")

    fill_in "Sākuma laiks", with: Time.current.strftime("%Y-%m-%d %H:%M")
    fill_in "Beigu laiks", with: (Time.current - 1.hour).strftime("%Y-%m-%d %H:%M")
    click_button "Rezervēt velosipēdu"

    expect(page).to have_content("Beigu laiks nevar būt vienāds vai pirms sākuma laika")
  end

  scenario "User successfully creates a new rental" do
    visit new_rental_path

    select employee.full_name, from: "Darbinieks"
    select bike.name, from: "Velosipēds"
    fill_in "Sākuma laiks", with: Time.current.strftime("%Y-%m-%d %H:%M")
    fill_in "Beigu laiks", with: (Time.current + 1.hour).strftime("%Y-%m-%d %H:%M")
    click_button "Rezervēt velosipēdu"

    expect(page).to have_content("Rezervācija veiksmīga")
    expect(page).to have_content(bike.name)
    expect(page).to have_content(employee.full_name)
  end

  scenario "User cancels a rental" do
    rental = create(:rental, bike: bike, employee: employee)

    visit rentals_path

    within("tr", text: rental.bike.name) do
      click_link "Atcelt"
    end

    expect(page).to have_content("Rezervācija atcelta")
    expect(page).not_to have_content(rental.bike.name)
  end
end
