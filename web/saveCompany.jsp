<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Saving Company...</title>
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

<header>Add Company</header>

<%
    String name = request.getParameter("company_name");
    String industry = request.getParameter("industry");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String description = request.getParameter("description");

    boolean success = false;

    if (name != null && industry != null && email != null && password != null && description != null) {
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO company (company_name, industry, email, password, description) VALUES (?, ?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setString(2, industry);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, description);

            int rows = ps.executeUpdate();
            ps.close();
            conn.close();

            if (rows > 0) {
                success = true;
            }

        } catch (Exception e) {
%>
    <p class="message">❌ Error: <%= e.getMessage() %></p>
<%
        }
    }

    if (success) {
%>
    <p class="message">✅ Company added successfully. Redirecting to Manage Companies...</p>
    <script>setTimeout(() => window.location.href = 'manageCompanies.jsp', 2000);</script>
<%
    } else if (name == null || industry == null || email == null || password == null || description == null) {
%>
    <p class="message">❌ Please fill in all required fields.</p>
    <a href="addCompany.jsp" style="color: #800000; font-weight: bold;">← Go Back</a>
<%
    }
%>

</body>
</html>
