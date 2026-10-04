package com.coderush.servlet;

import com.coderush.dao.SnippetDAO;
import com.coderush.model.Snippet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/snippet")
public class SnippetServlet extends HttpServlet {
    private SnippetDAO snippetDAO;

    @Override
    public void init() {
        snippetDAO = new SnippetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String language = request.getParameter("language");
        String difficulty = request.getParameter("difficulty");

        if (language == null || language.trim().isEmpty()) {
            language = "java";
        }
        if (difficulty == null || difficulty.trim().isEmpty()) {
            difficulty = "easy";
        }

        Snippet snippet = snippetDAO.getRandomSnippet(language, difficulty);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (snippet != null) {
            String json = String.format(
                "{\"snippetId\": %d, \"language\": \"%s\", \"difficulty\": \"%s\", \"description\": \"%s\", \"codeText\": \"%s\"}",
                snippet.getSnippetId(),
                escapeJson(snippet.getLanguage()),
                escapeJson(snippet.getDifficulty()),
                escapeJson(snippet.getDescription()),
                escapeJson(snippet.getCodeText())
            );
            out.print(json);
        } else {
            out.print("{\"error\": \"No snippet found for " + escapeJson(language) + " (" + escapeJson(difficulty) + ")\"}");
        }
        out.flush();
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}
