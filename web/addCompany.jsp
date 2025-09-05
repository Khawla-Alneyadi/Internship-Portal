<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Company</title>
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
            text-align: center;
            font-size: 24px;
        }
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"] {
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

<header>Add Company</header>

<div class="form-container">
    <form action="saveCompany.jsp" method="post">
        <label>Company Name:</label>
        <input type="text" name="company_name" required>

        <label>Industry:</label>
        <input type="text" name="industry" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="text" name="password" required>

        <label>Description:</label>
        <input type="text" name="description" required>

        <button type="submit">Add Company</button>
    </form>
</div>

</body>
</html>
