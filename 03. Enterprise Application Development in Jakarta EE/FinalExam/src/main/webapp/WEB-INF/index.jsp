<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Student Information System</title>
  <style>
    /* General Reset and Typography */
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 25px;
      background-color: #f7f9fc; /* Light background */
      color: #333;
    }

    h2 {
      color: #1a237e; /* Deep Indigo for main titles */
      margin-bottom: 20px;
      border-bottom: 2px solid #e0e0e0;
      padding-bottom: 10px;
    }

    /* Header/Navigation Buttons */
    .header-nav {
      display: flex;
      gap: 10px;
      margin-bottom: 30px;
      padding-bottom: 10px;
      border-bottom: 1px solid #e0e0e0;
    }

    .btn {
      padding: 10px 18px;
      background: #42a5f5; /* Light Blue for primary action */
      color: white;
      text-decoration: none;
      border-radius: 6px; /* Slightly more rounded corners */
      font-weight: 600;
      transition: background 0.3s ease;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .btn:hover {
      background: #1e88e5; /* Darker blue on hover */
    }

    .btn-primary {
      background: #28a745; /* Green for 'Add' action */
    }

    .btn-primary:hover {
      background: #1e7e34;
    }

    /* Table Styling */
    .data-table-container {
      overflow-x: auto; /* Ensures responsiveness on smaller screens */
    }

    table {
      border-collapse: separate; /* Use separate for more distinct cells */
      border-spacing: 0;
      width: 100%;
      min-width: 800px; /* Ensure table isn't too squished */
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* Soft shadow for depth */
      background-color: white;
      border-radius: 8px; /* Rounded table corners */
      overflow: hidden; /* Important for rounding borders */
    }

    th, td {
      padding: 12px 15px;
      text-align: left; /* Align text to the left for better readability */
    }

    th {
      background: #e3f2fd; /* Very light blue for header */
      color: #1a237e;
      font-weight: 700;
      text-transform: uppercase;
      font-size: 0.9em;
      letter-spacing: 0.5px;
    }

    /* Table Border Styling */
    tr:not(:last-child) td {
      border-bottom: 1px solid #e0e0e0;
    }

    td {
      border-right: none;
    }

    /* Action Column Styling */
    .action-cell {
      white-space: nowrap; /* Prevents buttons from wrapping */
      text-align: center; /* Center action buttons */
    }

    .action-form {
      display: flex;
      gap: 5px; /* Spacing between Edit/Delete buttons */
      justify-content: center;
    }

    .action-form button {
      padding: 6px 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 0.85em;
      font-weight: 600;
      transition: background 0.3s ease;
    }

    .btn-edit {
      background-color: #ffc107; /* Amber for edit */
      color: #333;
    }

    .btn-edit:hover {
      background-color: #e0a800;
    }

    .btn-delete {
      background-color: #dc3545; /* Red for delete */
      color: white;
    }

    .btn-delete:hover {
      background-color: #bd2130;
    }

    /* Highlight for important data like Grade */
    .grade-data {
      font-weight: 700;
      color: #00796b; /* Teal color */
    }

  </style>
</head>
<body>

<h2>📝 Score Management</h2>

<div class="header-nav">
  <a href="${pageContext.request.contextPath}/student" class="btn">Manage Students</a>
  <a href="${pageContext.request.contextPath}/subject" class="btn">Manage Subjects</a>
  <a href="${pageContext.request.contextPath}/score" class="btn btn-primary">+ Add New Score</a>
</div>

<div class="data-table-container">
  <table>
    <thead>
    <tr>
      <th>#</th>
      <th>Student ID</th>
      <th>Student Name</th>
      <th>Subject Name</th>
      <th>Score 1</th>
      <th>Score 2</th>
      <th>Credit</th>
      <th>Grade</th>
      <th class="action-cell">Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="sc" items="${scores}" varStatus="loop">
      <tr>
        <td>${loop.index + 1}</td>
        <td>${sc.student.studentCode}</td>
        <td>${sc.student.fullName}</td>
        <td>${sc.subject.subjectName}</td>
        <td>${sc.score1}</td>
        <td>${sc.score2}</td>
        <td>${sc.subject.credit}</td>
        <td class="grade-data">${sc.grade}</td>
        <td class="action-cell">
          <form action="${pageContext.request.contextPath}/score" method="post" class="action-form">
            <input type="hidden" name="scoreId" value="${sc.studentScoreId}"/>
            <input type="hidden" name="studentId" value="${sc.student.studentId}"/>
            <input type="hidden" name="subjectId" value="${sc.subject.subjectId}"/>

            <button type="submit" name="action" value="edit" class="btn-edit">Edit</button>
            <button type="submit" name="action" value="delete" class="btn-delete" onclick="return confirm('⚠️ Are you sure you want to delete this score record?')">Delete</button>
          </form>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

</body>
</html>