import model.ProfileBean;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_profiles";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id != null && !id.trim().isEmpty()) {
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
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                } else {
                    response.sendRedirect("viewProfiles.jsp?error=Profile+not+found");
                }
                
            } catch (Exception e) {
                response.sendRedirect("viewProfiles.jsp?error=Error+loading+profile");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("viewProfiles.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
            
            String sql = "INSERT INTO profile (name, student_id, program, email, hobbies, introduction) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, studentId);
            pstmt.setString(3, program);
            pstmt.setString(4, email);
            pstmt.setString(5, hobbies);
            pstmt.setString(6, introduction);
            
            pstmt.executeUpdate();
            
            ProfileBean profile = new ProfileBean(name, studentId, program, email, hobbies, introduction);
            request.setAttribute("profile", profile);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        } catch (SQLException e) {
            String errorMessage;
            
            if (e.getMessage() != null && e.getMessage().contains("Duplicate")) {
                errorMessage = "Student ID '" + studentId + "' already exists!";
            } else {
                errorMessage = "Database error: " + e.getMessage();
            }
            
            response.sendRedirect("index.html?error=" + errorMessage.replace(" ", "%20"));
            e.printStackTrace();
            
        } catch (Exception e) {
            response.sendRedirect("index.html?error=Error: " + e.getMessage().replace(" ", "%20"));
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