# System Design & UI Specifications

## 1. System Architecture
Aplikasi mengadopsi **Feature-Driven Architecture** dengan prinsip *Separation of Concerns*:
*   **UI Layer:** Dibangun dengan Flutter Widgets, menggunakan *BackdropFilter* untuk efek visual.
*   **State Management Layer:** Dikelola menggunakan `flutter_riverpod` (StateNotifier) untuk memastikan UI selalu reaktif terhadap perubahan data.
*   **Data Layer:** Abstraksi *Repository Pattern* yang menangani komunikasi HTTP/Socket dengan Supabase SDK.

## 2. UI/UX Specifications (Earthy Glassmorphism)
Desain mengacu pada gaya visual modern *Smart Home Dashboards*.

*   **Color Palette:**
    *   Background Gradient: `#2A2820` to `#14130E` (Earthy Dark Olive).
    *   Glass Overlay: `Colors.white.withOpacity(0.1)` dipadukan dengan `BackdropFilter (sigmaX: 10, sigmaY: 10)`.
    *   Accent/Text: `Colors.white` dan `#EAE8E3` (Warm Off-white).
*   **Typography:** `GoogleFonts.poppins` untuk kesan geometris dan bersih.
*   **Shapes:** Sudut sangat melengkung (*High border-radius*, > 20px) pada *Card* dan bentuk kapsul (*Pill-shape*) untuk tombol.

## 3. Database Schema (Supabase Target)
Tabel terhubung: `feed_logs`
*   `id`: UUID (Primary Key)
*   `tanggal`: Date
*   `jam`: Time
*   `created_at`: Timestamp (Auto-generated)