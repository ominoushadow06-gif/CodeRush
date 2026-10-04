package com.coderush.servlet;

import com.coderush.dao.UserDAO;
import com.coderush.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null ||
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Basic password storage / hashing placeholder (can use BCrypt or SHA-256)
        String passwordHash = password; // TODO: Integrate SHA-256 or BCrypt hashing

        User user = new User(username.trim(), email.trim(), passwordHash);
        boolean created = userDAO.registerUser(user);

        if (created) {
            User registeredUser = userDAO.getUserByUsernameOrEmail(username);
            HttpSession session = request.getSession();
            session.setAttribute("user", registeredUser);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            request.setAttribute("error", "Username or Email already exists.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}
