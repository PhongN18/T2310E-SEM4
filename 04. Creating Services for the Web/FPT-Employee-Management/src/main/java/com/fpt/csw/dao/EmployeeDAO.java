package com.fpt.csw.dao;

import com.fpt.csw.model.Employee;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    public List<Employee> getEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT id, name, salary FROM employees";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Employee e = new Employee(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("salary"));
                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int addEmployee(Employee e) {
        String sql = "INSERT INTO employees(name, salary) VALUES(?, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getName());
            ps.setDouble(2, e.getSalary());
            return ps.executeUpdate();   // 1 if success
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int updateEmployee(Employee e) {
        String sql = "UPDATE employees SET name = ?, salary = ? WHERE id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getName());
            ps.setDouble(2, e.getSalary());
            ps.setInt(3, e.getId());
            return ps.executeUpdate();   // 1 if success
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }
}
