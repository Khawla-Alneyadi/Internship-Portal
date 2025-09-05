# Internship Portal

A full-stack portal for students to **discover internships**, **apply**, and **share reviews**, with **admin tools** for managing postings.

## 🔹 Features
- Student signup/login and profile
- Browse/search internships, view details
- Apply and track application status
- Company reviews and ratings
- Admin: post approval, manage companies & listings

## 🔹 Tech Stack
- **Backend:** Java (Servlets/JSP or Spring—adjust here if you used Spring)
- **Database:** MySQL (or your DB—update name below)
- **Frontend:** HTML/CSS/JS (+ Bootstrap if used)
- **Tools/IDE:** NetBeans / VS Code 

## 🔹 Project Structure

Internship-Portal/
├─ src/
│ └─ java/
│ ├─ Model/ # Database connection + logic
│ │ └─ DBConnection.java
│ └─ Servlet/ # Java Servlets (controllers)
│ ├─ AdminLoginServlet.java
│ └─ RegisterServlet.java
├─ web/
│ └─ WEB-INF/ # JSP pages
│ ├─ index.jsp
│ ├─ register.jsp
│ ├─ company.jsp
│ └─ ... more JSPs
├─ schema/ # Database scripts
│ ├─ 00_create_tables.sql # Creates schema
│ └─ 01_sample_data.sql # Inserts demo data
├─ nbproject/ # NetBeans project settings
├─ build.xml # Build script
├─ README.md
└─ LICENSE

