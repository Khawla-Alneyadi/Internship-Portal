<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String id = request.getParameter("id");
    String company_name = "";
    String industry = "";
    String email = "";

    if (id != null) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM company WHERE company_id = ?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            company_name = rs.getString("company_name");
            industry = rs.getString("industry");
            email = rs.getString("email");
        }
        rs.close();
        ps.close();
        conn.close();
    }
%>
<html>
<head>
    <title>Edit Company</title>
    <style>
        body { font-family: sans-serif; background: #f5f5f5; margin: 0; }
        header { background: #800000; color: white; padding: 20px; text-align: center; font-size: 24px; }
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        label { display: block; margin-top: 20px; font-weight: bold; }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 25px;
            background-color: #800000;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 1em;
            cursor: pointer;
        }
    </style>
</head>
<body>
<header>Edit Company</header>
<div class="form-container">
    <form action="updateCompany.jsp" method="post">
        <input type="hidden" name="company_id" value="<%= id %>">
        <label>Company Name:</label>
        <input type="text" name="company_name" value="<%= company_name %>" required>

        <label>Industry:</label>
        <input type="text" name="industry" value="<%= industry %>" required>

        <label>Email:</label>
        <input type="email" name="email" value="<%= email %>" required>

        <button type="submit">Update Company</button>
    </form>
</div>
</body>
</html>
