package com.coderush.dao;

import com.coderush.model.Snippet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SnippetDAO {

    private String getTableName(String language) {
        if (language == null) return "snippets_java";
        switch (language.toLowerCase().trim()) {
            case "python":
            case "py":
                return "snippets_python";
            case "c":
                return "snippets_C";
            case "java":
            default:
                return "snippets_java";
        }
    }

    public Snippet getRandomSnippet(String language, String difficulty) {
        String table = getTableName(language);
        String sql = "SELECT * FROM " + table + " WHERE difficulty = ? ORDER BY RAND() LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, difficulty != null ? difficulty.toLowerCase().trim() : "easy");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Snippet(
                        rs.getInt("snippet_id"),
                        rs.getString("code_text"),
                        rs.getString("description"),
                        language != null ? language.toLowerCase().trim() : "java",
                        rs.getString("difficulty"),
                        rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Snippet getSnippetById(String language, int snippetId) {
        String table = getTableName(language);
        String sql = "SELECT * FROM " + table + " WHERE snippet_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, snippetId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Snippet(
                        rs.getInt("snippet_id"),
                        rs.getString("code_text"),
                        rs.getString("description"),
                        language != null ? language.toLowerCase().trim() : "java",
                        rs.getString("difficulty"),
                        rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
