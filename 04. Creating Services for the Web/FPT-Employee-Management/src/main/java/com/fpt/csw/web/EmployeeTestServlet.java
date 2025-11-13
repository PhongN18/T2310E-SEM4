package com.fpt.csw.web;

import com.fpt.csw.model.Employee;
import com.fpt.csw.ws.EmployeeWebService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class EmployeeTestServlet extends HttpServlet {

    // Directly use your web service class
    private final EmployeeWebService service = new EmployeeWebService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h2>All Employees (getEmployees)</h2>");

        Employee[] employees = service.getEmployees();  // call webservice method

        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Name</th><th>Salary</th></tr>");
        if (employees != null) {
            for (Employee e : employees) {
                out.printf("<tr><td>%d</td><td>%s</td><td>%.2f</td></tr>",
                        e.getId(), e.getName(), e.getSalary());
            }
        }
        out.println("</table>");

        // Form to add employee
        out.println("<h3>Add New Employee (addEmployees)</h3>");
        out.println("<form method='post'>");
        out.println("Name: <input name='name'/><br/>");
        out.println("Salary: <input name='salary'/><br/>");
        out.println("<input type='hidden' name='action' value='add'/>");
        out.println("<input type='submit' value='Add'/>");
        out.println("</form>");

        // Form to update employee
        out.println("<h3>Update Employee (updateEmployee)</h3>");
        out.println("<form method='post'>");
        out.println("ID: <input name='id'/><br/>");
        out.println("Name: <input name='name'/><br/>");
        out.println("Salary: <input name='salary'/><br/>");
        out.println("<input type='hidden' name='action' value='update'/>");
        out.println("<input type='submit' value='Update'/>");
        out.println("</form>");

        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                double salary = Double.parseDouble(req.getParameter("salary"));

                Employee e = new Employee();
                e.setName(name);
                e.setSalary(salary);

                service.addEmployees(e);  // call webservice method

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                double salary = Double.parseDouble(req.getParameter("salary"));

                Employee e = new Employee();
                e.setId(id);
                e.setName(name);
                e.setSalary(salary);

                service.updateEmployee(e);  // call webservice method
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        // After POST, refresh the list
        resp.sendRedirect(req.getContextPath() + "/test");
    }
}
