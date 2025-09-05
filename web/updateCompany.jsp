<%@ page import="java.sql.*, Model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String id = request.getParameter("company_id");
    String name = request.getParameter("company_name");
    String industry = request.getParameter("industry");
    String email = request.getParameter("email");
    if (id != null && name != null && industry != null && email != null) {
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("UPDATE company SET company_name=?, industry=?, email=? WHERE company_id=?");
            ps.setString(1, name);
            ps.setString(2, industry);
            ps.setString(3, email);
            ps.setInt(4, Integer.parseInt(id));
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
    response.sendRedirect("manageCompanies.jsp");
%>
