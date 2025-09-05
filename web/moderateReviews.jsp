<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Moderate Reviews</title>
    <style>
        body { font-family: sans-serif; background: #f5f5f5; margin: 0; }
        header { background: #800000; color: white; padding: 20px; text-align: center; font-size: 24px; }
        table { width: 90%; margin: 20px auto; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ccc; padding: 10px; }
        th { background-color: #800000; color: white; }
        a.button {
            background-color: #800000;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<header>Moderate Reviews</header>
<table>
    <tr><th>ID</th><th>User</th><th>Company</th><th>Rating</th><th>Comment</th><th>Actions</th></tr>
    <%
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "SELECT r.rating_id, r.user_name, c.company_name, r.rating, r.comment " +
            "FROM rating r JOIN company c ON r.company_id = c.company_id"
        );
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("rating_id") %></td>
        <td><%= rs.getString("user_name") %></td>
        <td><%= rs.getString("company_name") %></td>
        <td><%= rs.getInt("rating") %></td>
        <td><%= rs.getString("comment") %></td>
        <td><a href="deleteReview.jsp?id=<%= rs.getInt("rating_id") %>" class="button">Delete</a></td>
    </tr>
    <% } rs.close(); ps.close(); conn.close(); %>
    
        <div style="margin: 20px 40px;">
        <a href="admin.jsp" style="
        background-color: #800000;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 8px;
        font-weight: bold;
        font-size: 16px;
        display: inline-block;
           ">← Back to Dashboard</a>
    </div>

</table>
</body>
</html>
