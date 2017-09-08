# Inflator

Web service which estimates UK house price changes for a given period


## How to use the web service
Example:
localhost:4000/api/get_inflated_price?from=01/09/2007&to=01/09/2008&price=10000&borough=Aberdeenshire

## Seed DB from the UK index csv file
  I've setup 2 tasks to help with seeding the DB from the csv file
  * Import from local csv file : mix inflator.import_csv "/path/to/filename"
  * Download csv file from url : mix inflator.download_csv "https/url/path" i.e
  mix inflator.download_csv 'http://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data/UK-HPI-full-file-2016-05.csv'

  By default it will copy the file to /temp/index_csv_seed.csv in the app directory

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
