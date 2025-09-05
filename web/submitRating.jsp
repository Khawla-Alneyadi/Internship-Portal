<%@ page import="java.sql.*, Model.DBConnection" %>
<%
    request.setCharacterEncoding("UTF-8");

    String companyId = request.getParameter("company_id");
    String userName = request.getParameter("user_name");
    String rating = request.getParameter("rating");
    String comment = request.getParameter("comment");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = DBConnection.getConnection();
        String query = "INSERT INTO login.rating (company_id, user_name, rating, comment, date_posted) VALUES (?, ?, ?, ?, NOW())";
        ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(companyId));
        ps.setString(2, userName);
        ps.setInt(3, Integer.parseInt(rating));
        ps.setString(4, comment);

        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("company.jsp?company_id=" + companyId + "&success=true");
        } else {
            response.sendRedirect("company.jsp?company_id=" + companyId + "&error=true");
        }
    } catch (SQLException e) {
        response.sendRedirect("company.jsp?company_id=" + companyId + "&error=" + e.getMessage());
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
