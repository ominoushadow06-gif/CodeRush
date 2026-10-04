package com.coderush.servlet;

import com.coderush.dao.ResultDAO;
import com.coderush.model.Result;
import com.coderush.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {
    private ResultDAO resultDAO;

    @Override
    public void init() {
        resultDAO = new ResultDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int snippetId = Integer.parseInt(request.getParameter("snippetId"));
            String language = request.getParameter("language");
            double wpm = Double.parseDouble(request.getParameter("wpm"));
            double accuracy = Double.parseDouble(request.getParameter("accuracy"));
            int mistakes = Integer.parseInt(request.getParameter("mistakes"));
            int timeTaken = Integer.parseInt(request.getParameter("timeTaken"));
            String difficulty = request.getParameter("difficulty");

            Result result = new Result();
            result.setUserId(user.getUserId());
            result.setSnippetId(snippetId);
            result.setLanguage(language != null ? language : "java");
            result.setWpm(wpm);
            result.setAccuracy(accuracy);
            result.setMistakes(mistakes);
            result.setTimeTaken(timeTaken);
            result.setDifficulty(difficulty != null ? difficulty : "easy");

            boolean saved = resultDAO.saveResult(result);
            if (saved) {
                request.setAttribute("latestResult", result);
                request.getRequestDispatcher("/result.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
