# README

## Docker setup (recommended)

`docker compose up` 

Will create the database and start the server on port 3000 (http://localhost:3000)


## Setup

Please run the following commands:

`bin/rails db:create`

`bin/rails db:migrate`

`bin/rails db:seed`


## URL

http://localhost:3000/invoices

## Improvements
- Fix responsiveness
- Better validation (Javascript with Stimulus instead of server-side only)
- Cleanup unnecessary files
- Small code refactoring to improve readability (Use Services)
- Unit tests with RSpec
- Tests with Capybara