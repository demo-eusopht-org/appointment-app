
#  🗓️ Appointment App

**Appointment App** is a Flutter-based mobile application designed for booking appointments across various fields, such as healthcare, education, and professional services. The app integrates both **GetX** and **Flutter Bloc** for efficient state management and ensures a seamless user experience with real-time updates and organized workflows.

---


## 🛠️ Tech Stack
- 🐦 **Flutter**: Version 3.24.3
- 🎯 **Dart**: Version 3.5.3
- 🔄 **Flutter Bloc**: Version 8.1.4
- ⚡ **GetX**: Version 4.6.5


---

## 📁 Folder Structure

The project is organized into the following folder structure for better modularity and maintainability:

lib/
├── 🛠️ auth_api/                       # Authentication-related API services
│   └── api_services.dart          
├── 🌐 api_services/                   # Service that interacts with APIs
│   └── api.dart                       
├── 💼 model/                          # Data models for various entities
│   ├── appointment/                   
│   │   └── get_all_appointments.dart  
│   ├── auth_model/                    # User authentication model
│   │   └── auth_model.dart            
│   ├── get_business/                  # Business information models
│   │   ├── get_business_branch.dart   
│   │   └── get_business_data.dart     
│   ├── get_consultant_model/          # Consultant-related models
│   │   ├── get_consultant_branches.dart
│   │   ├── get_consultant_model.dart  
│   │   └── get_consultant_schedule.dart
│   ├── get_customer_model/            # Customer-related models
│   │   └── get_customer_model.dart    
│   ├── get_services/                  # Service-related models
│   │   └── get_services_model.dart   
├── 💾 services/                       # Local storage services
│   ├── get_services.dart              
│   ├── local_storage_service.dart     
│   ├── locator.dart                   
│   └── share_service.dart             
├── 🖥️ views/                          # User interface views/screens
│   ├── appointments/               
│   ├── assign_branch/                 
│   ├── assign_consultant_schedule/   
│   ├── auth/                       
│   ├── common_widgets/              
│   ├── consultant/                  
│   ├── consultant_branch/             
│   ├── customer/                      
│   ├── home/                        
│   ├── notifications/                
│   ├── onboarding/                    
│   ├── option/                       
│   └── services/
│   └── settings/                      
│   └── thankyou Screen/                      
│   └── timetable/
│   └── user Profile/                      
│   └── Verify Email/                      
│   └── widgets/            
│   └── Splash.dart

├── 🚀 main.dart               
├── 📄 pubspec.yaml


--- 
## 🚀 Getting Started

Follow these instructions to set up and run the app locally.

### ✅ Prerequisites

Ensure the following tools are installed on your system: - **Flutter SDK**: Install the latest version from the [Flutter website](https://flutter.dev/docs/get-started/install). - **Git**: Install Git for version control. - **Code Editor**: Use an editor like **VS Code** or **Android Studio** for development.

### 🛠️ Installation Steps
1. **Clone the repository**: ```bash git clone https://github.com/appointment-eusopht-org/mobile-app.git

2. **Install dependencies**
   Run the following command to fetch and install required packages:
```bash
flutter pub get
```
3. **Run the app**
``` bash
flutter run
```
