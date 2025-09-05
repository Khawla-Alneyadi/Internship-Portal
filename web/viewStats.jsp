<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Platform Statistics</title>
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
            font-size: 24px;
            text-align: center;
        }
        .back-button {
            margin: 20px 40px;
        }
        .back-button a {
            background-color: #800000;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            display: inline-block;
        }
        .stat-box {
            display: inline-block;
            background: white;
            margin: 30px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            font-size: 1.4em;
            color: #800000;
            width: 250px;
            text-align: center;
        }
        .centered-container {
            text-align: center;
        }
    </style>
</head>
<body>

<header>Platform Statistics</header>

<div class="back-button">
    <a href="admin.jsp">← Back to Dashboard</a>
</div>

<%
    Connection conn = DBConnection.getConnection();
    Statement st = conn.createStatement();

    ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM login");
    rs.next();
    int totalUsers = rs.getInt(1);

    rs = st.executeQuery("SELECT COUNT(*) FROM company");
    rs.next();
    int totalCompanies = rs.getInt(1);

    rs = st.executeQuery("SELECT COUNT(*) FROM rating");
    rs.next();
    int totalReviews = rs.getInt(1);

    rs.close();
    st.close();
    conn.close();
%>

<div class="centered-container">
    <div class="stat-box">Total Users: <%= totalUsers %></div>
    <div class="stat-box">Total Companies: <%= totalCompanies %></div>
    <div class="stat-box">Total Reviews: <%= totalReviews %></div>
</div>

</body>
</html>
