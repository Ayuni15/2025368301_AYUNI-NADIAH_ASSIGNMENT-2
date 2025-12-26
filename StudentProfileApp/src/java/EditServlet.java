import model.ProfileBean;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_profiles";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("viewProfiles.jsp?error=No profile selected");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT * FROM profile WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("student_id"));
                profile.setProgram(rs.getString("program"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntroduction(rs.getString("introduction"));
                
                request.setAttribute("profile", profile);
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect("viewProfiles.jsp?error=Profile not found");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewProfiles.jsp?error=Error loading profile");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String[] hobbiesArray = request.getParameterValues("hobbies");
        String introduction = request.getParameter("introduction");
        
        String hobbies = "";
        if (hobbiesArray != null) {
            for (int i = 0; i < hobbiesArray.length; i++) {
                if (i > 0) hobbies += ",";
                hobbies += hobbiesArray[i];
            }
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String checkSql = "SELECT COUNT(*) FROM profile WHERE student_id = ? AND id != ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, studentId);
            checkStmt.setInt(2, Integer.parseInt(id));
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                response.sendRedirect("editProfile.jsp?id=" + id + "&error=Student+ID+already+exists");
                return;
            }
            
            String sql = "UPDATE profile SET name=?, student_id=?, program=?, email=?, hobbies=?, introduction=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, studentId);
            pstmt.setString(3, program);
            pstmt.setString(4, email);
            pstmt.setString(5, hobbies);
            pstmt.setString(6, introduction);
            pstmt.setInt(7, Integer.parseInt(id));
            
            int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                response.sendRedirect("viewProfiles.jsp?success=Profile updated successfully");
            } else {
                response.sendRedirect("viewProfiles.jsp?error=Update failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editProfile.jsp?id=" + id + "&error=Error+updating+profile");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}