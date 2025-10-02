# Amazon Clone - Full-Stack E-Commerce Platform

A fully functional e-commerce platform built using **Flutter**, **Node.js**, and **MongoDB**. The project includes real-time user authentication, product management, order handling, and state management using Provider in Flutter.  

---

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **User Roles:** Admin and Buyer
- **Authentication:** JWT-based login/logout with session expiry
- **Product Management:** Add, update, delete, and list products
- **Order Management:** Place and track orders
- **Cart Functionality:** Add/remove products from the cart
- **Real-Time Data:** Responsive and optimized queries (<100ms)
- **State Management:** Provider for managing Flutter app state
- **Responsive UI:** Supports multiple screens with product details and search

---

## Technologies Used

- **Frontend:** Flutter, Dart, Provider, HTTP
- **Backend:** Node.js, Express.js
- **Database:** MongoDB
- **Authentication:** JWT (JSON Web Tokens)
- **Testing:** Unit tests for REST APIs

---

## Project Structure

### Server (Node.js & Express)

server/
├─ middlewares/
│ ├─ admin.js
│ └─ auth.js
├─ models/
│ ├─ order.js
│ ├─ product.js
│ ├─ rating.js
│ └─ user.js
├─ routes/
│ ├─ admin.js
│ ├─ auth.js
│ ├─ product.js
│ └─ user.js
├─ index.js
├─ package.json
├─ package-lock.json
└─ vercel.json


### Flutter App (Frontend)

lib/
├─ common/
│ └─ widgets/
├─ constants/
├─ features/
│ ├─ account/
│ ├─ address/
│ ├─ admin/
│ ├─ auth/
│ ├─ cart/
│ ├─ home/
│ ├─ order/
│ ├─ Product_detail_screen/
│ └─ search/
├─ models/
│ ├─ order_model.dart
│ ├─ product_model.dart
│ ├─ rating.dart
│ └─ user.dart
├─ providers/
│ └─ user_provider.dart
├─ main.dart
└─ routes.dart


---

## Installation

### Backend

1. Navigate to the server folder:
   ```bash
   cd server
   ```
2. Install dependencies:
  ```bash
   npm start
   ```
4. Create a .env file and set your environment variables (MongoDB URI, JWT secret, etc.)

### Frontend

1. Navigate to the Flutter app folder:
   ```bash
   cd lib
   ```

2. Install dependencies:
 ```bash
flutter pub get
```
3. Run the app:
```bash
flutter run
```

## API Endpoints

# 

*   **Auth**
    
    *   `POST /api/auth/login` – Login
        
    *   `POST /api/auth/register` – Register
        
*   **Products**
    
    *   `GET /api/products` – List all products
        
    *   `POST /api/products` – Add a product (Admin only)
        
    *   `PUT /api/products/:id` – Update a product (Admin only)
        
    *   `DELETE /api/products/:id` – Delete a product (Admin only)
        
*   **Orders**
    
    *   `POST /api/orders` – Create a new order
        
    *   `GET /api/orders` – List user orders
        
*   **Users**
    
    *   `GET /api/users` – List all users (Admin only)
        
    *   `GET /api/users/:id` – Get user details
## Contributing

## 

1.  Fork the repository
    
2.  Create a new branch (`git checkout -b feature-name`)
    
3.  Commit your changes (`git commit -m 'Add feature'`)
    
4.  Push to the branch (`git push origin feature-name`)
    
5.  Create a Pull Request
## License

## 

This project is licensed under the MIT License.

