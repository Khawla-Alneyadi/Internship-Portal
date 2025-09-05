<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Details - Internship Platform</title>
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
            color: #800000;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.8em;
            font-weight: 500;
        }

        h2 {
            color: #800000;
            margin-top: 30px;
            margin-bottom: 15px;
            font-size: 2em;
            font-weight: 500;
        }

        .buttons {
            text-align: center;
            margin-bottom: 30px;
        }

        .buttons.left {
            text-align: left;
            margin-bottom: 20px;
        }

        .buttons a {
            text-decoration: none;
        }

        .buttons button {
            padding: 12px 24px;
            margin: 10px;
            background-color: #800000;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.3s ease;
        }

        .buttons button:hover {
            background-color: #660000;
        }

        .rating-stars {
            display: flex;
            justify-content: center;
            gap: 8px;
            font-size: 30px;
            cursor: pointer;
            color: #ddd;
            direction: ltr;
            margin-bottom: 15px;
        }

        .rating-stars span {
            unicode-bidi: bidi-isolate;
            transition: color 0.2s ease;
        }

        .rating-stars span.hovered,
        .rating-stars span.selected {
            color: gold;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
            font-size: 1em;
        }

        textarea,
        input[type="text"],
        input[type="hidden"] {
            width: calc(100% - 22px);
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            box-sizing: border-box;
            outline: none;
            transition: border-color 0.3s ease;
        }

        textarea:focus,
        input[type="text"]:focus {
            border-color: #800000;
            box-shadow: 0 0 8px rgba(128, 0, 0, 0.2);
        }

        .rating-box {
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            border-left: 6px solid #800000;
        }

        .rating-box strong {
            color: #333;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .rating-box p {
            color: #555;
            margin-bottom: 8px;
            font-size: 0.95em;
            line-height: 1.6;
        }

        .rating-box p:last-child {
            margin-bottom: 0;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="buttons left">
            <a href="intern.jsp">
                <button>← Back to Search</button>
            </a>
        </div>

        <%
            String companyId = request.getParameter("company_id");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String companyName = "";

            try {
                conn = DBConnection.getConnection();
                String query = "SELECT company_name FROM login.company WHERE company_id = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(companyId));
                rs = ps.executeQuery();

                if (rs.next()) {
                    companyName = rs.getString("company_name");
                } else {
                    out.println("<p class='error-message' style='color: #cc0000; text-align: center;'>Company not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error-message' style='color: #cc0000; text-align: center;'>Error loading company details: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>

        <h1><%= companyName %></h1>

        <div class="buttons">
                        <a href="companyJobs.jsp?company_id=<%= companyId %>">
                <button>Company Job Listings</button>
            </a>
                        <a href="companyDetails.jsp?company_id=<%= companyId %>">
                <button>Company Details</button>
            </a>

        </div>

        <h2>Submit Your Rating</h2>
        <form action="submitRating.jsp" method="POST">
            <input type="hidden" name="company_id" value="<%= companyId %>">
            <label for="user_name">Your Name:</label>
            <input type="text" id="user_name" name="user_name" placeholder="Enter your name" required><br>

            <label for="rating">Rating:</label>
            <div class="rating-stars" onmouseleave="resetHover()">
                <span data-value="1" onmouseover="handleHover(this)" onclick="setRating(this)">★</span>
                <span data-value="2" onmouseover="handleHover(this)" onclick="setRating(this)">★</span>
                <span data-value="3" onmouseover="handleHover(this)" onclick="setRating(this)">★</span>
                <span data-value="4" onmouseover="handleHover(this)" onclick="setRating(this)">★</span>
                <span data-value="5" onmouseover="handleHover(this)" onclick="setRating(this)">★</span>
            </div>
            <input type="hidden" name="rating" id="ratingInput">
            <label for="comment">Comment:</label>
            <textarea id="comment" name="comment" rows="5" placeholder="Share your experience" required></textarea><br>

            <button type="submit">Submit Rating</button>
        </form>

        <h2>Ratings</h2>
        <div id="ratings">
            <%
                Connection conn2 = null;
                PreparedStatement ps2 = null;
                ResultSet rs2 = null;

                try {
                    conn2 = DBConnection.getConnection();
                    String ratingQuery = "SELECT user_name, rating, comment, DATE_FORMAT(date_posted, '%Y-%m-%d') AS date_posted FROM login.rating WHERE company_id = ? ORDER BY date_posted DESC";
                    ps2 = conn2.prepareStatement(ratingQuery);
                    ps2.setInt(1, Integer.parseInt(companyId));
                    rs2 = ps2.executeQuery();

                    while (rs2.next()) {
                        String userName = rs2.getString("user_name");
                        int ratingValue = rs2.getInt("rating");
                        String comment = rs2.getString("comment");
                        String datePosted = rs2.getString("date_posted");

                        out.println("<div class='rating-box'>");
                        out.println("<p><strong>" + userName + "</strong> (" + datePosted + ")</p>");
                        out.println("<p>Rating: ");
                        for (int i = 0; i < ratingValue; i++) {
                            out.println("&#9733;");
                        }
                        out.println("</p>");
                        out.println("<p>" + comment + "</p>");
                        out.println("</div>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error-message' style='color: #cc0000;'>Error loading ratings: " + e.getMessage() + "</p>");
                } finally {
                    if (rs2 != null) rs2.close();
                    if (ps2 != null) ps2.close();
                    if (conn2 != null) conn2.close();
                }
            %>
        </div>
    </div>

    <script>
        let currentRating = 0;

        function handleHover(star) {
            const value = parseInt(star.getAttribute('data-value'));
            const stars = document.querySelectorAll(".rating-stars span");
            stars.forEach(s => s.classList.remove("hovered"));
            for (let i = 0; i < value; i++) {
                stars[i].classList.add("hovered");
            }
        }

        function resetHover() {
            const stars = document.querySelectorAll(".rating-stars span");
            stars.forEach(s => s.classList.remove("hovered"));
            for (let i = 0; i < currentRating; i++) {
                stars[i].classList.add("selected");
            }
        }

        function setRating(star) {
            const value = parseInt(star.getAttribute('data-value'));
            document.getElementById("ratingInput").value = value;
            currentRating = value;
            const stars = document.querySelectorAll(".rating-stars span");
            stars.forEach(s => s.classList.remove("selected", "hovered"));
            for (let i = 0; i < value; i++) {
                stars[i].classList.add("selected");
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            const ratingInput = document.getElementById('ratingInput');
            if (ratingInput.value) {
                currentRating = parseInt(ratingInput.value);
                const stars = document.querySelectorAll(".rating-stars span");
                stars.forEach(s => s.classList.remove("selected"));
                for (let i = 0; i < currentRating; i++) {
                    stars[i].classList.add("selected");
                }
            }
        });
    </script>

</body>
</html>
