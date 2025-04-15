# Product Requirements Document (PRD)
**Project Name:** IoT Pet Feeder - Mobile App Client
**Platform:** Android & iOS (Flutter)

## 1. Overview
Aplikasi ini adalah *mobile client* untuk sistem IoT Pet Feeder. Proyek ini mendampingi Web Admin Panel berbasis React yang sudah ada, memungkinkan pengguna menjadwalkan dan memantau pemberian makan hewan peliharaan langsung dari *smartphone* dengan UI/UX yang modern dan *seamless*.

## 2. Goals & Objectives
*   **Mobilitas:** Memudahkan pengguna menambah jadwal IoT (Jam & Tanggal) tanpa harus membuka web *browser*.
*   **Estetika:** Meningkatkan pengalaman pengguna melalui desain *Glassmorphism* yang bersih dan premium.
*   **Real-time Synchronization:** Menampilkan status log jadwal yang tersinkronisasi langsung dengan Supabase PostgreSQL.

## 3. Core Features
1.  **Glassmorphism Dashboard:** Antarmuka utama yang menampilkan daftar log jadwal dengan filter visual (Chips).
2.  **Native Scheduler Input:** Modal *Bottom Sheet* dengan integrasi *Native DatePicker* dan *TimePicker* untuk input jadwal IoT yang akurat.
3.  **Log History List:** Tampilan riwayat eksekusi jadwal yang disusun secara kronologis.

## 4. Out of Scope
*   Kontrol manual *hardware* via Bluetooth/WiFi lokal. (Semua instruksi diproses secara asinkron melalui Supabase ke perangkat IoT).
*   Sistem Autentikasi. (Dianggap sebagai *internal controller app*).