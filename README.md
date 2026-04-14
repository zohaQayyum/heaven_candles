# Heaven Candles 🕯️

A full-featured e-commerce web application built with Ruby on Rails, featuring product management, shopping cart, order checkout, and an admin panel.

## 🌐 Live Demo
**[https://heaven-candles.onrender.com](https://heaven-candles.onrender.com)**

> **Note:** Hosted on Render free tier. First load after inactivity may take 30-60 seconds.

**Demo Credentials:**
- Admin: `admin@heavencandles.com` / `password123`
- Customer: `user@heavencandles.com` / `password123`

## 📸 Screenshots

### Products Page
![Products Page](screenshots/products.png)

### Admin Products Page
![Admin Products Page](screenshots/admin_product_details.png)

### Admin Orders
![Admin Orders](screenshots/admin_orders.png)

### Admin Order Detail
![Admin Order Detail](screenshots/admin_order_detail.png)

### My Orders (customer) 
![My Orders](screenshots/my_orders.png)

### My Cart 
![My Cart](screenshots/my_cart.png)

### Checkout page 
![Checkout Page](screenshots/checkout.png)

## ✨ Features
- User authentication (sign up, login, logout) with Devise
- Product catalog with categories and variants (size/price)
- Full-text product search using pg_search (prefix + trigram matching)
- Filter products by category with auto-submit
- Image uploads with Active Storage + Cloudinary
- Shopping cart with session storage and stock validation
- Order checkout with shipping details
- Order history with status tracking for users
- Admin panel — manage products, categories, variants and images
- Admin order management — view and update order statuses
- Order status transitions with business rule validation (pending → processing → shipped → delivered)
- Responsive UI with Bootstrap 5

### Email Notifications
Uses Action Mailer with Sidekiq background jobs and Gmail SMTP for:
- Welcome email on signup
- Order confirmation on purchase  
- Status update when admin changes order status

## 🛠️ Tech Stack
- **Framework:** Ruby on Rails 7.1
- **Language:** Ruby 3.2.2
- **Database:** PostgreSQL
- **Search:** pg_search (full-text + trigram)
- **Authentication:** Devise
- **Background Jobs:** Sidekiq
- **Image Storage:** Active Storage + Cloudinary
- **Styling:** Bootstrap 5
- **Deployment:** Render.com

## ⚙️ Local Setup
```bash
# Clone the repo
git clone https://github.com/zohaQayyum/heaven_candles.git
cd heaven_candles

# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Set environment variables
# Create .env file with:
# CLOUDINARY_CLOUD_NAME=your_cloud_name
# CLOUDINARY_API_KEY=your_api_key
# CLOUDINARY_API_SECRET=your_api_secret

# Start server
rails server
```

## 📝 Technical Notes

### Shopping Cart
Currently session-based for simplicity. In production, a database-backed cart using `carts` and `cart_items` tables would provide persistence across devices and sessions.

### Image Uploads
Uses Active Storage with Cloudinary as the storage backend, ensuring images persist across deployments and are served via CDN globally.

### Order Status
Implements state machine-style transition validation — invalid status jumps (e.g. pending → delivered) are rejected at the model level.

### Search
Uses PostgreSQL's full-text search via pg_search gem with prefix and trigram matching, allowing partial word searches across product names and descriptions.
