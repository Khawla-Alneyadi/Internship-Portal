<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Delete Company</title>
    <style>
        body {
            font-family: sans-serif;
            background: #f5f5f5;
            text-align: center;
            margin: 0;
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

<header>Delete Company</header>

<%
    String id = request.getParameter("id");
    try {
        if (id != null) {
            Connection conn = DBConnection.getConnection();

            // Step 1: Delete related reviews
            PreparedStatement ps1 = conn.prepareStatement("DELETE FROM rating WHERE company_id = ?");
            ps1.setInt(1, Integer.parseInt(id));
            ps1.executeUpdate();
            ps1.close();

            // Step 2: Delete the company
            PreparedStatement ps2 = conn.prepareStatement("DELETE FROM company WHERE company_id = ?");
            ps2.setInt(1, Integer.parseInt(id));
            int rows = ps2.executeUpdate();
            ps2.close();
            conn.close();

            if (rows > 0) {
%>
    <p class="message">✅ Company and its reviews deleted. Redirecting...</p>
    <script>setTimeout(() => window.location.href = 'manageCompanies.jsp', 2000);</script>
<%
            } else {
%>
    <p class="message">⚠️ Company not found.</p>
<%
            }
        } else {
%>
    <p class="message">❌ Invalid company ID.</p>
<%
        }
    } catch (Exception e) {
%>
    <p class="message">❌ Error: <%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
