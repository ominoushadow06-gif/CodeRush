-- ============================================================
-- CodeRush Database Schema
-- Run this in MySQL Workbench or MySQL CLI:
--   mysql -u root -p < sql/schema.sql
-- ============================================================

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

-- ============================================================
-- 2. Language-Specific Snippet Tables
-- ============================================================

-- 2a. Java Snippets
CREATE TABLE IF NOT EXISTS snippets_java (
    snippet_id INT AUTO_INCREMENT PRIMARY KEY,
    code_text TEXT NOT NULL,
    description VARCHAR(255) NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2b. Python Snippets
CREATE TABLE IF NOT EXISTS snippets_python (
    snippet_id INT AUTO_INCREMENT PRIMARY KEY,
    code_text TEXT NOT NULL,
    description VARCHAR(255) NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2c. C Snippets
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

-- ============================================================
-- Java Snippets (6 Easy, 6 Medium, 6 Hard)
-- ============================================================

-- Java Easy
INSERT INTO snippets_java (code_text, description, difficulty) VALUES
('System.out.println("Hello, CodeRush!");',
 'Prints a welcome message to the console using println.\nA basic introduction to standard output in Java.',
 'easy'),

('int sum = 0;\nfor (int i = 1; i <= 10; i++) {\n    sum += i;\n}',
 'Calculates the sum of numbers from 1 to 10 using a for loop.\nDemonstrates loop iteration and variable accumulation.',
 'easy'),

('String greeting = "Welcome to CodeRush!";\nint length = greeting.length();',
 'Stores a string and finds its length using the length() method.\nShows basic String declaration and built-in method usage.',
 'easy'),

('int[] nums = {1, 2, 3, 4, 5};\nint total = 0;\nfor (int n : nums) {\n    total += n;\n}',
 'Sums all elements of an integer array using a for-each loop.\nDemonstrates array initialization and enhanced for loop syntax.',
 'easy'),

('boolean isEven = (10 % 2 == 0);\nSystem.out.println(isEven);',
 'Checks whether a number is even using the modulo operator.\nStores the result in a boolean and prints it to the console.',
 'easy'),

('char grade = \'A\';\nif (grade == \'A\') {\n    System.out.println("Excellent!");\n}',
 'Compares a char variable against a value using an if statement.\nPrints a message when the grade matches the expected character.',
 'easy');

-- Java Medium
INSERT INTO snippets_java (code_text, description, difficulty) VALUES
('public static int findMax(int[] arr) {\n    int max = arr[0];\n    for (int num : arr) {\n        if (num > max) max = num;\n    }\n    return max;\n}',
 'Finds the maximum element in an integer array by linear scan.\nIterates through each element and tracks the largest value found.',
 'medium'),

('List<String> list = new ArrayList<>();\nlist.add("Java");\nlist.add("Servlet");\nCollections.sort(list);',
 'Creates an ArrayList of strings, adds elements, and sorts them.\nDemonstrates Java Collections framework with ArrayList and sort.',
 'medium'),

('public static boolean isPalindrome(String s) {\n    int left = 0, right = s.length() - 1;\n    while (left < right) {\n        if (s.charAt(left) != s.charAt(right)) return false;\n        left++;\n        right--;\n    }\n    return true;\n}',
 'Checks if a string reads the same forwards and backwards.\nUses two-pointer technique comparing characters from both ends.',
 'medium'),

('Map<String, Integer> map = new HashMap<>();\nmap.put("Alice", 90);\nmap.put("Bob", 85);\nfor (Map.Entry<String, Integer> e : map.entrySet()) {\n    System.out.println(e.getKey() + ": " + e.getValue());\n}',
 'Stores name-score pairs in a HashMap and prints each entry.\nDemonstrates Map creation, insertion, and iteration using entrySet.',
 'medium'),

('public static int factorial(int n) {\n    if (n <= 1) return 1;\n    return n * factorial(n - 1);\n}',
 'Computes the factorial of a number using recursion.\nBase case returns 1; each call multiplies n by factorial(n-1).',
 'medium'),

('String[] words = {"code", "rush", "java"};\nStringBuilder sb = new StringBuilder();\nfor (String w : words) {\n    sb.append(w).append(" ");\n}\nSystem.out.println(sb.toString().trim());',
 'Joins an array of words into a single space-separated string.\nUses StringBuilder for efficient string concatenation in a loop.',
 'medium');

-- Java Hard
INSERT INTO snippets_java (code_text, description, difficulty) VALUES
('public class BinarySearch {\n    public static int search(int[] arr, int target) {\n        int left = 0, right = arr.length - 1;\n        while (left <= right) {\n            int mid = left + (right - left) / 2;\n            if (arr[mid] == target) return mid;\n            if (arr[mid] < target) left = mid + 1;\n            else right = mid - 1;\n        }\n        return -1;\n    }\n}',
 'Searches for a target in a sorted array using binary search.\nRepeatedly halves the search space for O(log n) time complexity.',
 'hard'),

('public static void bubbleSort(int[] arr) {\n    int n = arr.length;\n    for (int i = 0; i < n - 1; i++) {\n        for (int j = 0; j < n - i - 1; j++) {\n            if (arr[j] > arr[j + 1]) {\n                int temp = arr[j];\n                arr[j] = arr[j + 1];\n                arr[j + 1] = temp;\n            }\n        }\n    }\n}',
 'Sorts an array by repeatedly swapping adjacent out-of-order elements.\nNested loops push the largest unsorted element to the end each pass.',
 'hard'),

('public class LinkedList {\n    Node head;\n    static class Node {\n        int data;\n        Node next;\n        Node(int d) { data = d; next = null; }\n    }\n    public void insertAtEnd(int data) {\n        Node newNode = new Node(data);\n        if (head == null) { head = newNode; return; }\n        Node current = head;\n        while (current.next != null) current = current.next;\n        current.next = newNode;\n    }\n}',
 'Implements a singly linked list with insert-at-end operation.\nTraverses to the last node and attaches the new node at the tail.',
 'hard'),

('public static String reverseWords(String sentence) {\n    String[] words = sentence.split(" ");\n    StringBuilder result = new StringBuilder();\n    for (int i = words.length - 1; i >= 0; i--) {\n        result.append(words[i]);\n        if (i != 0) result.append(" ");\n    }\n    return result.toString();\n}',
 'Reverses the order of words in a sentence string.\nSplits by spaces, iterates backwards, and rebuilds with StringBuilder.',
 'hard'),

('public class Stack {\n    private int[] arr;\n    private int top;\n    public Stack(int size) { arr = new int[size]; top = -1; }\n    public void push(int val) { arr[++top] = val; }\n    public int pop() { return arr[top--]; }\n    public int peek() { return arr[top]; }\n    public boolean isEmpty() { return top == -1; }\n}',
 'Implements a stack data structure using an array with push/pop.\nTracks the top index for O(1) push, pop, and peek operations.',
 'hard'),

('public static int[][] multiplyMatrices(int[][] a, int[][] b) {\n    int rows = a.length, cols = b[0].length, k = a[0].length;\n    int[][] result = new int[rows][cols];\n    for (int i = 0; i < rows; i++) {\n        for (int j = 0; j < cols; j++) {\n            for (int x = 0; x < k; x++) {\n                result[i][j] += a[i][x] * b[x][j];\n            }\n        }\n    }\n    return result;\n}',
 'Multiplies two matrices using three nested loops.\nComputes each cell as the dot product of a row from A and column from B.',
 'hard');

-- ============================================================
-- Python Snippets (6 Easy, 6 Medium, 6 Hard)
-- ============================================================

-- Python Easy
INSERT INTO snippets_python (code_text, description, difficulty) VALUES
('print("Hello, CodeRush!")',
 'Prints a welcome message to the console using print().\nThe simplest way to display output in Python.',
 'easy'),

('total = 0\nfor i in range(1, 11):\n    total += i\nprint(total)',
 'Sums numbers from 1 to 10 using a for loop with range().\nAccumulates the total and prints the final result.',
 'easy'),

('name = "CodeRush"\nlength = len(name)\nprint(f"Length: {length}")',
 'Finds the length of a string using the len() function.\nDisplays the result using an f-string for formatted output.',
 'easy'),

('nums = [1, 2, 3, 4, 5]\nresult = sum(nums)\nprint(result)',
 'Calculates the sum of a list using the built-in sum() function.\nDemonstrates list creation and Pythons concise built-in utilities.',
 'easy'),

('is_even = (10 % 2 == 0)\nprint(is_even)',
 'Checks if a number is even using the modulo operator.\nStores the boolean result and prints True or False.',
 'easy'),

('grade = "A"\nif grade == "A":\n    print("Excellent!")',
 'Compares a string variable and prints a message if it matches.\nShows basic if-statement syntax with string comparison in Python.',
 'easy');

-- Python Medium
INSERT INTO snippets_python (code_text, description, difficulty) VALUES
('def find_max(arr):\n    max_val = arr[0]\n    for num in arr:\n        if num > max_val:\n            max_val = num\n    return max_val',
 'Finds the largest element in a list by iterating through it.\nTracks the maximum value seen so far and returns it.',
 'medium'),

('def is_palindrome(s):\n    return s == s[::-1]',
 'Checks if a string is a palindrome using slice reversal.\nCompares the string with its reverse in a single expression.',
 'medium'),

('scores = {"Alice": 90, "Bob": 85}\nfor name, score in scores.items():\n    print(f"{name}: {score}")',
 'Iterates over a dictionary and prints each key-value pair.\nUses items() to unpack names and scores with f-string formatting.',
 'medium'),

('def factorial(n):\n    if n <= 1:\n        return 1\n    return n * factorial(n - 1)',
 'Computes factorial recursively by multiplying n with factorial(n-1).\nBase case returns 1 when n reaches 1 or below.',
 'medium'),

('words = ["code", "rush", "python"]\nresult = " ".join(words)\nprint(result)',
 'Joins a list of words into a single space-separated string.\nUses the join() method for clean and efficient concatenation.',
 'medium'),

('def fibonacci(n):\n    a, b = 0, 1\n    seq = []\n    for _ in range(n):\n        seq.append(a)\n        a, b = b, a + b\n    return seq',
 'Generates the first n Fibonacci numbers iteratively.\nUses tuple unpacking to swap values and builds the sequence in a list.',
 'medium');

-- Python Hard
INSERT INTO snippets_python (code_text, description, difficulty) VALUES
('def binary_search(arr, target):\n    left, right = 0, len(arr) - 1\n    while left <= right:\n        mid = (left + right) // 2\n        if arr[mid] == target:\n            return mid\n        elif arr[mid] < target:\n            left = mid + 1\n        else:\n            right = mid - 1\n    return -1',
 'Searches for a target in a sorted list using binary search.\nHalves the search range each iteration for logarithmic performance.',
 'hard'),

('def bubble_sort(arr):\n    n = len(arr)\n    for i in range(n - 1):\n        for j in range(n - i - 1):\n            if arr[j] > arr[j + 1]:\n                arr[j], arr[j + 1] = arr[j + 1], arr[j]\n    return arr',
 'Sorts a list by comparing and swapping adjacent elements.\nUses Pythons tuple swap for clean in-place element exchange.',
 'hard'),

('class Node:\n    def __init__(self, data):\n        self.data = data\n        self.next = None\n\nclass LinkedList:\n    def __init__(self):\n        self.head = None\n    def insert(self, data):\n        new_node = Node(data)\n        new_node.next = self.head\n        self.head = new_node',
 'Implements a singly linked list with insert-at-head operation.\nEach Node holds data and a reference to the next node in the chain.',
 'hard'),

('def reverse_words(sentence):\n    words = sentence.split()\n    return " ".join(reversed(words))',
 'Reverses the order of words in a sentence string.\nSplits into a list, reverses it, and joins back with spaces.',
 'hard'),

('class Stack:\n    def __init__(self):\n        self.items = []\n    def push(self, val):\n        self.items.append(val)\n    def pop(self):\n        return self.items.pop()\n    def peek(self):\n        return self.items[-1]\n    def is_empty(self):\n        return len(self.items) == 0',
 'Implements a stack using a Python list with push/pop/peek.\nUses append and pop for O(1) operations on the top of the stack.',
 'hard'),

('def matrix_multiply(a, b):\n    rows_a, cols_b = len(a), len(b[0])\n    k = len(a[0])\n    result = [[0] * cols_b for _ in range(rows_a)]\n    for i in range(rows_a):\n        for j in range(cols_b):\n            for x in range(k):\n                result[i][j] += a[i][x] * b[x][j]\n    return result',
 'Multiplies two matrices using three nested loops.\nBuilds a result matrix with each cell as a dot product of row and column.',
 'hard');

-- ============================================================
-- C Snippets (6 Easy, 6 Medium, 6 Hard)
-- ============================================================

-- C Easy
INSERT INTO snippets_C (code_text, description, difficulty) VALUES
('printf("Hello, CodeRush!\\n");',
 'Prints a welcome message to the console using printf.\nUses the newline escape character for formatted terminal output.',
 'easy'),

('int sum = 0;\nfor (int i = 1; i <= 10; i++) {\n    sum += i;\n}\nprintf("%d\\n", sum);',
 'Calculates the sum of numbers from 1 to 10 using a for loop.\nPrints the result using printf with the %d format specifier.',
 'easy'),

('char greeting[] = "CodeRush";\nint len = strlen(greeting);\nprintf("Length: %d\\n", len);',
 'Finds the length of a character array using strlen().\nDemonstrates C-style strings and the string.h library function.',
 'easy'),

('int nums[] = {1, 2, 3, 4, 5};\nint total = 0;\nfor (int i = 0; i < 5; i++) {\n    total += nums[i];\n}',
 'Sums all elements of an integer array using index-based loop.\nAccesses each element with array subscript notation.',
 'easy'),

('int x = 10;\nif (x % 2 == 0) {\n    printf("Even\\n");\n} else {\n    printf("Odd\\n");\n}',
 'Checks if a number is even or odd using the modulo operator.\nPrints the appropriate label based on the remainder.',
 'easy'),

('char grade = \'A\';\nif (grade == \'A\') {\n    printf("Excellent!\\n");\n}',
 'Compares a char variable and prints a message if it matches.\nDemonstrates character literal comparison with an if statement.',
 'easy');

-- C Medium
INSERT INTO snippets_C (code_text, description, difficulty) VALUES
('int findMax(int arr[], int n) {\n    int max = arr[0];\n    for (int i = 1; i < n; i++) {\n        if (arr[i] > max) max = arr[i];\n    }\n    return max;\n}',
 'Finds the maximum element in an array by linear scan.\nTakes the array and its size as parameters and returns the largest value.',
 'medium'),

('int isPalindrome(char str[]) {\n    int left = 0, right = strlen(str) - 1;\n    while (left < right) {\n        if (str[left] != str[right]) return 0;\n        left++;\n        right--;\n    }\n    return 1;\n}',
 'Checks if a C string is a palindrome using two pointers.\nReturns 1 for palindrome and 0 otherwise by comparing from both ends.',
 'medium'),

('int factorial(int n) {\n    if (n <= 1) return 1;\n    return n * factorial(n - 1);\n}',
 'Computes factorial of a number using recursive multiplication.\nBase case returns 1; recursive case multiplies n by factorial(n-1).',
 'medium'),

('void swap(int *a, int *b) {\n    int temp = *a;\n    *a = *b;\n    *b = temp;\n}',
 'Swaps two integer values using pointers and a temp variable.\nDemonstrates pass-by-reference in C through pointer dereferencing.',
 'medium'),

('void reverseArray(int arr[], int n) {\n    for (int i = 0; i < n / 2; i++) {\n        int temp = arr[i];\n        arr[i] = arr[n - 1 - i];\n        arr[n - 1 - i] = temp;\n    }\n}',
 'Reverses an array in place by swapping elements from both ends.\nIterates to the midpoint exchanging symmetric positions.',
 'medium'),

('int fibonacci(int n) {\n    if (n <= 0) return 0;\n    if (n == 1) return 1;\n    int a = 0, b = 1, c;\n    for (int i = 2; i <= n; i++) {\n        c = a + b;\n        a = b;\n        b = c;\n    }\n    return b;\n}',
 'Computes the nth Fibonacci number iteratively.\nUses three variables to track the sequence without recursion overhead.',
 'medium');

-- C Hard
INSERT INTO snippets_C (code_text, description, difficulty) VALUES
('int binarySearch(int arr[], int n, int target) {\n    int left = 0, right = n - 1;\n    while (left <= right) {\n        int mid = left + (right - left) / 2;\n        if (arr[mid] == target) return mid;\n        if (arr[mid] < target) left = mid + 1;\n        else right = mid - 1;\n    }\n    return -1;\n}',
 'Searches a sorted array for a target using binary search.\nHalves the search range each step for O(log n) time complexity.',
 'hard'),

('void bubbleSort(int arr[], int n) {\n    for (int i = 0; i < n - 1; i++) {\n        for (int j = 0; j < n - i - 1; j++) {\n            if (arr[j] > arr[j + 1]) {\n                int temp = arr[j];\n                arr[j] = arr[j + 1];\n                arr[j + 1] = temp;\n            }\n        }\n    }\n}',
 'Sorts an array using bubble sort with nested loops.\nRepeatedly swaps adjacent elements to bubble the largest to the end.',
 'hard'),

('struct Node {\n    int data;\n    struct Node* next;\n};\nvoid insertAtEnd(struct Node** head, int data) {\n    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));\n    newNode->data = data;\n    newNode->next = NULL;\n    if (*head == NULL) { *head = newNode; return; }\n    struct Node* temp = *head;\n    while (temp->next != NULL) temp = temp->next;\n    temp->next = newNode;\n}',
 'Implements a linked list node struct with insert-at-end function.\nUses malloc for dynamic allocation and pointer-to-pointer for head.',
 'hard'),

('void reverseString(char str[]) {\n    int n = strlen(str);\n    for (int i = 0; i < n / 2; i++) {\n        char temp = str[i];\n        str[i] = str[n - 1 - i];\n        str[n - 1 - i] = temp;\n    }\n}',
 'Reverses a C string in place by swapping characters from both ends.\nIterates to the midpoint exchanging symmetric character positions.',
 'hard'),

('typedef struct {\n    int items[100];\n    int top;\n} Stack;\nvoid init(Stack *s) { s->top = -1; }\nvoid push(Stack *s, int val) { s->items[++s->top] = val; }\nint pop(Stack *s) { return s->items[s->top--]; }\nint peek(Stack *s) { return s->items[s->top]; }\nint isEmpty(Stack *s) { return s->top == -1; }',
 'Implements a stack using a struct with array-based storage.\nProvides init, push, pop, peek and isEmpty via pointer operations.',
 'hard'),

('void matrixMultiply(int a[][3], int b[][3], int result[][3], int n) {\n    for (int i = 0; i < n; i++) {\n        for (int j = 0; j < n; j++) {\n            result[i][j] = 0;\n            for (int k = 0; k < n; k++) {\n                result[i][j] += a[i][k] * b[k][j];\n            }\n        }\n    }\n}',
 'Multiplies two 2D matrices using three nested loops.\nEach result cell is the dot product of a row from A and column from B.',
 'hard');
