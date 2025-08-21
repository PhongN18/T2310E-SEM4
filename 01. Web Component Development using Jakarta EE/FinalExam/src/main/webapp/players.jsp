<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Player Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" integrity="sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #333; }
        form { margin-bottom: 20px; }
        label { display: inline-block; color: #888}
        input, select { margin: 5px 0; padding: 8px 12px; font-size: 16px; border-radius: 4px; border: 1px solid #aaa; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { padding: 12px 16px; text-align: center; }
        th { font-weight: 600; color: white; background: #cd6e5a }
        a { color: dodgerblue }
        .table-header { border-radius: 8px; overflow: hidden }
        .add-form, .edit-form {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
            gap: 8px 16px; /* row gap / column gap */
            padding: 0 20px;
        }
        .add-form div, .edit-form div {
            display: flex;
            flex-direction: column;
        }
        .add-form-button, .edit-form-button { padding: 8px 12px; background: #cd6e5a; font-weight: 600; color: white; border: none; outline: none; border-radius: 8px; font-size: 20px }
        .button-div { display: flex; align-items: center; justify-content: center}
        .button-div button { width: 100% }
        .error { color: red; margin-bottom: 10px; }
        .actions form { display: inline; }
        .delete-button { border: none; background: transparent; color: red }
        .delete-button, .edit-button { font-size: 16px }
    </style>
</head>
<body>

<h2>Player Management</h2>

<!-- Show validation or DB errors -->
<c:if test="${not empty error}">
    <div class="error">${error}</div>
</c:if>

<!-- Add Player Form -->
<h3>Add Player</h3>
<form class="add-form" action="players" method="post">
    <input type="hidden" name="action" value="add">
    <div>
        <label>Player Name:</label>
        <input type="text" name="name" value="${sticky_name}" required><br>
    </div>

    <div>
        <label>Player Age:</label>
        <input type="text" name="age" value="${sticky_age}" required><br>
    </div>

    <div>
        <label>Index:</label>
        <select name="index_id" required>
            <c:forEach var="i" items="${indexers}">
                <option value="${i.index_id}"
                        <c:if test="${i.index_id == sticky_index_id}">selected</c:if>>
                        ${i.name} (min:${i.valueMin}, max:${i.valueMax})
                </option>
            </c:forEach>
        </select><br>
    </div>

    <div>
        <label>Value:</label>
        <input type="number" name="value" value="${sticky_value}" required><br>
    </div>

    <div class="button-div">
        <button class="add-form-button" type="submit">Add Player</button>
    </div>

</form>

<!-- Edit Player Form (only shown if editPlayer is set) -->
<c:if test="${not empty editPlayer}">
    <h3>Edit Player (ID: ${editPlayer.player_id})</h3>
    <form class="edit-form" action="players" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="player_id" value="${editPlayer.player_id}">

        <div>
            <label>Name:</label>
            <input type="text" name="name" value="${editPlayer.name}" required><br>
        </div>

        <div>
            <label>Age:</label>
            <input type="text" name="age" value="${editPlayer.age}" required><br>
        </div>

        <div>
            <label>Index:</label>
            <select name="index_id" required>
                <c:forEach var="i" items="${indexers}">
                    <option value="${i.index_id}"
                            <c:if test="${i.index_id == editPlayer.index_id}">selected</c:if>>
                            ${i.name} (min:${i.valueMin}, max:${i.valueMax})
                    </option>
                </c:forEach>
            </select><br>
        </div>

        <div>
            <label>Value:</label>
            <input type="number" name="value" value="${editPlayer.value}" required><br>
        </div>

        <div class="button-div">
            <button class="edit-form-button" type="submit">Update Player</button>
        </div>
    </form>
</c:if>

<!-- Players Table -->
<h3>All Players</h3>
<table>
    <tr class="table-header">
        <th>ID</th>
        <th>Name</th>
        <th>Age</th>
        <th>Value</th>
        <th>Index</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="p" items="${players}">
        <tr>
            <td>${p.player_id}</td>
            <td>${p.name}</td>
            <td>${p.age}</td>
            <td>${p.value}</td>
            <td>${p.index_name}</td>
            <td class="actions">
                <a class="edit-button" href="players?action=edit&id=${p.player_id}"><i class="fa-solid fa-pen"></i></a>
                <form action="players" method="post" style="display:inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${p.player_id}">
                    <button class="delete-button" type="submit" onclick="return confirm('Delete this player?');"><i class="fa-solid fa-trash"></i></button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
