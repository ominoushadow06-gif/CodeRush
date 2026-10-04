package com.coderush.model;

import java.sql.Timestamp;

public class Snippet {
    private int snippetId;
    private String codeText;
    private String description;
    private String language;
    private String difficulty;
    private Timestamp createdAt;

    public Snippet() {}

    public Snippet(int snippetId, String codeText, String description, String language, String difficulty, Timestamp createdAt) {
        this.snippetId = snippetId;
        this.codeText = codeText;
        this.description = description;
        this.language = language;
        this.difficulty = difficulty;
        this.createdAt = createdAt;
    }

    public int getSnippetId() {
        return snippetId;
    }

    public void setSnippetId(int snippetId) {
        this.snippetId = snippetId;
    }

    public String getCodeText() {
        return codeText;
    }

    public void setCodeText(String codeText) {
        this.codeText = codeText;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
