<%@ page import="jakarta.servlet.http.*" %>
<%
    String userType = (String) session.getAttribute("userType");
    if (userType == null || !"admin".equals(userType)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #800000;
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 2em;
        }

        .dashboard-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        .card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            width: 300px;
            margin: 20px;
            padding: 30px;
            text-align: center;
            transition: 0.3s;
        }

        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .card a {
            display: block;
            text-decoration: none;
            color: #800000;
            font-size: 1.2em;
            font-weight: bold;
        }

        .cards-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
    </style>
</head>
<body>
    <header>
        Admin Dashboard
    </header>
    <div class="dashboard-container">
        <div class="cards-wrapper">
            <div class="card">
                <a href="manageCompanies.jsp">Manage Companies</a>
                <p>Add, edit, or delete companies listed on the platform.</p>
            </div>
            <div class="card">
                <a href="moderateReviews.jsp">Moderate Reviews</a>
                <p>Review and delete inappropriate reviews submitted by users.</p>
            </div>
            <div class="card">
                <a href="viewStats.jsp">View Platform Statistics</a>
                <p>See insights on applications, clicks, and more.</p>
            </div>
        </div>
    </div>
</body>
</html>
