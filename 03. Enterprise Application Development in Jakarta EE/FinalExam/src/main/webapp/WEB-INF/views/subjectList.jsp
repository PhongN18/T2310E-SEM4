<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Subjects</title>
    <style>
        /* General Reset and Typography - Consistent Style */
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

        /* --- Navigation/Top Buttons --- */
        .header-nav {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
        }

        .btn {
            padding: 10px 18px;
            background: #42a5f5; /* Light Blue for primary navigation */
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            transition: background 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: none;
        }

        .btn:hover {
            background: #1e88e5;
        }

        /* --- Add Subject Form Card --- */
        .form-card {
            background: white;
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            display: flex; /* Use flex for the form layout */
            gap: 15px;
            align-items: flex-end; /* Align fields and button to the bottom */
            flex-wrap: wrap;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            flex-grow: 1; /* Allow fields to take up available space */
            min-width: 120px; /* Ensure fields don't get too small */
        }

        .form-group label {
            font-weight: 600;
            color: #1a237e;
            font-size: 0.95em;
            margin-bottom: 4px;
        }

        .form-card input[type="text"],
        .form-card input[type="number"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            box-sizing: border-box;
        }

        .btn-add {
            padding: 10px 20px;
            background: #28a745; /* Green for 'Add' action */
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            white-space: nowrap;
        }

        .btn-add:hover {
            background: #1e7e34;
        }

        /* --- Subject Table Styling --- */
        .data-table-container {
            overflow-x: auto;
        }

        table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            min-width: 600px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
        }

        th {
            background: #e3f2fd;
            color: #1a237e;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.9em;
        }

        tr:not(:last-child) td {
            border-bottom: 1px solid #e0e0e0;
        }

        /* Styling for inline input fields */
        table input[type="text"],
        table input[type="number"] {
            width: 95%;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-family: inherit;
            text-align: left;
        }

        /* Actions in Table */
        .action-cell {
            text-align: center;
            white-space: nowrap;
        }

        .action-form {
            display: flex;
            gap: 5px;
            justify-content: center;
        }

        .action-cell button {
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.85em;
            font-weight: 600;
            transition: background 0.3s ease, color 0.3s ease;
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

        /* Specific alignment for Credit column */
        .credit-cell {
            text-align: center;
            width: 80px;
        }
    </style>
</head>
<body>

<h2>📚 Manage Subjects</h2>

<div class="header-nav">
    <a href="${pageContext.request.contextPath}/" class="btn">Manage Scores</a>
    <a href="${pageContext.request.contextPath}/student" class="btn">Manage Students</a>
</div>

<div class="form-card">
    <form action="${pageContext.request.contextPath}/subject" method="post" style="display:contents;">
        <input type="hidden" name="action" value="add"/>

        <div class="form-group">
            <label for="code">Subject Code</label>
            <input type="text" name="subjectCode" id="code" placeholder="e.g., CS101" required>
        </div>

        <div class="form-group">
            <label for="name">Subject Name</label>
            <input type="text" name="subjectName" id="name" placeholder="e.g., Introduction to Programming" required>
        </div>

        <div class="form-group" style="max-width: 100px;">
            <label for="credit">Credit</label>
            <input type="number" name="credit" id="credit" min="1" max="6" placeholder="e.g., 3" required>
        </div>

        <button type="submit" class="btn-add">➕ Add Subject</button>
    </form>
</div>

<div class="data-table-container">
    <table>
        <thead>
        <tr>
            <th style="width: 50px;">ID</th>
            <th style="width: 150px;">Code</th>
            <th>Name</th>
            <th class="credit-cell">Credit</th>
            <th class="action-cell" style="width: 130px;">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="sub" items="${subjects}">
            <tr>
                <td>${sub.subjectId}</td>
                <form action="${pageContext.request.contextPath}/subject" method="post" class="action-form">
                    <td><input type="text" name="subjectCode" value="${sub.subjectCode}" required></td>
                    <td><input type="text" name="subjectName" value="${sub.subjectName}" required></td>
                    <td class="credit-cell"><input type="number" name="credit" value="${sub.credit}" min="1" max="6" required style="text-align: center;"></td>
                    <td class="action-cell">
                        <input type="hidden" name="subjectId" value="${sub.subjectId}"/>
                        <button type="submit" name="action" value="edit" class="btn-edit"
                                onclick="return confirm('⚠️ Are you sure you want to edit ${sub.subjectName} information?')">Edit</button>
                        <button type="submit" name="action" value="delete" class="btn-delete"
                                onclick="return confirm('⚠️ Are you sure you want to delete ${sub.subjectName}? This will affect all associated scores.')">Delete</button>
                    </td>
                </form>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>