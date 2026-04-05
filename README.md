# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# heaven_candles
E-commerce application for a candle store built with Ruby on Rails 7, focusing on clean architecture, database integrity, and scalable domain design.

## Technical Decisions

### Shopping Cart Implementation
The cart is currently session-based for simplicity. This means:
- Cart data is temporary and cleared when the session expires
- Cart does not persist across different devices or browsers

**Production improvement:** In a production environment, the cart would be database-backed using a `carts` and `cart_items` table linked to the user, allowing cart persistence across sessions and devices, and enabling business analytics on cart abandonment.
