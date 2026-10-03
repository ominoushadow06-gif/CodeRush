# 🚀 Team Git & GitHub Guide (Collision-Free Workflow)

> **For CodeRush Team (Aryan, Vedant, Moksh)**  
> Follow this exact step-by-step workflow so nobody overwrites each other's code and you get **zero merge conflicts**.

---

## 🛡️ The 3 Golden Rules (To Avoid Collisions)

1. **NEVER code or commit directly on `main`**. The `main` branch is only for finished, tested code.
2. **Always start a new feature on a fresh branch** created from the latest `main`.
3. **Always pull latest `main` before pushing your branch** to catch any changes your teammates merged.

---

## 🗺️ Team Branch Plan for CodeRush

Assign one branch per feature/module so nobody edits the same file at the same time:

| Team Member | Feature Branch Name | What you work on |
|---|---|---|
| **Aryan** | `feature/auth-system` | `SignupServlet`, `LoginServlet`, `UserDAO`, `login.jsp`, `signup.jsp` |
| **Vedant** | `feature/typing-engine` | `SnippetServlet`, `typing.js`, `practice.jsp`, `difficulty.jsp` |
| **Moksh** | `feature/history-results` | `ResultServlet`, `HistoryServlet`, `charts.js`, `result.jsp`, `history.jsp` |

---

## 🔄 Daily 6-Step Workflow (Copy-Paste Commands)

### 🔹 Step 1: Update your local `main` branch
Before writing any code, always make sure you have the latest updates from your teammates:
```bash
# 1. Switch to main
git checkout main

# 2. Download the latest code from GitHub
git pull origin main
```

---

### 🔹 Step 2: Create a new Feature Branch
Create and switch to your feature branch:
```bash
# Syntax: git checkout -b feature/<feature-name>
git checkout -b feature/auth-system
```
*(Now any changes you make will stay isolated in this branch without affecting anyone else)*

---

### 🔹 Step 3: Write code, check status & commit
Work on your files. When you are ready to save a milestone:
```bash
# 1. Check which files were modified
git status

# 2. Stage all changed files
git add .

# 3. Commit with a clear message describing what you did
git commit -m "feat: add user login validation and session handling"
```

---

### 🔹 Step 4: Sync with `main` before pushing (Anti-Collision Step)
Before pushing to GitHub, check if your teammates merged anything while you were coding:
```bash
# 1. Fetch any updates from GitHub
git fetch origin

# 2. Merge latest main into your feature branch
git merge origin/main
```
- If there are **no conflicts**: Git merges automatically!
- If there **are conflicts**: VS Code will highlight them (see "How to Resolve Conflicts" below).

---

### 🔹 Step 5: Push your branch to GitHub
Push your feature branch to GitHub:
```bash
# The first time you push this branch:
git push -u origin feature/auth-system

# Subsequent pushes on the same branch:
git push
```

---

### 🔹 Step 6: Create a Pull Request (PR) & Merge on GitHub
1. Go to GitHub: [https://github.com/ominoushadow06-gif/CodeRush](https://github.com/ominoushadow06-gif/CodeRush)
2. You will see a yellow banner: **"feature/auth-system had recent pushes — Compare & pull request"**. Click it!
3. Add a short title and description of what you built.
4. Click **Create pull request**.
5. Once your teammates review it (or test it), click **Merge pull request** → **Confirm merge**.
6. Switch back to `main` locally and pull:
   ```bash
   git checkout main
   git pull origin main
   ```

---

## ⚡ How to Resolve Merge Conflicts (If they ever happen)

If two teammates edited the exact same line in the same file, Git will pause and ask you to choose.

### In VS Code:
1. Open the conflicting file. You will see 4 clickable buttons above the conflict:
   - **`Accept Current Change`** (Keep your code)
   - **`Accept Incoming Change`** (Keep teammate's code)
   - **`Accept Both Changes`** (Keep both)
2. Click the right option and save the file (`Ctrl + S`).
3. Complete the merge via terminal:
   ```bash
   git add .
   git commit -m "fix: resolve merge conflicts between main and feature branch"
   git push
   ```

---

## 🧰 Quick Git Cheat Sheet

| Task | Command |
|---|---|
| Check current branch & changed files | `git status` |
| View commit history | `git log --oneline -5` |
| List all local branches | `git branch` |
| Switch to an existing branch | `git checkout <branch-name>` |
| Create & switch to a new branch | `git checkout -b <new-branch>` |
| Delete a branch after merging | `git branch -d <branch-name>` |
| Discard all uncommitted changes in a file | `git restore <file-name>` |
| Temporarily stash uncommitted work | `git stash` (Restore later with `git stash pop`) |

---

## ⚠️ Common Mistakes to Avoid

1. ❌ **Don't share the same database password directly in committed files**. Keep database credentials configurable.
2. ❌ **Don't commit `.class` or `.war` files**. The `.gitignore` file will block them automatically.
3. ❌ **Never run `git push --force`**. This can erase your teammate's commits.
4. ❌ **Don't start a new feature on an old branch**. Always checkout `main`, pull, and branch off fresh.
