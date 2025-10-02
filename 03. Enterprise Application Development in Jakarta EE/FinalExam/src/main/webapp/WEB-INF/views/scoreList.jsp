<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add New Score</title>
    <style>
        /* General Reset and Typography - Matching the previous design */
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

        /* Card-like container for the form */
        .form-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            max-width: 600px;
            margin: 0 auto; /* Center the form */
        }

        /* Form Layout using CSS Grid for alignment */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr; /* Default single column */
            gap: 20px;
        }

        @media (min-width: 500px) {
            .form-grid {
                grid-template-columns: 1fr 1fr; /* Two columns on wider screens */
            }
            .full-width {
                grid-column: span 2; /* Full width for select fields */
            }
        }

        /* Form Group and Labels */
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        label {
            font-weight: 600;
            color: #1a237e;
            font-size: 0.95em;
        }

        input[type="number"], select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            width: 100%;
            box-sizing: border-box; /* Include padding/border in element's total width/height */
        }

        /* Button Styling - Primary action style */
        .btn-submit {
            grid-column: span 2; /* Center button below all fields */
            padding: 12px 25px;
            background: #28a745; /* Green for 'Add' action */
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: #1e7e34;
        }

        /* Alert Message Style */
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: 500;
        }

    </style>
    <c:if test="${param.success != null && param.success == 'true'}">
        <script>
            alert("Score added successfully! Redirecting to the main list.");
            window.location.href = '${pageContext.request.contextPath}/';
        </script>
    </c:if>
</head>
<body>

<h2>➕ Add New Score</h2>

<c:if test="${param.success != null && param.success == 'true'}">
    <div class="alert-success">
        ✅ Score added successfully! Redirecting...
    </div>
</c:if>

<div class="form-card">
    <form action="${pageContext.request.contextPath}/score" method="post" class="form-grid">
        <input type="hidden" name="action" value="add"/>

        <div class="form-group full-width">
            <label for="studentId">Student</label>
            <select name="studentId" id="studentId" required>
                <c:forEach var="s" items="${students}">
                    <option value="${s.studentId}">${s.fullName} (${s.studentCode})</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group full-width">
            <label for="subjectId">Subject</label>
            <select name="subjectId" id="subjectId" required>
                <c:forEach var="sub" items="${subjects}">
                    <option value="${sub.subjectId}">${sub.subjectName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="score1">Score 1</label>
            <input type="number" step="0.1" name="score1" id="score1" min="0" max="100" placeholder="e.g., 75.5" required>
        </div>

        <div class="form-group">
            <label for="score2">Score 2</label>
            <input type="number" step="0.1" name="score2" id="score2" min="0" max="100" placeholder="e.g., 88.0" required>
        </div>

        <button type="submit" class="btn-submit">Add Score Record</button>
    </form>
</div>

</body>
</html>