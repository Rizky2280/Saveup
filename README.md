# SaveUp

SaveUp adalah aplikasi mobile offline untuk membantu pengguna merencanakan, mensimulasikan, menyimpan, dan memantau progres tujuan tabungan pribadi.

Aplikasi ini dibuat untuk orang yang ingin menabung dengan lebih tenang, terarah, dan tidak merasa terbebani oleh dashboard finansial yang terlalu kompleks. SaveUp bukan aplikasi bank, bukan budgeting suite, bukan investment app, dan tidak membutuhkan login atau koneksi backend cloud pada versi awal.

## Ringkasan Produk

SaveUp membantu pengguna menjawab pertanyaan utama sebelum membuat goal tabungan:

> “Kalau aku ingin mencapai target ini di bulan tertentu, berapa uang yang perlu aku sisihkan setiap bulan, dan apakah itu masih masuk dengan kemampuan menabungku?”

Sebelum sebuah goal benar-benar disimpan, pengguna akan melewati halaman simulasi. Di halaman ini, SaveUp menghitung estimasi tabungan bulanan yang dibutuhkan dan memberi status apakah goal tersebut masih **Realistic** atau sudah masuk kategori **Optimistic**.

Dengan cara ini, pengguna tidak langsung membuat goal secara asal. Mereka bisa melihat terlebih dahulu apakah targetnya masuk akal berdasarkan **monthly savings power** yang mereka isi saat setup profil.

## Nilai Utama Aplikasi

1. **Simulasi sebelum komitmen** — Goal tidak langsung disimpan ketika user mengisi form. User akan melihat simulasi terlebih dahulu.
2. **Tabungan berbasis kemampuan pribadi** — Status realistic/optimistic dihitung berdasarkan monthly savings power pengguna.
3. **Tracking manual yang sederhana** — User bisa menambahkan progress tabungan atau melakukan withdraw secara manual.
4. **Privasi dan offline-first** — Data disimpan secara lokal di perangkat. Tidak ada login, cloud sync, backend API, atau bank integration pada versi awal.

## Target Pengguna

SaveUp ditujukan untuk pengguna yang ingin:

- membuat beberapa goal tabungan pribadi
- mengecek apakah sebuah goal realistis sebelum disimpan
- mengetahui estimasi tabungan bulanan untuk tiap goal
- memantau progres tabungan secara manual
- mencatat deposit dan withdrawal
- menjaga data tetap lokal dan privat

## Core Flow Aplikasi

### 1. First Launch

Saat aplikasi pertama kali dibuka:

```txt
App Open
→ Splash
→ Check local profile
→ Jika belum ada profile:
   Onboarding
   First Time Setup
→ Home Dashboard
```

Pada setup awal, user mengisi:

- nama
- monthly savings power

Monthly savings power adalah kemampuan user untuk menabung per bulan. Nilai ini digunakan sebagai dasar untuk menentukan apakah sebuah goal realistic atau optimistic.

### 2. Main Tab Flow

Aplikasi memiliki empat halaman utama pada bottom navigation:

```txt
Home
Goals
Activity
Profile
```

Halaman yang menggunakan bottom navigation:

- Home Dashboard
- Goals List
- Activity
- Profile Settings

Halaman yang tidak menggunakan bottom navigation:

- Goal Detail
- Create Goal Flow
- Savings Simulation
- Add Progress Bottom Sheet
- Edit Profile Bottom Sheet

### 3. Create Goal + Simulation Flow

Flow utama pembuatan goal:

```txt
Home Dashboard / Goals List
→ Create Goal Flow
→ User mengisi goal
→ Tap Create goal
→ Savings Simulation
→ Tap Convert to goal
→ Save goal locally
→ Goal Detail / Goals List
```

Catatan penting:

- Tombol `Create goal` pada form berarti **simulate before save**.
- Goal belum disimpan ketika user menekan `Create goal`.
- Goal hanya disimpan setelah user menekan `Convert to goal` pada halaman Simulation.

## Fitur Utama

### Splash

Menampilkan branding SaveUp dan menjadi entry point aplikasi.

### Onboarding

Menjelaskan tiga konsep utama:

1. Simulate every goal before committing
2. Track multiple goals without clutter
3. Stay motivated with visible progress

### First Time Setup

User mengisi:

- display name
- monthly savings power

