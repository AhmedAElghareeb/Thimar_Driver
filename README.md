# Delivery App - Fast & Secure 🚚  
  
The Delivery App is designed to make it easy for users to have their orders delivered directly to their homes. With a focus on **security** and **reliability**, our licensed drivers ensure that your deliveries arrive safely and on time. You can also monitor and manage your delivery requests in real-time.  
  
## Some of app Screens 🎨  
  
<p align="center">  
  <img src="https://github.com/user-attachments/assets/70e2f793-8e80-45d4-9e7f-6e78983b8220" alt="Image 1" width="200"/>  
  <img src="https://github.com/user-attachments/assets/67001319-f079-414c-b917-613a8fd81a62" alt="Image 2" width="200"/>  
</p>  
  
<p align="center">  
  <img src="https://github.com/user-attachments/assets/a7e66721-228d-42fc-86fc-f260fcee6c8b" alt="Image 1" width="200"/>  
</p>  
  
## Features 🚀  
  
- **Home Delivery**: Easily order delivery to your doorstep.  
- **Car Integration**: Our service uses licensed cars to securely transport your goods.  
- **Security and Licensing**: All delivery vehicles are licensed, and you can see photos of the cars for added security.  
- **Notifications**: Receive real-time notifications about new orders. You can **accept** or **deny** orders directly from the app.  
- **Order Tracking**: Track your order from the moment it is placed until it is delivered.  
  
## Application Overview  
  
### Purpose and Scope  
  
The Thimar Driver app enables delivery personnel to:  
- Receive and view pending delivery orders  
- Accept or reject delivery assignments  
- Navigate to pickup and delivery locations  
- Track and update order status throughout the delivery process  
- Manage their profile and vehicle information  
- Communicate with customers and support  
  
### High-Level Architecture  
  
The Thimar Driver application follows a structured architecture that separates concerns across distinct layers while maintaining clear communication pathways between them.  
  
```mermaid  
flowchart TD  
    subgraph "Application Layers"  
        UI["UI Layer\n(Views & Widgets)"]  
        BL["Business Logic Layer\n(Blocs & Events)"]  
        DL["Data Layer\n(Models & Repositories)"]  
        SL["Service Layer\n(API & Storage)"]  
    end  
  
    UI --> |"User Interactions\n(Events)"| BL  
    BL --> |"State Updates"| UI  
    BL --> |"Data Requests"| DL  
    DL --> |"Data Responses"| BL  
    DL --> |"External Communication"| SL  
    SL --> |"Processed Data"| DL
Technology Stack
Category	Technologies
Framework	Flutter
State Management	Bloc Pattern (flutter_bloc)
Network Communication	Dio HTTP client
Local Storage	Shared Preferences
Dependency Injection	Kiwi
Maps & Location	Google Maps Flutter, Geolocator, Geocoding
Notifications	Firebase Messaging
Analytics	Firebase Analytics
UI Components	Flutter ScreenUtil, SVG, Animations
Icons Used in the App 🎨
We have integrated Flutter Icons to provide a sleek and modern user experience:

Delivery Truck Icon: Represents the delivery service.icons8-delivery-truck-36

Car Icon: Shows details of the delivery vehicle.
icons8-car-50

How to Use 📱
Place an Order: Use the app to place an order for home or work delivery.
Track Your Order: Monitor the delivery in real-time and receive notifications about the status of your order.
View Vehicle Details: See photos of the delivery vehicle and ensure it's licensed.
Manage Orders: Accept or deny orders from the notification screen.