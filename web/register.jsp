<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - Internship Platform</title>
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

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #800000; /* Maroon */
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 500;
        }

        .error-message {
            color: #cc0000; /* Darker Red */
            margin-bottom: 20px;
            font-size: 0.9em;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"],
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
            background-color: #800000; /* Maroon */
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
            background-color: #660000; /* Darker Maroon */
        }

        .login-link {
            margin-top: 25px;
            font-size: 0.95em;
            color: #555;
        }

        .login-link a {
            color: #800000; /* Maroon */
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>

<%
    String message = (String) request.getAttribute("message");
    boolean isSuccess = message != null && message.toLowerCase().contains("successful");
%>
<% if (message != null) { %>
    <p style="color: <%= isSuccess ? "#006400" : "#cc0000" %>; font-size: 0.9em; margin-bottom: 20px;">
        <%= message %>
    </p>
<% } %>

        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm your password" required>
            </div>
            <button type="submit">Register</button>
        </form>

        <p class="login-link">Already have an account? <a href="index.jsp">Login</a></p>
    </div>
</body>
</html>