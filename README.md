## SEG small group project 

* Team: Lynx 
* Members: Zhuo Ying Jiang Li, Shumeng Liu, Tao Huang, Yuxin Hong, Tung-sen Wu
* Deployed to Heroku: https://warm-headland-19695.herokuapp.com/
* Administrative interface login url (the user needs to be an admin to be able to login as an administrative user, otherwise the page will not be found): https://warm-headland-19695.herokuapp.com/admin/login 

*Steps to access the admin panel*: 

1. Log in using the Administrative user credentials (email/password), doing step 2 without this would result in a 404 page. 
2. Go to the admin link stated above. 
3. Enter the correct admin passphrase (admin area passphrase), and you are ready to go! 

### User Credentials 

* Normal User

    Email: roland.budka@gmail.com 

    Password: jkrolling2001 

* Administrative User 

    Email: tom.waterson@gmail.com 

    Password: SEGproj3ctover 

    Admin Area passphrase: 4dminLynx!123 

##### Code reuse and references 

1. Bootstrap CSS (via CDN) 
2. FontAwesome icons 
3. Google Fonts 
    * Lato, sans-serif 
    * Abhaya Libre, serif 
    * Merriweather, serif 
    * Assistant, sans-serif 
    * Open Sans, sans-serif 

4. Gems 
    1. Devise: for authentication of users  
    2. Rubocop: for code standard checking 
    3. Rufo and htmlbeatifier: code styling/formatter 
    4. Kramdown: render markdown  
    5. Simplecov: code coverage report generator  
    6. Rails-controller-testing: use for testing controller tests 
    7. Minitest-reporters: rails testing support  
    8. Caxlsx: generate XLS documents 

5. https://v4.bootcss.com/docs/examples/dashboard/ in app/views/dashboard/_navbar.html.erb. Number of lines of reused code: 64 

---

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

## How to run the test suite

Generate code coverage support: 
```
rm -rf coverage/ && DISABLE_SPRING=1 COVERAGE=1 rails test
```

Run without generating coverage report:
```
rails test
```

## How to contribute

- Use a branch apart (with a meaningful name)
- Pull requests to the main branch should be reviewed by **at least 1** member
- Raise issues actively
- Use test driven development (we will not merge requests without unit tests)
