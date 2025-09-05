<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("companyName") != null ? request.getAttribute("companyName") + " - Details" : "Company Details" %> - Internship Platform</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 70%;
            max-width: 960px;
        }

        h1 {
            color: #800000; /* Maroon */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.8em;
            font-weight: 500;
        }

        .company-details {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .company-details p {
            font-size: 1.1em;
            line-height: 1.8;
            color: #333;
            margin-bottom: 15px;
        }

        .company-details p strong {
            font-weight: bold;
            color: #555;
            margin-right: 5px;
        }

        .buttons {
            text-align: center;
            margin-top: 30px;
        }

        .buttons a {
            text-decoration: none;
            margin: 0 10px;
        }

        .buttons button {
            padding: 12px 24px;
            background-color: #800000; /* Maroon */
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.3s ease;
        }

        .buttons button:hover {
            background-color: #660000; /* Darker Maroon */
        }

        .error-message {
            color: #cc0000;
            text-align: center;
            margin-top: 20px;
            font-size: 1em;
        }
    </style>
</head>
<body>

    <div class="container">
        <%
            String companyId = request.getParameter("company_id");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String companyName = "";
            String companyDescription = "";
            String companyVision = "";

            try {
                conn = DBConnection.getConnection();
                String query = "SELECT company_name, description, vision FROM login.company WHERE company_id = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(companyId));
                rs = ps.executeQuery();

                if (rs.next()) {
                    companyName = rs.getString("company_name");
                    companyDescription = rs.getString("description");
                    companyVision = rs.getString("vision");
                    request.setAttribute("companyName", companyName); // Set attribute for title
                } else {
                    out.println("<p class='error-message'>Company not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error-message'>Error loading company details: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <h1><%= companyName %> - Company Details</h1>

        <div class="company-details">
            <p><strong>Company Name:</strong> <%= companyName %></p>
            <p><strong>Description:</strong> <%= companyDescription %></p>
            <p><strong>Vision:</strong> <%= companyVision %></p>
        </div>

        <div class="buttons">
            <a href="companyJobs.jsp?company_id=<%= companyId %>"><button>Company Job Listings</button></a>
            <a href="company.jsp?company_id=<%= companyId %>"><button>View Ratings</button></a>
        </div>
    </div>

</body>
</html>