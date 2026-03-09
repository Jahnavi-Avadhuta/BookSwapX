# BookSwapX 📚

A full-stack Java web application for college students to buy, sell, and exchange textbooks.

## Features
- User registration and login with password hashing
- Post SELL and BUY listings for books
- Smart auto-matching engine using MySQL trigger
- Zero-cost book exchange system
- Internal messaging between users
- Trust score and review system
- Admin control panel (block users, manage listings, categories)
- Reports and notifications

## Tech Stack
- **Backend:** Java EE (Jakarta Servlets, JSP)
- **Database:** MySQL with stored trigger
- **Frontend:** Bootstrap 5, HTML, CSS
- **Server:** Apache Tomcat 10.1
- **IDE:** Eclipse

## How to Run
1. Import project into Eclipse as Dynamic Web Project
2. Configure MySQL — run the schema SQL in `/database/schema.sql`
3. Update DB credentials in `DBConnection.java`
4. Add `mysql-connector-j-9.5.0.jar` to `WEB-INF/lib/`
5. Deploy on Tomcat 10.1
