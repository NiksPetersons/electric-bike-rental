require "rails_helper"

RSpec.feature "Bikes", type: :feature do
  let!(:bike) { create(:bike, name: "Velosipēds 1") }

  scenario "User fails to create a bike with invalid parameters" do
    visit new_bike_path

    fill_in "Nosaukums", with: ""  # Invalid input (empty name)
    click_button "Izveidot jaunu velosipēdu"

    expect(page).to have_content("Nosaukums nevar būt tukšs")  # Adjust this message based on your validation
  end

  scenario "User successfully creates a new bike" do
    visit new_bike_path

    fill_in "Nosaukums", with: "Velosipēds 2"
    click_button "Izveidot jaunu velosipēdu"

    expect(page).to have_content("Velosipēds veiksmīgi izveidots")
    expect(page).to have_content("Velosipēds 2")
  end

  scenario "User edits an existing bike" do
    visit edit_bike_path(bike)

    fill_in "Nosaukums", with: "Rediģēts velosipēds 1"
    click_button "Rediģēt velosipēdu"

    expect(page).to have_content("Velosipēds veiksmīgi rediģēts")
    expect(page).to have_content("Rediģēts velosipēds 1")
  end

  scenario "User deactivates a bike" do
    visit bikes_path

    within("tr", text: bike.name) do
      click_link "Deaktivizēt"
    end

    expect(page).to have_content("Velosipēds veiksmīgi deaktivizēts")
    expect(page).not_to have_content(bike.name)
  end
end
