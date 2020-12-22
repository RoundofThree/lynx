# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Add users
User.create!([{ # admin user
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
              }])

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

# Dealers
Dealer.create!(
  [{
    currency: 'GBP',
    name: 'KFC dev',
    account_number: '00001000010001',
    min_amount: 2,
    max_amount: 30,
    frequency: 10,
    is_vendor: true
  },
   {
     currency: 'GBP',
     name: "McDonald's dev",
     account_number: '00001000010002',
     min_amount: 2,
     max_amount: 20,
     frequency: 5,
     is_vendor: true
   },
   {
     currency: 'GBP',
     name: 'PC World dev',
     account_number: '00001000010003',
     min_amount: 50,
     max_amount: 2000,
     frequency: 1,
     is_vendor: true
   },
   {
     currency: 'USD',
     name: 'Taco Bell dev',
     account_number: '00001000010004',
     min_amount: 4,
     max_amount: 30,
     frequency: 6,
     is_vendor: true
   }]
)

# Add default style
Style.create!(bank_name: 'Lynx Online Bank')