Data ini disimpan secara lokal dan bisa diedit lagi dari halaman Profile.

### Home Dashboard

Home adalah ringkasan utama kondisi tabungan user.

Home menampilkan:

- greeting berdasarkan nama user
- total saved
- planned this month
- shortcut Add / Simulate
- nearest deadline
- active goal preview
- recent activity
- momentum insight

Home harus menggunakan data real dari local database, bukan mock data.

### Goals List

Goals List menampilkan semua goal yang sudah disimpan.

Elemen penting:

- filter Active / Soonest
- goal card
- progress bar
- percentage
- saved amount of target amount
- target month/year
- create new goal button

Goal card harus menggunakan data real dari local database.

### Goal Detail

Goal Detail menampilkan detail satu goal berdasarkan `goalId`.

Informasi yang ditampilkan:

- goal title
- progress ring / progress indicator
- current savings
- target amount
- remaining amount
- target month
- projected completion
- suggested monthly saving for this goal
- update progress action
- timeline / recent goal activity

Goal Detail harus mengambil data real dari repository/provider berdasarkan `goalId`.

### Savings Simulation

Savings Simulation adalah halaman preview sebelum goal disimpan.

Simulation menampilkan:

- projected finish / target month
- realistic atau optimistic status
- suggested monthly saving
- recommendation wording
- final action: `Convert to goal`

Simulation bersifat temporary. Membuka halaman ini, menjalankan simulasi, atau kembali dari halaman ini tidak boleh menyimpan goal.

Goal hanya disimpan ketika user menekan `Convert to goal`.

### Update Progress

Update Progress digunakan untuk memperbarui progres tabungan pada goal yang sudah disimpan.

Flow:

```txt
Goal Detail
→ Tap Update progress
→ Add Progress Bottom Sheet
→ Pilih Add savings / Withdraw
→ Input amount
→ Input note
→ Save update
→ Create transaction
→ Update goal current savings
→ Close bottom sheet
→ Goal Detail timeline updates
```

Rules penting:

- Add savings menambah current savings.
- Withdraw mengurangi current savings.
- Withdraw tidak boleh membuat current savings menjadi negatif.
- Setiap update progress harus tercatat sebagai transaction/timeline entry jika tabel transaksi tersedia.
- Setelah update, Goal Detail, Goals List, Home, dan Activity harus menampilkan data terbaru.

### Activity

Activity menampilkan riwayat aktivitas terbaru dari seluruh goal.

Contoh aktivitas:

- deposit added
- withdrawal
- projection updated

Activity menggunakan data real dari transaction/progress records.

### Profile Settings

Profile menampilkan:

- profile card
- name
- monthly savings power
- privacy policy link
- profile setup note

User dapat mengedit nama dan monthly savings power melalui Edit Profile Bottom Sheet.

## Privacy Policy

SaveUp menggunakan privacy policy publik berikut:

```txt
https://saveup-privacy.netlify.app/
```

Link ini digunakan untuk:

- Google Play Console Privacy Policy
- Profile Settings → Privacy Policy

Privacy policy menjelaskan bahwa SaveUp adalah aplikasi offline-first, menyimpan data secara lokal, tidak membutuhkan login, tidak melakukan cloud sync, dan tidak menjual data user.

## Tech Stack

Bagian ini menjelaskan teknologi utama yang digunakan di SaveUp.

### Bahasa Pemrograman

```txt
Dart
```

SaveUp dibangun menggunakan Flutter, sehingga seluruh logic aplikasi, UI, state, dan integrasi local database ditulis dengan Dart.

### Framework Mobile

```txt
Flutter
```

Flutter digunakan untuk membangun UI mobile, routing antar halaman, bottom navigation, form, modal bottom sheet, dan screen utama aplikasi.

### State Management

```txt
Riverpod / Provider pattern sesuai implementasi project
```

State management digunakan untuk:

- membaca data profile
- membaca daftar goals
- membaca detail goal
- membaca activity
- menghubungkan screen ke repository
- melakukan refresh/invalidation setelah data berubah

### Database

```txt
Drift
SQLite
```

SaveUp menggunakan **Drift** sebagai local database layer di atas SQLite. Semua data utama aplikasi disimpan secara lokal di device, termasuk profile, goals, progress updates, transactions, dan activity records.

