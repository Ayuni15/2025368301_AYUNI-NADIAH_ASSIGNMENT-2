import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_profiles";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("viewProfiles.jsp?error=No profile selected for deletion");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "DELETE FROM profile WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            
            int rowsDeleted = pstmt.executeUpdate();
            
            if (rowsDeleted > 0) {
                System.out.println("Profile with ID " + id + " deleted successfully");
                response.sendRedirect("viewProfiles.jsp?success=Profile deleted successfully");
            } else {
                response.sendRedirect("viewProfiles.jsp?error=Profile not found");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("viewProfiles.jsp?error=Invalid profile ID");
        } catch (ClassNotFoundException e) {
            response.sendRedirect("viewProfiles.jsp?error=Database driver error");
            e.printStackTrace();
        } catch (SQLException e) {
            response.sendRedirect("viewProfiles.jsp?error=Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}