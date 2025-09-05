package Servlet;

import Model.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String message = null;

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("message", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // Check if the email already exists
            PreparedStatement checkEmail = conn.prepareStatement("SELECT email FROM login.login WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet rs = checkEmail.executeQuery();

            if (rs.next()) {
                request.setAttribute("message", "This email is already registered!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Insert new user
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO login.login (name, email, password, user_type, company_id) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, "intern");
            ps.setNull(5, java.sql.Types.INTEGER);

            int rowsAffected = ps.executeUpdate();
            message = (rowsAffected > 0) ? "Registration successful!" : "Registration failed. Please try again.";

        } catch (SQLException e) {
            e.printStackTrace();
            message = "Database error: " + e.getMessage();
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
