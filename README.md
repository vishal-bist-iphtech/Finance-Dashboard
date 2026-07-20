# 💰 Finance Dashboard

A modern Finance Dashboard application built with **SwiftUI** and **Core Data** that helps users track their income, expenses, savings goals, and spending insights. The application provides an intuitive interface for managing personal finances with real-time statistics, interactive charts, and persistent local storage.

---

## 📱 Project Description

The Finance Dashboard allows users to record financial transactions, monitor their monthly income and expenses, set savings goals, and visualize spending patterns through charts and summaries.

The project follows the **MVVM (Model-View-ViewModel)** architecture and uses **Core Data** for persistent storage, making it a scalable foundation for a personal finance management application.

---

## ✨ Features

### 📊 Dashboard
- Total Balance card
- Income and Expense summary
- Monthly financial summary
- Savings goal progress
- Recent transactions list
- Light/Dark mode support

### 💳 Transaction Management
- Add new transactions
- Edit existing transactions
- Delete transactions with confirmation
- Search transactions
- Categorize transactions
- Income & Expense support

### 📈 Insights
- Interactive donut chart using Swift Charts
- Expense breakdown by category
- Category legends
- Total expense visualization
- Animated chart interactions

### 💾 Data Persistence
- Store transactions using Core Data
- Persistent local storage
- Automatic UI updates after CRUD operations

### 🎨 UI & UX
- Modern SwiftUI design
- Responsive layouts
- Reusable components
- Dark & Light theme support using AppStorage
- Smooth animations

---

# 🏗️ Project Architecture

The project follows the **MVVM** architecture.

```
Views
   │
   ▼
ViewModels
   │
   ▼
Core Data
```

---

# 📂 Project Structure

```
Finance-Dashboard
│
├── Models
│   ├── Transaction
│   ├── ExpenseCategory
│   └── UserPreference
│
├── ViewModels
│   └── TransactionViewModel
│
├── Views
│   ├── Dashboard
│   ├── Transactions
│   ├── Insights
│   ├── AddTransactionView
│   ├── EditTransactionView
│   ├── HeaderCard
│   ├── BalanceCard
│   ├── MonthlySummary
│   ├── RecentTransactions
│   ├── TransactionCard
│   ├── DonutChart
│   └── InsightCard
│
├── CoreData
│   ├── PersistenceController
│   └── CoreDataService
│

```

---

# 🛠 Frameworks Used

- SwiftUI
- Core Data
- Swift Charts
- Foundation

---

# 🧠 What I Learned

This project helped me learn and practice:

### SwiftUI
- Views & View Composition
- NavigationStack
- TabView
- Lists
- ScrollView
- Forms
- Sheets
- Alerts
- State Management
- Property Wrappers
- Environment Values
- Animations
- Custom Components
- Dark & Light Mode

### Core Data
- Data Modeling
- CRUD Operations
- Persistent Storage
- Fetch Requests
- Relationships
- Core Data Stack
- Context Management

### MVVM
- Separation of Concerns
- ObservableObject
- @Published
- ViewModel Architecture
- Data Flow

### Swift Charts
- Donut Charts
- SectorMark
- Chart Styling
- Chart Animations
- Interactive Charts

### Swift Concepts
- Initializers
- Extensions
- Enumerations
- Computed Properties
- Bindings
- Optionals
- Closures
- Reusable Views

---

# 🚀 Getting Started

### Prerequisites

- macOS
- Xcode 26 or later
- iOS 26 SDK

---

### Installation

1. Clone the repository

```bash
git clone https://github.com/vishal-bist-iphtech/Finance-Dashboard.git
```

2. Open the project

```bash
cd Finance-Dashboard
open Finance-Dashboard.xcodeproj
```

3. Build and Run

- Select an iOS Simulator
- Press **⌘ + R**

---

# 📦 Data Storage

The application stores data locally using **Core Data**.

Stored data includes:

- Transactions
- User Preferences
- Savings Goal

---
