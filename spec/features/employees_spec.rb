require "rails_helper"

RSpec.feature "Employees", type: :feature do
  let!(:employee) { create(:employee, first_name: "Jānis", last_name: "Vītiņš", email: "example@email.com") }

  scenario "User fails to create an employee with invalid parameters" do
    visit new_employee_path

    fill_in "Vārds", with: ""
    fill_in "Uzvārds", with: ""
    fill_in "E-pasts", with: ""
    click_button "Izveidot jaunu darbinieku"

    expect(page).to have_content("Vārds nevar būt tukšs")
    expect(page).to have_content("Uzvārds nevar būt tukšs")
    expect(page).to have_content("E-pasts nevar būt tukšs")

    fill_in "E-pasts", with: "invalid_email"
    click_button "Izveidot jaunu darbinieku"

    expect(page).to have_content("E-pasts nav pareizs")
  end

  scenario "User successfully creates a new employee" do
    visit new_employee_path

    fill_in "Vārds", with: "Anna"
    fill_in "Uzvārds", with: "Puriņa"
    fill_in "E-pasts", with: "some@email.com"
    click_button "Izveidot jaunu darbinieku"

    expect(page).to have_content("Darbinieks veiksmīgi izveidots")
    expect(page).to have_content("Anna Puriņa")
    expect(page).to have_content("some@email.com")
  end

  scenario "User edits an existing employee" do
    visit edit_employee_path(employee)

    fill_in "Vārds", with: "Janka"
    click_button "Rediģēt darbinieku"

    expect(page).to have_content("Darbinieks veiksmīgi rediģēts")
    expect(page).to have_content("Janka Vītiņš")
  end

  scenario "User deactivates an employee" do
    visit employees_path

    within("tr", text: employee.full_name) do
      click_link "Deaktivizēt"
    end

    expect(page).to have_content("Darbinieks veiksmīgi deaktivizēts")
    expect(page).not_to have_content(employee.full_name)
  end
end
