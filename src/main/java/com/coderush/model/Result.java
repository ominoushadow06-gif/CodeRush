package com.coderush.model;

import java.sql.Timestamp;

public class Result {
    private int resultId;
    private int userId;
    private int snippetId;
    private String language;
    private double wpm;
    private double accuracy;
    private int mistakes;
    private int timeTaken; // in seconds
    private String difficulty;
    private Timestamp attemptedAt;

    public Result() {}

    public Result(int resultId, int userId, int snippetId, String language, double wpm, double accuracy, int mistakes, int timeTaken, String difficulty, Timestamp attemptedAt) {
        this.resultId = resultId;
        this.userId = userId;
        this.snippetId = snippetId;
        this.language = language;
        this.wpm = wpm;
        this.accuracy = accuracy;
        this.mistakes = mistakes;
        this.timeTaken = timeTaken;
        this.difficulty = difficulty;
        this.attemptedAt = attemptedAt;
    }

    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getSnippetId() {
        return snippetId;
    }

    public void setSnippetId(int snippetId) {
        this.snippetId = snippetId;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public double getWpm() {
        return wpm;
    }

    public void setWpm(double wpm) {
        this.wpm = wpm;
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(double accuracy) {
        this.accuracy = accuracy;
    }

    public int getMistakes() {
        return mistakes;
    }

    public void setMistakes(int mistakes) {
        this.mistakes = mistakes;
    }

    public int getTimeTaken() {
        return timeTaken;
    }

    public void setTimeTaken(int timeTaken) {
        this.timeTaken = timeTaken;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public Timestamp getAttemptedAt() {
        return attemptedAt;
    }

    public void setAttemptedAt(Timestamp attemptedAt) {
        this.attemptedAt = attemptedAt;
    }
}
