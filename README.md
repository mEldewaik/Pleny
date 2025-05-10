# 📱 Pleny iOS Engineer Interview Task

This project is a SwiftUI-based solution for the iOS Software Engineer technical assessment at Pleny. It implements user authentication, paginated posts, and post search functionality using Clean Architecture and modern iOS development practices.

---

## ✅ Features Implemented

- 🔐 **User Login**
  - Authenticated via [dummyjson.com](https://dummyjson.com/docs/auth#login)
  - Token-based session storage
- 📰 **Posts Listing**
  - Infinite scroll pagination
  - Static user/profile image mapping from design
- 🔍 **Search Functionality**
  - Debounced keyword search with Combine
  - Live result updates with highlighted text matches
- 🧱 **Clean Architecture**
  - Layers: Data, Domain, and Presentation
  - MVVM-C (Coordinator pattern)
  - Repository pattern
- 💾 **User Session Manager**
  - Built with `UserDefaults`
  - Mockable and test-friendly singleton
- 🧪 **Unit Testing**
  - `LoginUseCaseTests`
  - `SearchViewModelTests`
  - `PostsViewModelTests`
  - `UserSessionManagerTests`
  - 100% mocked and isolated logic

---

## 🗂 Project Structure

```
PlenyApp/
├── Data/
│   └── Session/
├── Domain/
│   └── UseCases/
│   └── Protocols/
├── Presentation/
│   └── Coordinators/
│   └── Scenes/
│   └── ViewModels/
│   └── Components/
├── Resources/
└── Tests/
    ├── DataTests/
    ├── DomainTests/
    └── PresentationTests/
```

---

## 🧪 Running Tests

In Xcode:

```
⌘ + U
```

Make sure `PlenyAppTests` is the active test target.

---

## 🛠 Tech Stack

- ✅ Swift 5.9+
- ✅ SwiftUI
- ✅ Combine
- ✅ MVVM-C
- ✅ Clean Architecture
- ✅ Unit Testing with XCTest
- ✅ Mock-driven development

---

## 🎨 Design Reference

Designs used were provided via Figma. All profile and post images used are **static assets** to match visual expectations, as the API does not return image data.

---

## 📦 APIs Used

- [Login API](https://dummyjson.com/docs/auth#login)
- [Posts API](https://dummyjson.com/docs/posts)
- [Search Posts](https://dummyjson.com/docs/posts#search-posts)

---

## 📍 Requirements

- Xcode 16.3+
- iOS 15+
- macOS Ventura or later

---

## ✅ Status

✅ Task complete and all requirements fulfilled.

