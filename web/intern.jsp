<%@ page import="java.sql.*, Model.DBConnection" %>

<%
    String searchQuery = request.getParameter("search");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    StringBuilder results = new StringBuilder();

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        try {
            conn = DBConnection.getConnection();
            String query = "SELECT * FROM login.company WHERE company_name LIKE ? OR industry LIKE ? LIMIT 5";

            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + searchQuery + "%");
            ps.setString(2, "%" + searchQuery + "%");

            rs = ps.executeQuery();

            while (rs.next()) {
                int companyId = rs.getInt("company_id");
                String companyName = rs.getString("company_name");
                String industry = rs.getString("industry");

                results.append("<div class='result-item' onclick='redirectToCompany(").append(companyId).append(")'>");
                results.append("<strong>").append(companyName).append("</strong>");
                results.append("<p>").append(industry).append("</p>");
                results.append("</div>");
            }

            if (results.length() == 0) {
                results.append("<div class='result-item no-results'>No matches found</div>");
            }

        } catch (SQLException e) {
            results.append("<div class='error'>Error retrieving companies: ").append(e.getMessage()).append("</div>");
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

    // Print search results when request comes from AJAX
    if (searchQuery != null) {
        out.print(results.toString());
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Search - Internship Platform</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* Align items to the top */
            align-items: center;
            min-height: 100vh;
            background-color: #f9f9f9;
            padding: 40px 0; /* Add some top and bottom padding */
        }

        .title {
            color: #800000; /* Maroon */
            font-size: 2.5em;
            margin-bottom: 30px;
            font-weight: 500;
        }

        .search-container {
            position: relative;
            width: 400px; /* Increased width for better readability */
            margin-bottom: 30px;
        }

        #search {
            width: calc(100% - 22px);
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            box-sizing: border-box;
            outline: none;
            transition: border-color 0.3s ease;
        }

        #search:focus {
            border-color: #800000; /* Maroon on focus */
            box-shadow: 0 0 8px rgba(128, 0, 0, 0.2); /* Subtle focus shadow */
        }

        .results-box {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-top: none;
            border-radius: 0 0 8px 8px;
            max-height: 250px;
            overflow-y: auto;
            display: none;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .result-item {
            padding: 15px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s ease;
            text-align: left;
        }

        .result-item:last-child {
            border-bottom: none;
        }

        .result-item:hover {
            background-color: #f8f8f8;
        }

        .result-item strong {
            color: #333;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .result-item p {
            color: #666;
            font-size: 0.9em;
            margin: 0;
        }

        .no-results {
            color: #777;
            text-align: center;
            padding: 15px;
        }

        .error {
            color: #cc0000; /* Darker Red */
            text-align: center;
            padding: 15px;
            background-color: #ffe0e0; /* Light red background for error */
            border: 1px solid #cc0000;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="title">Find Internship Companies</div>

    <div class="search-container">
        <input type="text" id="search" placeholder="Enter company name or industry" onkeyup="searchCompanies()" onfocus="showResults()" onblur="hideResults()">
        <div class="results-box" id="results">
            <%= results.toString() %>
        </div>
    </div>

    <script>
        function searchCompanies() {
            var searchQuery = document.getElementById("search").value;
            var resultsBox = document.getElementById("results");

            if (searchQuery.trim() === "") {
                resultsBox.style.display = "none";
                resultsBox.innerHTML = ""; // Clear previous results
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open("GET", "intern.jsp?search=" + encodeURIComponent(searchQuery), true);

            xhr.onload = function() {
                if (xhr.status == 200) {
                    resultsBox.innerHTML = xhr.responseText;
                    resultsBox.style.display = "block";
                } else {
                    resultsBox.innerHTML = "<div class='error'>Error loading results.</div>";
                    resultsBox.style.display = "block";
                }
            };
            xhr.onerror = function() {
                resultsBox.innerHTML = "<div class='error'>Network error. Please try again.</div>";
                resultsBox.style.display = "block";
            };
            xhr.send();
        }

        function showResults() {
            var resultsBox = document.getElementById("results");
            if (resultsBox.innerHTML.trim() !== "") {
                resultsBox.style.display = "block";
            }
        }

        function hideResults() {
            setTimeout(() => {
                document.getElementById("results").style.display = "none";
            }, 200);
        }

        function redirectToCompany(companyId) {
            window.location.href = "company.jsp?company_id=" + companyId;
        }

        // Show any initial results if the page was loaded with a search query
        document.addEventListener('DOMContentLoaded', function() {
            if (document.getElementById("search").value.trim() !== "") {
                document.getElementById("results").style.display = "block";
            }
        });
    </script>

</body>
</html>