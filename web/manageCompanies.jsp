<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Manage Companies</title>
    <style>
        body {
            font-family: sans-serif;
            background: #f5f5f5;
            margin: 0;
        }

        header {
            background: #800000;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
        }

        .top-bar {
            width: 90%;
            margin: 20px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar a {
            background-color: #800000;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
        }

        table {
            width: 90%;
            margin: 0 auto 40px auto;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #800000;
            color: white;
        }

        a.button {
            background-color: #800000;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 5px;
            display: inline-block;
        }
    </style>
</head>
<body>

<header>Manage Companies</header>

<!-- Top bar with navigation and add button -->
<div class="top-bar">
    <a href="admin.jsp">← Back to Dashboard</a>
    <a href="addCompany.jsp">Add Company</a>
</div>

<!-- Companies Table -->
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Industry</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>

    <%
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM company");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("company_id") %></td>
        <td><%= rs.getString("company_name") %></td>
        <td><%= rs.getString("industry") %></td>
        <td><%= rs.getString("email") %></td>
        <td>
            <a href="editCompany.jsp?id=<%= rs.getInt("company_id") %>" class="button">Edit</a>
            <a href="deleteCompany.jsp?id=<%= rs.getInt("company_id") %>" class="button">Delete</a>
        </td>
    </tr>
    <%
        }
        rs.close();
        ps.close();
        conn.close();
    %>
</table>

</body>
</html>
