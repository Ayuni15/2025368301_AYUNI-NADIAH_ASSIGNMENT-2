<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*" %>
<%@page import="model.ProfileBean" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>All Student Profiles</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95); 
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
            height: 90vh; 
            backdrop-filter: blur(5px); 
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            flex-shrink: 0; 
        }
        
        .search-box {
            background: #e8f4fc;
            padding: 20px;
            border-radius: 10px;
            margin: 0 0 25px 0;
            text-align: center;
            border: 2px solid #3498db;
            flex-shrink: 0; 
        }
        
        .search-input {
            padding: 12px;
            width: 350px;
            border-radius: 8px;
            border: 2px solid #3498db;
            font-size: 16px;
            margin-right: 10px;
        }
        
        .search-btn {
            padding: 12px 25px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .search-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .profiles-container {
            flex: 1; 
            overflow-y: auto; 
            padding-right: 10px; 
            margin-bottom: 20px;
        }
        
        .profile-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            border-left: 5px solid #3498db;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }
        
        .profile-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        
        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eaeaea;
        }
        
        .profile-name {
            font-size: 1.8em;
            color: #2c3e50;
            margin: 0;
        }
        
        .student-id {
            background: #34495e;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9em;
        }
        
        .profile-info {
            margin-bottom: 15px;
        }
        
        .info-label {
            font-weight: bold;
            color: #7f8c8d;
            display: inline-block;
            width: 120px;
        }
        
        .hobby-tag {
            background: #9b59b6;
            color: white;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.85em;
            margin-right: 8px;
            margin-bottom: 8px;
            display: inline-block;
        }
        
        .introduction-box {
            background: #ecf0f1;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            border-left: 4px solid #27ae60;
            font-style: italic;
            line-height: 1.6;
        }
        
        .timestamp {
            text-align: right;
            font-size: 0.85em;
            color: #95a5a6;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px dashed #ddd;
        }
        
        /* ACTION BUTTONS */
        .action-buttons {
            text-align: right;
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .view-btn {
            background: #3498db;
            color: white;
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 0.95em;
        }
        
        .view-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .edit-btn {
            background: #f39c12;
            color: white;
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 0.95em;
        }
        
        .edit-btn:hover {
            background: #e67e22;
            transform: translateY(-2px);
        }
        
        .delete-btn {
            background: #e74c3c;
            color: white;
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 0.95em;
        }
        
        .delete-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin: 10px 5px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        
        .btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .message {
            padding: 15px;
            border-radius: 10px;
            margin: 15px 0;
            text-align: center;
            font-weight: bold;
            flex-shrink: 0;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            border: 2px solid #c3e6cb;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 2px solid #f5c6cb;
        }
        
        .no-profiles {
            text-align: center;
            padding: 50px;
            color: #7f8c8d;
            font-size: 1.2em;
        }
        
        .actions {
            text-align: center;
            padding-top: 20px;
            border-top: 2px solid #eaeaea;
            flex-shrink: 0; 
        }
        
        .profiles-container::-webkit-scrollbar {
            width: 10px;
        }
        
        .profiles-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 5px;
        }
        
        .profiles-container::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 5px;
        }
        
        .profiles-container::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>&#128101; All Student Profiles</h1>
        
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
        %>
            <div class="message success">&#10004; <%= success %></div>
        <%
            }
            if (error != null) {
        %>
            <div class="message error">&#10060; <%= error %></div>
        <%
            }
        %>
        
        <div class="search-box">
            <h3 style="margin-top: 0; color: #2c3e50;">&#128269; Search Profiles</h3>
            <form action="viewProfiles.jsp" method="GET">
                <input type="text" name="search" class="search-input" 
                       placeholder="Search by name or student ID..." 
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit" class="search-btn">Search</button>
                <% if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) { %>
                    <a href="viewProfiles.jsp" style="margin-left: 15px; color: #e74c3c; font-weight: bold;">Clear Search</a>
                <% } %>
            </form>
        </div>
        
        <div class="profiles-container">
        <%
            String url = "jdbc:mysql://localhost:3306/student_profiles";
            String user = "root";
            String pass = "";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);
                
                String search = request.getParameter("search");
                String sql;
                
                if (search != null && !search.trim().isEmpty()) {
                    sql = "SELECT * FROM profile WHERE name LIKE ? OR student_id LIKE ? ORDER BY id DESC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%" + search + "%");
                    pstmt.setString(2, "%" + search + "%");
                } else {
                    sql = "SELECT * FROM profile ORDER BY id DESC";
                    pstmt = conn.prepareStatement(sql);
                }
                
                rs = pstmt.executeQuery();
                
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    
                    String hobbiesStr = rs.getString("hobbies");
                    String[] hobbiesArray = null;
                    if (hobbiesStr != null && !hobbiesStr.isEmpty()) {
                        hobbiesArray = hobbiesStr.split(",");
                    }
        %>
                    <div class="profile-card">
                        <div class="profile-header">
                            <h2 class="profile-name"><%= rs.getString("name") %></h2>
                            <div class="student-id">ID: <%= rs.getString("student_id") %></div>
                        </div>
                        
                        <div class="profile-info">
                            <span class="info-label">&#127891; Program:</span>
                            <%= rs.getString("program") %>
                        </div>
                        
                        <div class="profile-info">
                            <span class="info-label">&#128231; Email:</span>
                            <%= rs.getString("email") %>
                        </div>
                        
                        <div class="profile-info">
                            <span class="info-label">&#127919; Hobbies:</span>
                            <br>
                            <% 
                                if (hobbiesArray != null) {
                                    for (String hobby : hobbiesArray) {
                                        if (!hobby.trim().isEmpty()) {
                            %>
                                        <span class="hobby-tag"><%= hobby.trim() %></span>
                            <%
                                        }
                                    }
                                } else {
                            %>
                                <em>No hobbies listed</em>
                            <% } %>
                        </div>
                        
                        <div class="profile-info">
                            <span class="info-label">&#128221; About:</span>
                            <div class="introduction-box">
                                <%= rs.getString("introduction") %>
                            </div>
                        </div>
                        
                        <div class="timestamp">
                            Created: <%= rs.getTimestamp("created_at") %>
                        </div>
                        
                        <!-- ACTION BUTTONS - ADDED VIEW BUTTON -->
                        <div class="action-buttons">
                            <!-- VIEW BUTTON -->
                            <!-- Change View button to use ProfileServlet -->
                            <a href="ProfileServlet?id=<%= rs.getInt("id") %>" class="view-btn">
                                &#128065; View
                            </a>
                            
                            <!-- EDIT BUTTON -->
                            <a href="EditServlet?id=<%= rs.getInt("id") %>" class="edit-btn">
                                &#128221; Edit
                            </a>
                            
                            <!-- DELETE BUTTON -->
                            <a href="DeleteServlet?id=<%= rs.getInt("id") %>" class="delete-btn"
                               onclick="return confirm('Are you sure you want to delete <%= rs.getString("name") %>?')">
                                &#128465; Delete
                            </a>
                        </div>
                    </div>
        <%
                }
                
                if (!hasData) {
                    if (search != null && !search.trim().isEmpty()) {
        %>
                        <div class="no-profiles">
                            <h3>&#128269; No Results Found</h3>
                            <p>No profiles found for "<%= search %>"</p>
                            <a href="viewProfiles.jsp" class="btn">View All Profiles</a>
                        </div>
        <%
                    } else {
        %>
                        <div class="no-profiles">
                            <h3>&#128229; No Profiles Found</h3>
                            <p>No student profiles have been created yet.</p>
                            <a href="index.html" class="btn">&#10133; Create First Profile</a>
                        </div>
        <%
                    }
                }
                
            } catch (Exception e) {
        %>
                <div class="message error">
                    &#10060; Error loading profiles: <%= e.getMessage() %>
                </div>
        <%
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
        </div> 
        
        <div class="actions">
            <a href="index.html" class="btn">&#10133; Create New Profile</a>
            <a href="welcome.html" class="btn" style="background: #7f8c8d;">&#127968; Back to Home</a>
        </div>
    </div>
    
    <script>
        function confirmDelete(name) {
            return confirm("Are you sure you want to delete " + name + "?");
        }
    </script>
</body>
</html>