Drift digunakan untuk mendefinisikan table, menjalankan query lokal, dan menyediakan akses database yang type-safe untuk repository.

Alur akses data:

```txt
Screen
→ Provider
→ Repository
→ Drift database
→ SQLite local storage
```

Screen tidak boleh mengakses database secara langsung. Semua akses data harus melewati provider dan repository agar flow aplikasi tetap konsisten.

### Arsitektur

SaveUp menggunakan pemisahan sederhana:

```txt
Presentation Layer
→ Provider / State Layer
→ Repository Layer
→ Local Database Layer
```

Penjelasan singkat:

```txt
Presentation Layer
Screen, widget, form, bottom sheet.

Provider / State Layer
Mengatur state async, membaca repository, dan refresh data.

Repository Layer
Berisi fungsi untuk create/read/update data aplikasi.

Local Database Layer
Menyimpan data profile, goals, transactions, dan activity secara offline.
```

Alur umum:

```txt
User action
→ Screen / Widget
→ Provider
→ Repository
→ Local Database
→ Provider refresh
→ UI update
```

## Development Guide

Bagian ini menjelaskan arahan praktis untuk developer yang ingin mengubah atau menambah fitur di SaveUp.

### 1. Mengubah Frontend

Frontend berisi screen, widget, form, bottom sheet, dan komponen visual.

Lokasi umum:

```txt
lib/features/<feature_name>/presentation/
```

Contoh:

```txt
lib/features/home/presentation/
lib/features/goals/presentation/
lib/features/activity/presentation/
lib/features/profile/presentation/
```

Jika ingin mengubah tampilan:

- cari screen atau widget di folder `presentation`
- ikuti design dari UI/UX
- jangan ubah spacing, warna, typography, icon, atau layout besar tanpa alasan jelas
- gunakan komponen existing jika sudah ada
- hindari mengganti seluruh widget tree jika hanya perlu mengganti data
- pastikan tidak ada text overflow
- pastikan halaman aman di layar kecil

Code style frontend:

```txt
- nama file menggunakan snake_case
- nama class menggunakan PascalCase
- screen production-ready tidak menggunakan nama Placeholder
- widget kecil boleh dipisah jika membuat file utama lebih mudah dibaca
- jangan mencampur query database langsung di widget
- gunakan provider/repository untuk data
```

Contoh naming:

```txt
home_dashboard_screen.dart
goals_list_screen.dart
goal_detail_screen.dart
savings_simulation_screen.dart
profile_settings_screen.dart
```

### 2. Mengubah State / Provider

Provider menghubungkan UI dengan repository.

Lokasi umum:

```txt
lib/features/<feature_name>/application/
lib/features/<feature_name>/providers/
```

Gunakan lokasi yang sudah dipakai oleh feature tersebut. Jangan membuat struktur baru jika feature existing sudah punya pola sendiri.

Jika ingin menambah provider:

- cek provider existing terlebih dahulu
- gunakan pola Riverpod/provider yang sudah ada
- jangan duplikasi query repository jika provider lain sudah menyediakan data yang sama
- setelah write/update data, refresh atau invalidate provider yang terdampak

Contoh kasus refresh:

```txt
Update Progress berhasil
→ refresh goal detail
→ refresh goals list
→ refresh activity
→ refresh home dashboard jika memakai data yang sama
```

Code style provider:

```txt
- provider diberi nama sesuai data yang disediakan
- hindari nama temporary seperti placeholderProvider
- provider tidak berisi logic UI yang terlalu spesifik
- provider boleh melakukan mapping data ringan jika dibutuhkan screen
```

### 3. Mengubah Repository / Local Backend

Repository berisi operasi data seperti create goal, read goals, update progress, dan read activity.

Lokasi umum:

```txt
lib/features/<feature_name>/data/
lib/features/<feature_name>/domain/
```

Gunakan struktur yang sudah ada di project.

Jika ingin mengubah logic data:

- mulai dari repository
- cek schema di `docs/DATABASE_SCHEMA.md`
- jangan ubah schema jika tidak diperlukan
- jangan akses database langsung dari screen
- pastikan method repository punya tujuan yang jelas
- validasi data penting sebelum write

Contoh fungsi repository penting:

```txt
createGoal(...)
getGoals()
getGoalById(goalId)
updateGoalProgress(...)
createTransaction(...)
getRecentActivity()
getProfile()
updateProfile(...)
```

