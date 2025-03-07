# Product Requirements Document (PRD)

## **1. Overview**
### **Product Name:** QuickBite (Customer App)
### **Author:** Duke Azeta  
### **Date:** [Insert Date]  
### **Version:** 1.0  

### **1.1 Introduction**
QuickBite is a **food delivery app** that connects customers with restaurants and delivery drivers, ensuring a seamless, fast, and affordable food ordering experience. The app will focus on **affordability, efficiency, and inclusivity**, catering to busy professionals, students, and families.

### **1.2 Objectives**
✅ Simplify the food ordering process with an intuitive UI.  
✅ Ensure fast, affordable, and reliable deliveries.  
✅ Provide personalized experiences based on dietary preferences.  
✅ Offer real-time order tracking with accurate delivery estimates.  
✅ Support multiple payment options, including in-app wallets.  

## **2. Target Audience (User Personas)**
### **Persona 1: David Eze (Busy Professional, Age 27)**
- Works long hours and relies on food delivery for convenience.
- Needs **fast delivery & pre-order options**.

### **Persona 2: Aisha Abubakar (Budget-conscious Student, Age 21)**
- Limited spending capacity, wants **affordable food**.
- Needs **student discounts & transparent pricing**.

## **3. Key Features & User Stories**
### **3.1 Authentication & Onboarding**
**User Story:** _"As a new user, I want to sign up quickly using my phone number or email, so I can start ordering food immediately."_  
✅ Sign-up/Login via email, phone number (OTP), or Google.  
✅ Profile Setup (Name, Address, Dietary Preferences).  

### **3.2 Home & Restaurant Discovery**
**User Story:** _"As a customer, I want to browse nearby restaurants and filter based on price, cuisine, and ratings, so I can find my ideal meal easily."_  
✅ Search & Filters (Price, Cuisine, Ratings, Fast Delivery).  
✅ Featured & Recommended Restaurants.  
✅ Personalized Recommendations (based on past orders).  

### **3.3 Menu & Order Placement**
**User Story:** _"As a customer, I want to view a restaurant’s full menu with images and pricing, so I can make informed decisions."_  
✅ Restaurant Menu Page (Images, Prices, Availability).  
✅ Customizable Orders (Extra toppings, sides, portion size).  
✅ Add to Cart & Save for Later.  

### **3.4 Checkout & Payment**
**User Story:** _"As a customer, I want multiple payment options, so I can pay in the way that suits me best."_  
✅ Payment Methods (Card, Bank Transfer, Wallet, Cash on Delivery).  
✅ Apply Discounts & Promo Codes.  
✅ Schedule Orders (Pre-order meals for later).  

### **3.5 Order Tracking & Notifications**
**User Story:** _"As a customer, I want real-time updates on my order status and delivery location, so I know when to expect my food."_  
✅ Real-Time Order Updates (Confirmed → Preparing → Out for Delivery).  
✅ Live Map Tracking (Driver location + ETA).  
✅ Push Notifications (Order status updates).  

### **3.6 Profile & Rewards**
**User Story:** _"As a frequent customer, I want to earn rewards or discounts for my orders, so I feel valued."_  
✅ Loyalty Program (Cashback, Discounts for frequent orders).  
✅ Saved Addresses for quick reordering.  
✅ Order History & Reorder Functionality.  

## **4. Competitive Analysis**
| Feature | QuickBite | Chowdeck | Glovo | Foodcourt |
|---------|-----------|---------|--------|
| Affordable Delivery Fees | ✅ | ✅ | ❌ | ❌ |
| Local Cuisine Focus | ✅ | ✅ | ❌ | ✅ |
| Real-Time Tracking | ✅ | ✅ | ✅ | ✅ |
| Loyalty/Rewards | ✅ | ❌ | ❌ | ❌ |
| Pre-Order/Scheduling | ✅ | ❌ | ❌ | ❌ |

## **5. Technology Stack**
| Component | Technology |
|-----------|-------------|
| **Frontend** | Flutter |
| **Backend** | Supabase (Auth, Database, Real-time Tracking) |
| **Payments** | Flutterwave, Paystack, Stripe |
| **Maps & Tracking** | Google Maps API |
| **Notifications** | Firebase Cloud Messaging |

## **6. Success Metrics**
📈 **Customer Retention** – % of users who reorder within 30 days.  
📉 **Delivery Speed** – Average delivery time compared to competitors.  
⭐ **User Ratings** – Maintain an average rating of 4.5+ on Play Store.  

## **7. Development Timeline**
| Phase | Task | Duration |
|--------|---------|------------|
| **Phase 1** | UI/UX Design & Wireframes | 2 weeks |
| **Phase 2** | Authentication & Database Setup | 1 week |
| **Phase 3** | Home, Search, and Restaurant UI | 2 weeks |
| **Phase 4** | Ordering & Payment Integration | 2 weeks |
| **Phase 5** | Order Tracking & Notifications | 2 weeks |
| **Phase 6** | Testing & Deployment | 1 week |

## **8. Risks & Mitigation**
| Risk | Mitigation Strategy |
|------|---------------------|
| **High Competition** | Focus on local restaurants and student discounts. |
| **Slow Deliveries** | Optimize driver routes using AI-based mapping. |
| **User Drop-off** | Introduce personalized recommendations & loyalty rewards. |

## **9. Conclusion**
The QuickBite **Customer App MVP** will focus on:  
✅ **Fast & Affordable Food Delivery**.  
✅ **Seamless Ordering & Tracking**.  
✅ **Multiple Payment Options & Rewards**.  
