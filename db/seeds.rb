# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Add users
User.create!(
  # admin user
  [{
    firstname: 'Tom',
    lastname: 'Waterson',
    email: 'tom.waterson@gmail.com',
    password: 'SEGproj3ctover',
    birth_date: Date.new(2001, 11, 28),
    phone: '+44 07740271205',
    is_female: false,
    postcode: 'WC2N 5RJ',
    address_line_1: '1 Strand',
    address_line_2: 'London',
    country: 'United Kingdom',
    admin: true,
    admin_passphrase_digest: '4824e89b43d8ca05bef6fea622f2920962fc7b57c9faccaa28657d762ecf663c' # 4dminLynx!123 SHA-256
  },
   {
     firstname: 'Roland', # normal user
     lastname: 'Budka',
     email: 'roland.budka@gmail.com',
     password: 'jkrolling2001',
     birth_date: Date.new(2001, 11, 28),
     phone: '+44 07740271205',
     is_female: false,
     postcode: 'WC2N 5RJ',
     address_line_1: '1 Strand',
     address_line_2: 'London',
     country: 'United Kingdom'
   }]
)

# Accounts
Account.create!(
  [{
    user_id: User.first.id,
    balance: 1000,
    account_number: '14245160928142',
    cvv: 123,
    expiry_date: Date.new(2021, 10, -1),
    currency: 'GBP'
  },
   {
     user_id: User.first.id,
     balance: 5000,
     account_number: '81235025831941',
     cvv: 123,
     expiry_date: Date.new(2021, 10, -1),
     currency: 'USD'
   },
   {
     user_id: User.first.id,
     balance: 1000,
     account_number: '92109512431521',
     cvv: 123,
     expiry_date: Date.new(2021, 10, -1),
     currency: 'GBP'
   },
   {
     user_id: User.last.id,
     balance: 1000,
     account_number: '57035847940742',
     cvv: 123,
     expiry_date: Date.new(2021, 10, -1),
     currency: 'GBP'
   },
   {
     user_id: User.last.id,
     balance: 500,
     account_number: '14696478537063',
     cvv: 123,
     expiry_date: Date.new(2021, 10, -1),
     currency: 'GBP'
   },
   {
     user_id: User.last.id,
     balance: 1_000_000,
     account_number: '73042859175930',
     cvv: 123,
     expiry_date: Date.new(2021, 10, -1),
     currency: 'USD'
   }]
)

# Dealers, 10 default dealers for each currency
Dealer.create!(
  # GBP dealers
  [{
    currency: 'GBP',
    name: 'KFC',
    account_number: '89159665056376',
    min_amount: 2,
    max_amount: 30,
    frequency: 10,
    is_vendor: true
  },
   {
     currency: 'GBP',
     name: "McDonald's",
     account_number: '32744186879924',
     min_amount: 2,
     max_amount: 20,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'PC World',
     account_number: '80198274946420',
     min_amount: 50,
     max_amount: 2000,
     frequency: 1,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'Uniqlo UK',
     account_number: '21581338409656',
     min_amount: 10,
     max_amount: 200,
     frequency: 2,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'Uber',
     account_number: '30631016272081',
     min_amount: 10,
     max_amount: 80,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'Franklin Burke',
     account_number: '80170900562928',
     min_amount: 5,
     max_amount: 50,
     frequency: 3,
     is_vendor: false
   },
   {
     currency: 'GBP',
     name: 'Olivier Baxter',
     account_number: '22990565912310',
     min_amount: 500,
     max_amount: 5000,
     frequency: 1,
     is_vendor: false
   },
   {
     currency: 'GBP',
     name: 'London Underground TfL',
     account_number: '39075303921866',
     min_amount: 2,
     max_amount: 5,
     frequency: 50,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'Marks & Spenser',
     account_number: '57570088532696',
     min_amount: 10,
     max_amount: 100,
     frequency: 8,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'Archie Gallagher',
     account_number: '82998569321731',
     min_amount: 5,
     max_amount: 20,
     frequency: 1,
     is_vendor: false
   },
   {
     currency: 'USD',
     name: 'Subway',
     account_number: '91465785550560',
     min_amount: 2,
     max_amount: 20,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Starbucks',
     account_number: '99534265261238',
     min_amount: 4,
     max_amount: 30,
     frequency: 15,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Popeyes',
     account_number: '43845177719856',
     min_amount: 5,
     max_amount: 50,
     frequency: 3,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'H&M',
     account_number: '42544932041286',
     min_amount: 10,
     max_amount: 200,
     frequency: 2,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Uber',
     account_number: '40996271717634',
     min_amount: 10,
     max_amount: 80,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Noah Holland',
     account_number: '69551143821716',
     min_amount: 5,
     max_amount: 50,
     frequency: 3,
     is_vendor: false
   },
   {
     currency: 'USD',
     name: 'Patrick Fisher',
     account_number: '96194955070572',
     min_amount: 500,
     max_amount: 5000,
     frequency: 1,
     is_vendor: false
   },
   {
     currency: 'USD',
     name: 'JetBlue Airways',
     account_number: '92985210602485',
     min_amount: 100,
     max_amount: 500,
     frequency: 1,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Walmart',
     account_number: '33982069108167',
     min_amount: 10,
     max_amount: 1000,
     frequency: 8,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Charles Holmes',
     account_number: '72884718279087',
     min_amount: 5,
     max_amount: 20,
     frequency: 1,
     is_vendor: false
   },
   {
     currency: 'EUR',
     name: 'Quick',
     account_number: '60136372364381',
     min_amount: 5,
     max_amount: 30,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'Nordsee',
     account_number: '86456127105766',
     min_amount: 5,
     max_amount: 30,
     frequency: 3,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'Schwarz',
     account_number: '84659919268468',
     min_amount: 5,
     max_amount: 50,
     frequency: 10,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'ASOS',
     account_number: '27658940478201',
     min_amount: 10,
     max_amount: 150,
     frequency: 2,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'Uber',
     account_number: '80580240946844',
     min_amount: 10,
     max_amount: 80,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'Heledd Hasim',
     account_number: '63417364401143',
     min_amount: 5,
     max_amount: 50,
     frequency: 3,
     is_vendor: false
   },
   {
     currency: 'EUR',
     name: 'Viên Archippos',
     account_number: '28902938518673',
     min_amount: 500,
     max_amount: 5000,
     frequency: 1,
     is_vendor: false
   },
   {
     currency: 'EUR',
     name: 'Coop',
     account_number: '70641511940536',
     min_amount: 3,
     max_amount: 50,
     frequency: 8,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'Ikea',
     account_number: '98337043325156',
     min_amount: 10,
     max_amount: 100,
     frequency: 2,
     is_vendor: true
   },
   {
     currency: 'EUR',
     name: 'Zuzka Lubomír',
     account_number: '51102095415699',
     min_amount: 5,
     max_amount: 20,
     frequency: 1,
     is_vendor: false
   }]
)

# Add default style
Style.create!(bank_name: 'Lynx Online Bank')
