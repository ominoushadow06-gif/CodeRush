-- ============================================================
-- CodeRush Database Schema
-- Run this in MySQL Workbench or MySQL CLI:
--   mysql -u root -p < sql/schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS coderush;
USE coderush;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Code Snippets Table
CREATE TABLE IF NOT EXISTS snippets (
    snippet_id INT AUTO_INCREMENT PRIMARY KEY,
    code_text TEXT NOT NULL,
    language VARCHAR(30) NOT NULL DEFAULT 'java',
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Practice Results Table
CREATE TABLE IF NOT EXISTS results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    snippet_id INT NOT NULL,
    wpm DECIMAL(5,2) NOT NULL,
    accuracy DECIMAL(5,2) NOT NULL,
    mistakes INT NOT NULL DEFAULT 0,
    time_taken INT NOT NULL,  -- in seconds
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (snippet_id) REFERENCES snippets(snippet_id) ON DELETE CASCADE
);

-- ============================================================
-- Sample Starter Snippets for Testing
-- ============================================================

-- Easy Snippets
INSERT INTO snippets (code_text, language, difficulty) VALUES
('System.out.println("Hello, CodeRush!");', 'java', 'easy'),
('int sum = 0;\nfor (int i = 1; i <= 10; i++) {\n    sum += i;\n}', 'java', 'easy'),
('String greeting = "Welcome to CodeRush!";\nint length = greeting.length();', 'java', 'easy');

-- Medium Snippets
INSERT INTO snippets (code_text, language, difficulty) VALUES
('public static int findMax(int[] arr) {\n    int max = arr[0];\n    for (int num : arr) {\n        if (num > max) max = num;\n    }\n    return max;\n}', 'java', 'medium'),
('List<String> list = new ArrayList<>();\nlist.add("Java");\nlist.add("Servlet");\nCollections.sort(list);', 'java', 'medium');

-- Hard Snippets
INSERT INTO snippets (code_text, language, difficulty) VALUES
('public class BinarySearch {\n    public static int search(int[] arr, int target) {\n        int left = 0, right = arr.length - 1;\n        while (left <= right) {\n            int mid = left + (right - left) / 2;\n            if (arr[mid] == target) return mid;\n            if (arr[mid] < target) left = mid + 1;\n            else right = mid - 1;\n        }\n        return -1;\n    }\n}', 'java', 'hard');
