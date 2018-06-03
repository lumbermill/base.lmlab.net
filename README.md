# base.lmlab.net
Online shopping system for small(individual) distributors.

## Actors
- User
  - can sign in/out.
  - can remove their own account.
  - can regist their distributor by ID.
  - can view the profile of their distributor.
  - can change their password and other profiles.
  - can view all products on the database.
  - can add/remove products to the shopping cart.
  - can place/cancel their orders.
    - cancellation is only allowed before the order will be shipped.
  - can view the list of their current/past orders.
- Distributor
  - can behave as an User.
  - can view all orders from their members.
    - member: Users who belong to the distributor.
    - can change status of the orders.
  - can show/hide announcements for their members on the dashboard page.
- Admin
  - has all privileges.
  - can add/edit/remove products.
  - can show/hide announcements on the top page.

### Users environment
- Mainly users and distributors access the site through mobile phones(iPhone, Android).
- Admin has laptop PC.


## Features
- The system supposes to work as an support tools for other networks(like Amway).
- Does not support the any payment methods. Just utilises the flow to distribute products.


## Views
- root:
- dashboard:
  - cart:
  - orders:
  - products:


## Status of order
- in-cart: The product is in the cart. It can be removed.
- ordered: Just after the user pushed the order button. It's cancellable.
- shipping: Just after the distributor pushed the accept button.
  - The order can not be canceled on the site.
  - Distributer has the responsibility to deliver the products to Users.
- arrived: Just after the user received products.
- canceled: After the order had been canceled.


## Database
See railsapp/db/schemas.rb


## Gems
- bootstrap - for responsible layouts.
- devise - for authenticate users.
- paper_trail - for versioning.
