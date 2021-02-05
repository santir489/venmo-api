# Venmo

Venmo is a mobile payment service which allows friends to transfer money to each other. It also has some social features like show your friend's payment activities as feed.

This project follows the community best practices in terms of standards, security and maintainability, integrating a variety of testing and code quality tools 

* Ruby version
2.7.1

# How to use

1. Clone this repo
2. Install PostgreSQL in case you don't have it
3. Create your `database.yml` and `application.yml` file
4. `bundle install`
6. `rake db:create`
7. `rake db:migrate`
8. `rake db:seed`
9. `rspec` and make sure all tests pass
10. `rails s`
11. You can now try your REST services!

# Code quality

With `rake code_analysis` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices#custom-configuration) Edit `config/rails_best_practices.yml`
- [Bullet](https://github.com/flyerhzm/bullet#whitelist) You can add exceptions to a bullet initializer or in the controller


# Entity-Relationship Diagram

<img src="/erd.png"/>

# Design

## Models
* Users: represents a user in the system

* PaymentAccount: represents an account of a User where the balance is stored

* Payment: represents an event of a user transfering money to a friend

* Firendship: represents a friendship relationship between two users

## Main services

* FeedService: 
  Is in charge of fetching the feed for a specific user.

* FriendshipService:
  Is in charge of finding friends up to second degree of a specific user.

* PaymentAccountService:
  Is in charge of increase or decrease an account balance

* PaymentService:
  It handles the payment transcation

* MoneyTransferService
  Is in charge of transfer money from an external source to an account (mock service)


### Notes

* Namespaces api/v1 were added to handle different versions.
* When a User is created, a PaymentAccount is created and associated to the User.
* If a User stop being friend with another User, User will not see previous payments of the another User in the feed section.

# Api doc

## Available endpoints

***GET balance***

`GET /api/v1/user/{​id}​/balance`

Returns user's balance

Response example:
```
{
    "user": {
        "balance": 7000.0
    }
}
```


***GET feed***

`GET /api/v1/user/{​id}​/feed`

Returns user's feed.
A page parameter is optional

Response example:
```
{
  "payments": [
    {
        "id": 9,
        "message": "Cavani paid Rashford on February 05, 2021 - bet"
    },
    {
        "id": 4,
        "message": "Martial paid Henderson on February 03, 2021 - Supermarket"
    }
  ],
  "pagy": {
    "page": 1,
    "last": 1,
    "pages": 1,
  }
}
```

***POST payment***

`POST /api/v1/user/{​id}​/payment`

Creates a payment

Parameters:
* friend_id *(integer) friend user id*
* amount *(float) payment amount*
* description *(text) payment description*

Body example:
```
{
    "friend_id": "1",
    "amount": "10",
    "description": "bet"
}
```

If the payment was created successfuly, returns 200 status code


## Heroku
The app is deployed in Heroku.
Check it out on this link:
https://venmo-api.herokuapp.com/api/v1

Seeds schema was loaded.

## Postman collection

You can get Postman collection [here](venmo-api.postman_collection.json)

# Seeds
Run `rake db:seed` to load the following inital friendships

<img src="/seed_friendships.png"/>


Creates the following payments

```
Sender: Cavani
Receiver: Rashford
Amount: 100
Description: 'Car'

Sender: Cavani
Receiver: Fred
Amount: 5
Description: 'Dinner'

Sender: Fred
Receiver: Martial
Amount: 10
Description: 'Vacation'

Sender: Martial
Receiver: Henderson
Amount: 150
Description: 'Supermarket'

Sender: Henderson
Receiver: Xisco
Amount: 40
Description: 'Day out'

Sender: Damiani
Receiver: Ruglio
Amount: 5
Description: 'Dinner'
```

And updates the following balances
```
Cavani: 7000
Fred: 20
Martial: 500
Damiani: 10
Ruglio: 120
```