Code style repository:

```txt
- method name harus menjelaskan action
- gunakan parameter yang eksplisit
- hindari method terlalu umum seperti saveData(...)
- return type harus jelas
- tangani null/error sesuai pola project
```

### 4. Mengubah Database

Database menyimpan data lokal aplikasi.

Lokasi umum:

```txt
lib/core/database/
lib/features/<feature_name>/data/
```

Sebelum mengubah database:

- baca `docs/DATABASE_SCHEMA.md`
- pastikan perubahan memang perlu
- cek apakah table/field sebenarnya sudah ada
- hindari mengubah schema hanya untuk masalah UI
- update repository setelah schema berubah
- jalankan ulang generator jika project memakai generated database code

Untuk fase integrasi, biasanya yang perlu dilakukan bukan membuat table baru, tetapi:

```txt
Local database sudah ada
→ buat/use query
→ buat/use repository method
→ buat/use provider
→ connect ke UI
```

### 5. Mengubah Integrasi Screen

Integrasi berarti mengganti mock/static data menjadi data real dari repository/provider.

Langkah aman:

```txt
1. Cari mock/static data source.
2. Jangan hapus komponen UI.
3. Buat atau gunakan provider existing.
4. Hubungkan provider ke repository.
5. Map data real ke field UI existing.
6. Tambahkan loading/error/empty state jika diperlukan.
7. Jalankan flutter analyze.
8. Manual test flow terkait.
```

Rules penting:

```txt
- jangan redesign UI saat task hanya integrasi
- jangan delete frontend component
- jangan ubah route tanpa kebutuhan
- jangan ubah schema tanpa alasan kuat
- jangan gabungkan terlalu banyak scope dalam satu task
```

Contoh integrasi yang benar:

```txt
Goals List sebelumnya memakai _mockGoals.
Ganti sumber data menjadi goalsListProvider.
Card UI tetap sama.
Yang berubah hanya value yang dikirim ke card.
```

### 6. Mengubah Navigation

Route utama mengikuti flow aplikasi:

```txt
/home
/goals
/goals/create
/goals/simulation
/goals/:goalId
/activity
/profile
```

Jika mengubah navigation:

- jaga bottom navigation tetap berisi Home, Goals, Activity, Profile
- nested screen seperti Goal Detail, Create Goal, dan Simulation tidak memakai bottom nav
- native back pada main tab tidak boleh langsung close app
- back dari nested screen harus mengikuti route asal
- jangan hardcode back ke Goals jika user datang dari Home

Contoh expected behavior:

```txt
Home → Create Goal → Back = Home
Goals → Create Goal → Back = Goals
Create Goal → Simulation → Back = Create Goal
Goals → Goal Detail → Back = Goals
```

### 7. Validasi Setelah Perubahan

Setiap perubahan minimal harus menjalankan:

```txt
flutter analyze
```

Jika perubahan menyentuh flow utama, lakukan manual test sesuai area:

```txt
Create Goal → Simulation → Convert to goal
Goals List → Goal Detail
Goal Detail → Update Progress
Update Progress → Activity
Profile → Privacy Policy
Home Dashboard refresh
```

## Branching Convention

Gunakan format branch berdasarkan area dan jenis pekerjaan.

Contoh:

```txt
feat/frontend-simulation-result-card
feat/integration-goals-list-data
feat/integration-home-dashboard-data
fix/frontend-create-goal-back-stack
fix/integration-full-flow-qa
refactor/frontend-remove-placeholder-naming
```

Pattern umum:

```txt
feat/<area>-<task>
fix/<area>-<task>
refactor/<area>-<task>
```

Area yang umum:

```txt
frontend
integration
backend
```

Contoh branch:

```txt
feat/integration-update-progress
fix/frontend-main-tab-back-navigation
refactor/frontend-finalize-screen-naming
```

## Commit Message Convention

Gunakan conventional commit.

Format:

```txt
type(scope): summary
```

Contoh:

```txt
feat(frontend): implement updated simulation result card design
feat(integration): connect home dashboard to saved data
feat(integration): connect activity page to progress records
fix(frontend): restore real back navigation in create goal flow
fix(integration): harden saved goal flow edge cases
refactor(frontend): replace placeholder screen naming
```

Type yang umum:

