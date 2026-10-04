# ⌨️ CodeRush

> A real-time code typing practice platform where users type code snippets against a stopwatch, measuring speed (WPM), accuracy, and mistakes — built with Java Servlets, JDBC, MySQL, and deployed on Apache Tomcat.

## 👥 Team

| Name | Role |
|------|------|
| **Aryan** | Full-stack Development |
| **Vedant** | Full-stack Development |
| **Moksh** | Full-stack Development |

---

## 📌 Problem Statement

Most developers want to improve their coding speed and accuracy but lack a focused tool that simulates real code typing (not just English text). CodeRush provides timed code-typing challenges across multiple difficulty levels, tracks mistakes in real-time, and visualizes performance history — helping users build muscle memory for actual programming syntax.

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────┐
│            Browser (Client)         │
│   HTML / CSS / Vanilla JS / JSP     │
├─────────────────────────────────────┤
│          Apache Tomcat 9/10         │
│     ┌───────────────────────┐       │
│     │    Java Servlets      │       │
│     │  (Controller Layer)   │       │
│     └──────────┬────────────┘       │
│                │                    │
│     ┌──────────▼────────────┐       │
│     │   JDBC (Data Layer)   │       │
│     └──────────┬────────────┘       │
│                │                    │
├────────────────▼────────────────────┤
│           MySQL Database            │
└─────────────────────────────────────┘
```

---

## 🧩 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | HTML5, CSS3, Vanilla JavaScript, JSP |
| **Backend** | Java Servlets (Jakarta EE / Javax) |
| **Database** | MySQL 8.x |
| **DB Connectivity** | JDBC (MySQL Connector/J) |
| **Server** | Apache Tomcat 9 / 10 |
| **Build** | Manual WAR deployment (or Maven — optional) |

---

## 📄 Pages & Features

### Frontend Pages

| # | Page | Description |
|---|------|-------------|
| 1 | **Signup** | New user registration with username, email, password |
| 2 | **Login** | Existing user authentication |
| 3 | **Home / Dashboard** | Welcome screen, quick stats summary, start practice button |
| 4 | **Difficulty Selection** | Choose Easy / Medium / Hard before starting a session |
| 5 | **Coding Practice** | Core typing area — code snippet displayed, user types against a stopwatch, real-time mistake highlighting |
| 6 | **Results** | Post-session summary — WPM, accuracy %, mistakes, time taken |
| 7 | **Performance / History** | Past attempts table + charts showing improvement over time |

### Backend Servlets

| Servlet | Endpoint | Purpose |
|---------|----------|---------|
| `SignupServlet` | `POST /signup` | Validate & insert new user into DB |
| `LoginServlet` | `POST /login` | Authenticate user, create HTTP session |
| `LogoutServlet` | `GET /logout` | Invalidate session, redirect to login |
| `DashboardServlet` | `GET /dashboard` | Fetch user stats, forward to dashboard JSP |
| `SnippetServlet` | `GET /snippet?difficulty=X` | Return a random code snippet by difficulty |
| `ResultServlet` | `POST /result` | Save session result (WPM, accuracy, mistakes, time) |
| `HistoryServlet` | `GET /history` | Fetch all past attempts for logged-in user |

---

## 🔐 Authentication Flow

```
Signup → Hash password → Store in DB
                              ↓
Login → Check credentials → Create HttpSession → Set session attribute ("user")
                              ↓
Every protected page → Check session → Redirect to login if null
                              ↓
