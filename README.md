# Lynx Online Banking System

* Rails v6

* Database: PostgreSQL.

* How to run the test suite!!!

* Services (job queues, cache servers, search engines, etc.) --> maybe ElasticSearch :)

* Deployment instructions --> Heroku

## How to setup development env

```
git clone <repo-url>

cd lynx

bundle install  # install gems

rake db:create # create DB

rake db:migrate # migrations

rake routes # see routes

rails s  # start the server at localhost:3000
```

## Task allocation

Please only change these files...

### Login, sign up...

Models: /user.rb

Controllers: /users/ folder (registrations, sessions, passwords)

Views: /users and /dashboard folders

Assets: stylesheets/home.scss, dashboard.scss

### List of accounts and so

Models: /account.rb

Controllers: /accounts/ folder

Views: /accounts/ folder

Assets: accounts.scss

### List of transactions

Models: /transaction.rb

Views: /transactions folder related to show

Controllers: transactions actions: show

### Payments

Models: /transaction.rb

Views: /transactions folder related to create and new

Controllers: transactions actions: create and new

### Admin

MVC of admin: dashboard, add generate random transactions 

## How to contribute

- Use a branch apart (with a meaningful name)
- Pull requests to the main branch should be reviewed by **at least 1** member
- Raise issues actively
- Use test driven development (we will not merge requests without unit tests)
