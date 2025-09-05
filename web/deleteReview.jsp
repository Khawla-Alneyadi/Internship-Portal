<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Delete Review</title>
    <style>
        body {
            font-family: sans-serif;
            background: #f5f5f5;
            margin: 0;
            text-align: center;
        }
        header {
            background: #800000;
            color: white;
            padding: 20px;
            font-size: 24px;
        }
        .message {
            margin-top: 50px;
            font-size: 20px;
            color: #800000;
        }
    </style>
</head>
<body>
<header>Delete Review</header>
<%
    String id = request.getParameter("id");
    try {
        if (id != null) {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM rating WHERE rating_id = ?");
            ps.setInt(1, Integer.parseInt(id));
            int rows = ps.executeUpdate();
            ps.close();
            conn.close();
            if (rows > 0) {
%>
                <p class="message">✅ Review deleted successfully. Redirecting...</p>
<%
            } else {
%>
                <p class="message">⚠️ Review not found or already deleted.</p>
<%
            }
        } else {
%>
            <p class="message">❌ Invalid review ID.</p>
<%
        }
    } catch (Exception e) {
%>
    <p class="message">Error: <%= e.getMessage() %></p>
<%
    }
%>
<script>
    setTimeout(() => window.location.href = 'moderateReviews.jsp', 2000);
</script>
</body>
</html>
