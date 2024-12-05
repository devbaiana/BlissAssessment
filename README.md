![Bliss Applications](https://github.com/devbaiana/BlissAssessment/blob/master/LogoBliss.png)

# Bliss Assessment App

The **Bliss Assessment App** is an iOS application developed in **SwiftUI** as part of a technical evaluation. It showcases multiple features, including integration with GitHub APIs, local caching with Core Data, and dynamic pagination, providing users with a smooth and interactive experience.

---

## 🛠️ Technologies Used

- **SwiftUI**: Framework for building modern, reactive user interfaces.
- **Combine**: Manages asynchronous states and UI updates.
- **Core Data**: Local persistence for storing emojis and avatars.
- **GitHub API**: Integration with the following endpoints:
  - Emojis: `https://api.github.com/emojis`
  - Avatars: `https://api.github.com/users/:username`
  - Repositories: `https://api.github.com/users/:username/repos`
- **AsyncImage**: Optimized display of remote images.
- **Pagination**: Incremental data loading.

---

## 🌟 Features

### **1. Emojis**
- Displays a list of emojis fetched from the GitHub API.
- Allows random emoji selection via a dedicated button.
- Enables emoji removal with a double-click.
- Supports pull-to-refresh to restore the full emoji list.

### **2. Avatars**
- Searches for GitHub user avatars based on username input.
- Displays user profile pictures in real-time.
- Stores avatars locally for offline access.
- Provides a list of all searched avatars, with an option to delete them.

### **3. Repositories**
- Displays Apple’s public repositories.
- Implements dynamic pagination to load 10 repositories at a time as the user scrolls.
- Ensures seamless updates without freezing.


---
