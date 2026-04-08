# Heaven Candles 🕯️

A full-featured e-commerce web application built with Ruby on Rails, featuring product management, shopping cart, order checkout, and an admin panel.

## 🌐 Live Demo
**[https://heaven-candles.onrender.com](https://heaven-candles.onrender.com)**

> **Note:** Hosted on Render free tier. First load after inactivity may take 30-60 seconds.

**Demo Credentials:**
- Admin: `admin@heavencandles.com` / `password123`
- Customer: `user@heavencandles.com` / `password123`

## ✨ Features
- User authentication (sign up, login, logout) with Devise
- Product catalog with categories and variants (size/price)
- Image uploads with Active Storage + Cloudinary
- Shopping cart with session storage and stock validation
- Order checkout with shipping details
- Order history for users
- Admin panel — manage products, categories, variants and images
- Responsive UI with Bootstrap 5

## 🛠️ Tech Stack
- **Framework:** Ruby on Rails 7.1
- **Language:** Ruby 3.2.2
- **Database:** PostgreSQL
- **Authentication:** Devise
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
