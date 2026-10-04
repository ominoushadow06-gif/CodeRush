package com.coderush.servlet;

import com.coderush.dao.ResultDAO;
import com.coderush.model.Result;
import com.coderush.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private ResultDAO resultDAO;

    @Override
    public void init() {
        resultDAO = new ResultDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String language = request.getParameter("language");
        String difficulty = request.getParameter("difficulty");

        List<Result> historyList = resultDAO.getResultsByUserIdAndFilters(user.getUserId(), language, difficulty);

        request.setAttribute("historyList", historyList);
        request.setAttribute("selectedLanguage", language != null ? language : "all");
        request.setAttribute("selectedDifficulty", difficulty != null ? difficulty : "all");

        request.getRequestDispatcher("/history.jsp").forward(request, response);
    }
}