```txt
feat
fix
refactor
docs
chore
test
```

Scope yang umum:

```txt
frontend
backend
integration
docs
```

## External URLs

Privacy Policy:

```txt
https://saveup-privacy.netlify.app/
```

Flutter Documentation:

```txt
https://docs.flutter.dev/
```

Dart Documentation:

```txt
https://dart.dev/guides
```

Riverpod Documentation:

```txt
https://riverpod.dev/
```

Google Play Privacy Policy Requirements:

```txt
https://support.google.com/googleplay/android-developer/answer/10144311
```

Google Play Data Safety:

```txt
https://support.google.com/googleplay/android-developer/answer/10787469
```

## Manual QA Checklist

Gunakan checklist ini sebelum milestone release.

### Onboarding dan Profile

```txt
- First launch membuka onboarding
- Setup profile menyimpan nama
- Setup profile menyimpan monthly savings power
- Setelah setup masuk ke Home
- Profile Settings menampilkan data real
- Edit Profile mengupdate data real
```

### Create Goal dan Simulation

```txt
- Create Goal tidak memiliki fake default values
- Required fields tervalidasi
- Tap Create goal menuju Simulation
- Simulation menerima data form yang benar
- Back dari Simulation mempertahankan draft form
- Simulation tidak menyimpan goal sebelum Convert to goal
- Convert to goal menyimpan goal tepat satu kali
```

### Goals List

```txt
- Empty state muncul saat belum ada goal
- Goal baru muncul setelah Convert to goal
- Card menampilkan current savings, target, progress, target month
- Active/Soonest berjalan jika tersedia
- Tap card membuka Goal Detail yang benar
```

### Goal Detail

```txt
- Load goal berdasarkan goalId
- Menampilkan suggested monthly saving for this goal
- Remaining amount tidak negatif
- Progress maksimal 100%
- Update Progress dapat dibuka
```

### Update Progress

```txt
- Add savings menambah current savings
- Withdraw mengurangi current savings
- Withdraw tidak bisa membuat current savings negatif
- Invalid amount ditolak
- Setelah update, Goal Detail refresh
- Setelah update, Goals List refresh
- Setelah update, Activity menampilkan record baru
```

### Home

```txt
- Greeting memakai nama profile
- Total saved berdasarkan goals real
- Planned this month aman dan tidak negatif
- Nearest deadline berdasarkan active goals
- Active goal preview membuka Goal Detail jika tappable
- Recent activity memakai data real
```

### Activity

```txt
- Empty state aman
- Progress update muncul sebagai activity
- Record terbaru muncul paling atas
- Amount dan date diformat dengan benar
```

### Navigation

```txt
- Home → Create Goal → Back kembali ke Home
- Goals → Create Goal → Back kembali ke Goals
- Create Goal → Simulation → Back kembali ke Create Goal
- Draft form tetap ada setelah back dari Simulation
- Goals → Goal Detail → Back kembali ke Goals
- Native back pada main tab tidak langsung close app
```

## Non-Goals Versi Awal

SaveUp tidak mencakup:

- login/register
- cloud sync
- backend API
- bank integration
- automatic transaction import
- investment calculation
- multi-device sync
- subscription/payment
- social sharing
- notifications

## Status Project

SaveUp berada pada fase integrasi dan polish menuju app yang siap diuji.

Core integration yang ditargetkan:

```txt
- Profile Settings integration
- Home Dashboard real data
- Goals List real data
- Goal Detail real data
- Create Goal → Simulation → Convert to goal
- Update Progress integration
- Activity real data
- Privacy Policy link
- Final naming convention cleanup
```

## Catatan untuk Developer Baru

Jika kamu baru masuk ke project ini, pahami tiga hal berikut terlebih dahulu:

1. SaveUp adalah aplikasi tabungan offline-first, bukan bank atau budgeting app.
2. Goal tidak langsung disimpan dari form. Goal harus disimulasikan terlebih dahulu.
3. Integrasi harus menjaga UI existing. Jangan menghapus komponen frontend hanya untuk mengganti data source.

Jika kamu bisa menjelaskan ulang bahwa SaveUp adalah app untuk mensimulasikan dan melacak goal tabungan pribadi secara offline, dengan flow `Create Goal → Simulation → Convert to goal → Track Progress`, maka kamu sudah memahami inti project ini.
