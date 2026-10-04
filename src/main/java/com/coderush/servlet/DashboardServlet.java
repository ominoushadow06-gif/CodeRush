package com.coderush.servlet;

import com.coderush.dao.ResultDAO;
import com.coderush.model.Result;
import com.coderush.model.User;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
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

        List<Result> recentResults = resultDAO.getResultsByUserId(user.getUserId());
        request.setAttribute("recentResults", recentResults);

        double avgWpm = recentResults.stream().mapToDouble(Result::getWpm).average().orElse(0.0);
        double avgAccuracy = recentResults.stream().mapToDouble(Result::getAccuracy).average().orElse(0.0);
        int totalSessions = recentResults.size();

        // Calculate top language
        String topLanguage = "Java";
        if (!recentResults.isEmpty()) {
            Map<String, Long> langCounts = recentResults.stream()
                .filter(r -> r.getLanguage() != null)
                .collect(Collectors.groupingBy(Result::getLanguage, Collectors.counting()));
            topLanguage = langCounts.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse("Java");
        }

        request.setAttribute("avgWpm", String.format("%.1f", avgWpm));
        request.setAttribute("avgAccuracy", String.format("%.1f", avgAccuracy));
        request.setAttribute("totalSessions", totalSessions);
        request.setAttribute("topLanguage", topLanguage.toUpperCase());

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
