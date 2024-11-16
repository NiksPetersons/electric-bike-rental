# Bike rental app | Ruby on Rails

### Note: The application is in Latvian

This is an MVC full-stack application that manages the rental of company bicycles.

The design was kept simple but functional since it did not seem necessary to use a UI Framework(like Bootstrap or Tailwind) for an application like this. I stuck to just SCSS.

## Technologies Used

- Ruby 3.3.0
- Rails 7.2.2
- PostgreSQL
- RSpec
- Capybara
- FactoryBot
- Shoulda-matchers

## Installation

After cloning the repository:

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Set up the database:
   ```bash
   bundle exec rails db:setup
   ```

3. Start the server:
   ```bash
   bundle exec rails server
   ```

5. Visit `http://localhost:3000` in your browser.

6. To run automated tests:
  ```bash
     bundle exec rspec
  ```

## Docker image setup(Hopfully works)

1. **Build the Docker Image**:
   Run the following command to build the Docker image:
   ```bash
   docker compose build
   ```

2. **Start the Application**:
   Use the following command to start the application and its services:
   ```bash
   docker compose up
   ```

## Features

- **Employee Management**: Add, edit, and deactivate employees.
- **Bike Management**: Add, edit, and deactivate bikes.
- **Rental Management**: Create, cancel, and export rentals.
- **Data Validation**: Ensures that all inputs are validated before submission and displays errors otherwise.

## Usage

- To create a new employee/bike, navigate to the employees/bikes section and fill out the form.
- To rent a bike, go to the rentals section, create a new rental, and select an employee, a bike, and the date-time you wish to rent the bike for.
- You can view all rentals on the rentals index page and export a list of rentals for a chosen date range.



![image](https://github.com/user-attachments/assets/0c4b9fa7-f0c8-434e-b9cb-b64c6882cdd3)

