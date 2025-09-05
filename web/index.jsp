<%@ page import="java.sql.*, Model.DBConnection, jakarta.servlet.http.*, jakarta.servlet.*, java.io.*" %>
<%
    String message = null;
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            // 1. Check if this is an admin
            String adminQuery = "SELECT * FROM admin WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(adminQuery);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("email", email);
                session.setAttribute("userType", "admin");
                response.sendRedirect("admin.jsp");
                return;
            }

            rs.close();
            ps.close();

            // 2. Check if it's an intern or company
            String userQuery = "SELECT user_type FROM login WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(userQuery);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                String userType = rs.getString("user_type");

                session.setAttribute("email", email);
                session.setAttribute("userType", userType);

                if ("intern".equals(userType)) {
                    response.sendRedirect("intern.jsp");
                } else if ("company".equals(userType)) {
                    response.sendRedirect("company.jsp");
                } else {
                    message = "You are not authorized to access this page.";
                }
            } else {
                message = "Invalid credentials. Please try again.";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            message = "Database error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Internship Platform</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .login-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #800000;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 500;
        }

        .error-message {
            color: #cc0000;
            margin-bottom: 20px;
            font-size: 0.9em;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        input[type="email"],
        input[type="password"] {
            width: calc(100% - 22px);
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
            box-sizing: border-box;
            margin-bottom: 15px;
        }

        button[type="submit"] {
            background-color: #800000;
            color: white;
            padding: 14px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button[type="submit"]:hover {
            background-color: #660000;
        }

        .signup-link {
            margin-top: 25px;
            font-size: 0.95em;
            color: #555;
        }

        .signup-link a {
            color: #800000;
            text-decoration: none;
            font-weight: bold;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>

        <p class="error-message">
            <%= message != null ? message : "" %>
        </p>

        <form method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <button type="submit">Login</button>
        </form>

        <p class="signup-link">Don't have an account? <a href="register.jsp">Create Account</a></p>
    </div>
</body>
</html>
