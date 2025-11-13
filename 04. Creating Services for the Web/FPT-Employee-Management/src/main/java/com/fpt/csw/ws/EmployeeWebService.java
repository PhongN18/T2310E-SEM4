package com.fpt.csw.ws;

import com.fpt.csw.dao.EmployeeDAO;
import com.fpt.csw.model.Employee;
import jakarta.jws.WebMethod;
import jakarta.jws.WebService;

import java.util.List;

@WebService(serviceName = "EmployeeWebService")
public class EmployeeWebService {

    private final EmployeeDAO dao = new EmployeeDAO();

    @WebMethod
    public Employee[] getEmployees() {
        List<Employee> list = dao.getEmployees();
        return list.toArray(new Employee[0]);
    }

    @WebMethod
    public boolean addEmployees(Employee e) {
        return dao.addEmployee(e) > 0;
    }

    @WebMethod
    public boolean updateEmployee(Employee e) {
        return dao.updateEmployee(e) > 0;
    }
}
