package com.coderush.dao;

import com.coderush.model.Result;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {

    public boolean saveResult(Result result) {
        String sql = "INSERT INTO results (user_id, snippet_id, language, wpm, accuracy, mistakes, time_taken, difficulty) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, result.getUserId());
            ps.setInt(2, result.getSnippetId());
            ps.setString(3, result.getLanguage() != null ? result.getLanguage().toLowerCase().trim() : "java");
            ps.setDouble(4, result.getWpm());
            ps.setDouble(5, result.getAccuracy());
            ps.setInt(6, result.getMistakes());
            ps.setInt(7, result.getTimeTaken());
            ps.setString(8, result.getDifficulty());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Result> getResultsByUserId(int userId) {
        List<Result> list = new ArrayList<>();
        String sql = "SELECT * FROM results WHERE user_id = ? ORDER BY attempted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Result(
                        rs.getInt("result_id"),
                        rs.getInt("user_id"),
                        rs.getInt("snippet_id"),
                        rs.getString("language"),
                        rs.getDouble("wpm"),
                        rs.getDouble("accuracy"),
                        rs.getInt("mistakes"),
                        rs.getInt("time_taken"),
                        rs.getString("difficulty"),
                        rs.getTimestamp("attempted_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Result> getResultsByUserIdAndFilters(int userId, String language, String difficulty) {
        List<Result> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM results WHERE user_id = ?");
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (language != null && !language.isEmpty() && !language.equalsIgnoreCase("all")) {
            sql.append(" AND language = ?");
            params.add(language.toLowerCase().trim());
        }
        if (difficulty != null && !difficulty.isEmpty() && !difficulty.equalsIgnoreCase("all")) {
            sql.append(" AND difficulty = ?");
            params.add(difficulty.toLowerCase().trim());
        }
        sql.append(" ORDER BY attempted_at DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Result(
                        rs.getInt("result_id"),
                        rs.getInt("user_id"),
                        rs.getInt("snippet_id"),
                        rs.getString("language"),
                        rs.getDouble("wpm"),
                        rs.getDouble("accuracy"),
                        rs.getInt("mistakes"),
                        rs.getInt("time_taken"),
                        rs.getString("difficulty"),
                        rs.getTimestamp("attempted_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
