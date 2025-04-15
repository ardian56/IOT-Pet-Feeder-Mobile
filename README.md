# 🐾 IoT Pet Feeder (Mobile Client)

A sleek, native mobile client for an existing IoT Pet Feeder ecosystem. Designed with a premium **Glassmorphism** aesthetic, this app allows users to seamlessly schedule feeding times and monitor IoT execution logs.

Built with **Flutter** and **Riverpod**, it communicates directly with **Supabase**, serving as a mobile companion to the React-based web dashboard.

## ✨ Features
*   **Earthy Glassmorphism UI:** A gorgeous, translucent user interface with smooth background blurs.
*   **Native Scheduling:** Quick-action bottom sheets utilizing native device Date and Time pickers.
*   **Reactive State:** Powered by Riverpod for instantaneous UI updates upon scheduling.
*   **BaaS Integration:** Ready to sync with Supabase PostgreSQL.

## 🚀 Tech Stack
*   **Framework:** Flutter (Dart)
*   **State Management:** Riverpod (`flutter_riverpod`)
*   **Backend:** Supabase (`supabase_flutter`)
*   **Design Tools:** `google_fonts`, `intl`

## 📦 Project Structure
```text
lib/
 ├── core/          # Constants, Theme, and Configurations
 ├── models/        # DTOs (FeedLog)
 ├── repositories/  # Supabase integration layer
 ├── providers/     # StateNotifier and Riverpod logic
 └── ui/            # Screens, Glass Cards, and Bottom Sheets