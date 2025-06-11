# 🧺 Acme Basket

A simple Ruby proof-of-concept for Acme Widget Co's new sales system.

## ✅ Features

- Automatically applies delivery rules based on subtotal
- Supports promotional rules such as "Buy One Get One Half Off"
- Unit tested with RSpec

## 🧠 Business Logic Assumptions

This project is built based on the following business rules and assumptions:

### 📦 Product Assumptions
-  Products have unique codes (R01, G01, B01) for identification
-  Prices are fixed per product catalog
-  All prices rounded to 2 decimal places

### 🛍 Offer Assumptions
- The **Buy-One-Get-One-Half-Off** offer:
	- Exclusive to R01 products only
	- Every 2nd R01 item gets 50% off
	- Odd quantities: last item pays full price
	- Discount applies to lower-priced item per pair

### 🚚 Delivery Fee Assumptions
- Delivery charges are based on **basket subtotal after discounts**:
  - Under **$50** → **$4.95**
  - **$50 to under $90** → **$2.95**
  - **$90 or more** → **Free delivery**
- Only one rate applies per order.

### 🧮 Calculation Assumptions
- Float arithmetic with 2-decimal rounding
- Total = (subtotal - discounts) + delivery charge


### 🧩 Extensibility Assumptions
- The system is designed to allow:
	- Supports multiple concurrent discount types
	- Pluggable delivery rules via Strategy pattern
	- Extensible for new products/pricing without core changes

## 🚀 Setup Instructions

## 🚀 Installation

```bash
git clone https://github.com/your-username/acme_basket.git
cd acme_basket
bundle install
```

## 🚀 Run Test Cases
```bash
bundle exec rspec
```

## 🚀 Run Code
```bash
bundle exec ruby main.rb
```
