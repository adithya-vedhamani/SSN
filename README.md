# SSN College of Enginnering Admission Application

The SSN College of Engineering Student Admission App is a cross-platform application developed using Flutter and Android Studio. The app provides a comprehensive solution for managing student details and attendance records. It offers four distinct roles: General, Proctor, Interviewer, and Verifier, each with separate functionalities and privileges.

- - - - 
## Features
* General Role: The General role allows students to access their personal details and attendance records. Students can view their profile information, attendance statistics, and any updates regarding tests or interviews.

* Proctor Role: The Proctor role is specifically designed for faculty members or proctors who are responsible for monitoring and managing student attendance. Proctors can scan student QR codes to retrieve their details and mark attendance for tests and interviews.

* Interviewer Role: The Interviewer role is meant for interview panel members. They can scan student QR codes during interviews and record attendance, interview timings, and any relevant details for further evaluation.

* Verifier Role: The Verifier role enables administrative staff to verify and validate the attendance records. They have access to the attendance data and can cross-check and ensure its accuracy.

* QR Code Scanning: The app utilizes QR codes to quickly retrieve student details. By scanning the QR code assigned to each student, the app fetches their information from a central database, providing instant access to relevant data.

* Attendance Management: The app tracks attendance for various events, including tests and interviews. It allows the respective roles (Proctor and Interviewer) to mark attendance, record timings, and update the attendance records in real-time.

* Google Spreadsheet Integration: The app integrates with Google Spreadsheets to store and manage the attendance data. This ensures data integrity, accessibility, and easy collaboration among authorized personnel.

- - - - 
## Installation and Setup
Clone the repository to your local machine.
Install Flutter and Android Studio on your development environment.
Open the project in Android Studio.
Set up the necessary dependencies by running the command: flutter pub get.
Build and run the app on an emulator or physical device.
Configuration
Modify the API endpoints and database configurations in the app's source code according to your server setup.
Generate and assign unique QR codes to each student, ensuring they are linked to their respective details in the database.

- - - - 
## Dependencies
The app relies on the following dependencies:

* Flutter SDK
* Flutter packages: http, shared_preferences, qr_code_scanner, google_sheets_api, google_sign_in
* Ensure that these dependencies are properly installed and up to date.
- - - -
## Contribution
Contributions to the SSN College of Engineering Student Management App are welcome. If you have any bug fixes, improvements, or new features to add, please follow the standard Git workflow:

Fork the repository.
Create a new branch for your feature/fix: git checkout -b feature/your-feature.
Commit your changes: git commit -am 'Add your feature'.
Push to the branch: git push origin feature/your-feature.
Create a new Pull Request.
Please ensure your code follows the project's coding style and includes appropriate documentation.

- - - -
## License
The App is open source and available under the MIT License. Feel free to use, modify, and distribute the app in accordance with the terms of the license.
- - - - 
## Acknowledgement

If you encounter any issues or have suggestions for enhancement, please open an issue on the project's repository.

