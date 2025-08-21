package com.example.finalexam;

import com.example.finalexam.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/players")
public class PlayerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        try (Connection conn = DBUtil.getConnection()) {

            req.setAttribute("indexers", loadIndexers(conn));

            if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Map<String, Object> p = findPlayerById(conn, id);
                if (p == null) {
                    req.setAttribute("error", "Player not found (id=" + id + ").");
                } else {
                    req.setAttribute("editPlayer", p);
                }
                req.setAttribute("players", loadPlayers(conn));
                req.getRequestDispatcher("/players.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("players", loadPlayers(conn));
            req.getRequestDispatcher("/players.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        try (Connection conn = DBUtil.getConnection()) {
            if ("add".equalsIgnoreCase(action)) {
                String error = addPlayer(conn, req);
                if (error != null) {
                    req.setAttribute("error", error);
                    req.setAttribute("sticky_name", req.getParameter("name"));
                    req.setAttribute("sticky_age", req.getParameter("age"));
                    req.setAttribute("sticky_value", req.getParameter("value"));
                    req.setAttribute("sticky_index_id", req.getParameter("index_id"));
                    req.setAttribute("indexers", loadIndexers(conn));
                    req.setAttribute("players", loadPlayers(conn));
                    req.getRequestDispatcher("/players.jsp").forward(req, resp);
                    return;
                }
                resp.sendRedirect("players");
                return;
            }

            if ("update".equalsIgnoreCase(action)) {
                String error = updatePlayer(conn, req);
                if (error != null) {
                    req.setAttribute("error", error);
                    int id = Integer.parseInt(req.getParameter("player_id"));
                    req.setAttribute("editPlayer", findPlayerById(conn, id));
                    req.setAttribute("indexers", loadIndexers(conn));
                    req.setAttribute("players", loadPlayers(conn));
                    req.getRequestDispatcher("/players.jsp").forward(req, resp);
                    return;
                }
                resp.sendRedirect("players");
                return;
            }

            if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                deletePlayer(conn, id);
                resp.sendRedirect("players");
                return;
            }

            resp.sendRedirect("players");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


    private List<Map<String, Object>> loadPlayers(Connection conn) throws SQLException {
        String sql = """
            SELECT p.player_id, p.name, p.age, p.value, p.index_id, i.name AS index_name
            FROM player p
            JOIN indexer i ON p.index_id = i.index_id
            ORDER BY p.player_id DESC
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("player_id", rs.getInt("player_id"));
                row.put("name", rs.getString("name"));
                row.put("age", rs.getString("age"));
                row.put("value", rs.getInt("value"));
                row.put("index_id", rs.getInt("index_id"));
                row.put("index_name", rs.getString("index_name"));
                list.add(row);
            }
            return list;
        }
    }

    private Map<String, Object> findPlayerById(Connection conn, int id) throws SQLException {
        String sql = """
            SELECT p.player_id, p.name, p.age, p.value, p.index_id, i.name AS index_name
            FROM player p
            JOIN indexer i ON p.index_id = i.index_id
            WHERE p.player_id = ?
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Map<String, Object> row = new HashMap<>();
                row.put("player_id", rs.getInt("player_id"));
                row.put("name", rs.getString("name"));
                row.put("age", rs.getString("age"));
                row.put("value", rs.getInt("value"));
                row.put("index_id", rs.getInt("index_id"));
                row.put("index_name", rs.getString("index_name"));
                return row;
            }
        }
    }

    private List<Map<String, Object>> loadIndexers(Connection conn) throws SQLException {
        String sql = "SELECT index_id, name, valueMin, valueMax FROM indexer ORDER BY index_id";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("index_id", rs.getInt("index_id"));
                row.put("name", rs.getString("name"));
                row.put("valueMin", rs.getFloat("valueMin"));
                row.put("valueMax", rs.getFloat("valueMax"));
                list.add(row);
            }
            return list;
        }
    }

    private String addPlayer(Connection conn, HttpServletRequest req) throws SQLException {
        String name = safe(req.getParameter("name"));
        String age = safe(req.getParameter("age"));
        String valueStr = safe(req.getParameter("value"));
        String indexIdStr = safe(req.getParameter("index_id"));

        if (name.isEmpty() || age.isEmpty() || valueStr.isEmpty() || indexIdStr.isEmpty())
            return "All fields are required.";

        int value, indexId;
        try {
            value = Integer.parseInt(valueStr);
            indexId = Integer.parseInt(indexIdStr);
        } catch (NumberFormatException ex) {
            return "Value and Index must be numeric.";
        }

        Range r = getIndexRange(conn, indexId);
        if (r == null) return "Selected index does not exist.";
        if (value < r.min || value > r.max) {
            return "Value must be between " + trim(r.min) + " and " + trim(r.max) + " for index '" + r.name + "'.";
        }

        String sql = "INSERT INTO player(name, age, value, index_id) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, age);
            ps.setInt(3, value);
            ps.setInt(4, indexId);
            ps.executeUpdate();
        }
        return null;
    }

    private String updatePlayer(Connection conn, HttpServletRequest req) throws SQLException {
        String idStr = safe(req.getParameter("player_id"));
        String name = safe(req.getParameter("name"));
        String age = safe(req.getParameter("age"));
        String valueStr = safe(req.getParameter("value"));
        String indexIdStr = safe(req.getParameter("index_id"));

        if (idStr.isEmpty() || name.isEmpty() || age.isEmpty() || valueStr.isEmpty() || indexIdStr.isEmpty())
            return "All fields are required.";

        int id, value, indexId;
        try {
            id = Integer.parseInt(idStr);
            value = Integer.parseInt(valueStr);
            indexId = Integer.parseInt(indexIdStr);
        } catch (NumberFormatException ex) {
            return "IDs and Value must be numeric.";
        }

        if (findPlayerById(conn, id) == null) return "Player not found (id=" + id + ").";

        Range r = getIndexRange(conn, indexId);
        if (r == null) return "Selected index does not exist.";
        if (value < r.min || value > r.max) {
            return "Value must be between " + trim(r.min) + " and " + trim(r.max) + " for index '" + r.name + "'.";
        }

        String sql = "UPDATE player SET name=?, age=?, value=?, index_id=? WHERE player_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, age);
            ps.setInt(3, value);
            ps.setInt(4, indexId);
            ps.setInt(5, id);
            ps.executeUpdate();
        }
        return null;
    }

    private void deletePlayer(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM player WHERE player_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private static String safe(String s) { return s == null ? "" : s.trim(); }

    private static String trim(float f) {
        if (f == (long) f) return String.format("%d", (long) f);
        return String.valueOf(f);
    }

    private Range getIndexRange(Connection conn, int indexId) throws SQLException {
        String sql = "SELECT name, valueMin, valueMax FROM indexer WHERE index_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, indexId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Range r = new Range();
                r.name = rs.getString("name");
                r.min = rs.getFloat("valueMin");
                r.max = rs.getFloat("valueMax");
                return r;
            }
        }
    }

    private static class Range {
        String name;
        float min;
        float max;
    }
}