Logout → session.invalidate() → Redirect to login
```

- **Session-based auth** using `HttpServletRequest.getSession()`
- Passwords hashed before storing (use `BCrypt` or `SHA-256 + salt`)
- Session timeout configured in `web.xml`

---

## 🎮 Difficulty System

| Level | Snippet Length | Time Limit | Code Complexity |
|-------|---------------|------------|-----------------|
| **Easy** | Short (3-5 lines) | Generous (90s+) | Simple syntax — variables, prints, loops |
| **Medium** | Medium (5-10 lines) | Moderate (60s) | Functions, conditionals, arrays |
| **Hard** | Long (10-20 lines) | Tight (30-45s) | Classes, nested logic, advanced constructs |

---

## 📊 Scoring & Results

Each session records:

| Metric | How It's Calculated |
|--------|-------------------|
| **WPM** | (Total characters typed / 5) / time in minutes |
| **Accuracy %** | ((Total chars - mistakes) / total chars) × 100 |
| **Mistakes** | Count of incorrect keystrokes |
| **Time Taken** | Stopwatch duration in seconds |
| **Difficulty** | Easy / Medium / Hard tag |

Results page shows all metrics **separately categorized** by difficulty level.

---

## 🗄️ Database Schema

```sql
CREATE DATABASE IF NOT EXISTS coderush_db;
USE coderush_db;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Language-Specific Snippet Tables
CREATE TABLE IF NOT EXISTS snippets_java (
    snippet_id INT AUTO_INCREMENT PRIMARY KEY,
    code_text TEXT NOT NULL,
    description VARCHAR(255) NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS snippets_python (
    snippet_id INT AUTO_INCREMENT PRIMARY KEY,
    code_text TEXT NOT NULL,
    description VARCHAR(255) NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS snippets_C (
    snippet_id INT AUTO_INCREMENT PRIMARY KEY,
    code_text TEXT NOT NULL,
    description VARCHAR(255) NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Practice Results Table
CREATE TABLE IF NOT EXISTS results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    snippet_id INT NOT NULL,
    language ENUM('java', 'python', 'c') NOT NULL,
    wpm DECIMAL(5,2) NOT NULL,
    accuracy DECIMAL(5,2) NOT NULL,
    mistakes INT NOT NULL DEFAULT 0,
    time_taken INT NOT NULL,  -- in seconds
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
```

---

## 📁 Project Structure

```
CodeRush/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/coderush/
│       │       ├── servlet/
│       │       │   ├── SignupServlet.java
│       │       │   ├── LoginServlet.java
│       │       │   ├── LogoutServlet.java
│       │       │   ├── DashboardServlet.java
│       │       │   ├── SnippetServlet.java
│       │       │   ├── ResultServlet.java
│       │       │   └── HistoryServlet.java
│       │       ├── model/
│       │       │   ├── User.java
│       │       │   ├── Snippet.java
│       │       │   └── Result.java
│       │       └── dao/
│       │           ├── DBConnection.java
│       │           ├── UserDAO.java
│       │           ├── SnippetDAO.java
│       │           └── ResultDAO.java
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── css/
│           │   └── style.css
│           ├── js/
│           │   ├── typing.js        # Core typing logic + stopwatch
│           │   ├── auth.js          # Form validation
│           │   └── charts.js        # Performance charts
│           ├── signup.jsp
│           ├── login.jsp
│           ├── dashboard.jsp
│           ├── difficulty.jsp
│           ├── practice.jsp
│           ├── result.jsp
│           └── history.jsp
├── sql/
│   └── schema.sql
├── README.md
└── .gitignore
```

---

## ⚙️ Setup & Run

### Prerequisites
- Java JDK 8+
- Apache Tomcat 9 or 10
- MySQL 8.x
- MySQL Connector/J (JDBC driver JAR)

### Steps

1. **Clone the repo**
   ```bash
   git clone https://github.com/ominoushadow06-gif/CodeRush.git
   ```

2. **Create database**
   ```bash
   mysql -u root -p < sql/schema.sql
   ```

3. **Configure DB connection**
   Update `DBConnection.java` with your MySQL credentials:
   ```java
   String url = "jdbc:mysql://localhost:3306/coderush_db";
   String user = "root";
   String password = "your_password";
   ```

4. **Add JDBC driver**
   Place `mysql-connector-j-8.x.x.jar` in `WEB-INF/lib/`

5. **Deploy to Tomcat**
   Copy project to `tomcat/webapps/` or deploy WAR file

6. **Start Tomcat & open**
   ```
   http://localhost:8080/CodeRush/
   ```

---

## 🗺️ Development Roadmap

- [x] Project planning & README
- [ ] Database schema creation
- [ ] Signup & Login (Servlets + JSP + Session)
- [ ] Dashboard page
- [ ] Difficulty selection page
- [ ] Code snippet loading from DB
- [ ] Core typing engine (JS stopwatch + keystroke tracking)
- [ ] Results calculation & storage
- [ ] History page with data table
- [ ] Performance charts (improvement over time)
- [ ] UI polish & responsiveness
- [ ] Testing & bug fixes
- [ ] Final deployment

---

## 📜 License

This project is built for educational purposes as a college mini project.

---

<p align="center">Built with ☕ Java, 🐬 MySQL, and 🐱 Tomcat</p>
