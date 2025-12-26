<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProfileBean, java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <meta charset="UTF-8">
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
            max-width: 600px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            backdrop-filter: blur(5px);
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
        }
        
        .home-btn {
            display: inline-block;
            color: #3498db;
            text-decoration: none;
            margin-bottom: 15px;
            font-weight: bold;
        }
        
        .home-btn:hover {
            text-decoration: underline;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #34495e;
        }
        
        input[type="text"], 
        input[type="email"], 
        select, 
        textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #bdc3c7;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        input[type="text"]:focus, 
        input[type="email"]:focus, 
        select:focus, 
        textarea:focus {
            border-color: #3498db;
            outline: none;
        }
        
        textarea {
            height: 120px;
            resize: vertical;
        }
        
        .hobbies {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }
        
        .hobby-item {
            display: flex;
            align-items: center;
        }
        
        .hobby-item input[type="checkbox"] {
            margin-right: 8px;
        }
        
        .submit-btn {
            background: #f39c12;
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 50px;
            font-size: 1.2em;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(243, 156, 18, 0.4);
        }
        
        .submit-btn:hover {
            background: #e67e22;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(243, 156, 18, 0.6);
        }
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .error {
            background: #ffeaa7;
            color: #d63031;
            border-left: 4px solid #fdcb6e;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="viewProfiles.jsp" class="home-btn">&#8592; Back to Profiles</a>
        
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="message error">
                &#9888; <%= error.replace("+", " ") %>
            </div>
        <%
            }
        %>
        
        <h1>&#128221; Edit Profile</h1>
        
        <%
            
            ProfileBean profile = (ProfileBean) request.getAttribute("profile");
            
            if (profile == null) {
                
                String id = request.getParameter("id");
                if (id != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/student_profiles", "root", "");
                        
                        String sql = "SELECT * FROM profile WHERE id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, Integer.parseInt(id));
                        ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            profile = new ProfileBean();
                            profile.setId(rs.getInt("id"));
                            profile.setName(rs.getString("name"));
                            profile.setStudentId(rs.getString("student_id"));
                            profile.setProgram(rs.getString("program"));
                            profile.setEmail(rs.getString("email"));
                            profile.setHobbies(rs.getString("hobbies"));
                            profile.setIntroduction(rs.getString("introduction"));
                        }
                        
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
            
            if (profile == null) {
                out.println("<p>Profile not found.</p>");
                out.println("<a href='viewProfiles.jsp'>Back to Profiles</a>");
                return;
            }
            
            
            String hobbiesStr = profile.getHobbies();
            boolean[] hobbyChecked = new boolean[6];
            String[] hobbyValues = {"Reading", "Gaming", "Sports", "Coding", "Music", "Travel"};
            
            if (hobbiesStr != null) {
                String[] selectedHobbies = hobbiesStr.split(",");
                for (String hobby : selectedHobbies) {
                    hobby = hobby.trim();
                    for (int i = 0; i < hobbyValues.length; i++) {
                        if (hobby.equals(hobbyValues[i])) {
                            hobbyChecked[i] = true;
                            break;
                        }
                    }
                }
            }
        %>
        
        
        <form action="EditServlet" method="POST">
            <input type="hidden" name="id" value="<%= profile.getId() %>">
            
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value="<%= profile.getName() %>" required>
            </div>
            
            <div class="form-group">
                <label for="studentId">Student ID:</label>
                <input type="text" id="studentId" name="studentId" value="<%= profile.getStudentId() %>" required>
            </div>
            
            <div class="form-group">
                <label for="program">Program:</label>
                <select id="program" name="program" required>
                    <option value="">Select Program</option>
                    <option value="BSc Computer Science" <%= profile.getProgram().equals("BSc Computer Science") ? "selected" : "" %>>BSc Computer Science</option>
                    <option value="BSc Information Technology" <%= profile.getProgram().equals("BSc Information Technology") ? "selected" : "" %>>BSc Information Technology</option>
                    <option value="BSc Data Science" <%= profile.getProgram().equals("BSc Data Science") ? "selected" : "" %>>BSc Data Science</option>
                    <option value="BSc Necentric Computing" <%= profile.getProgram().equals("BSc Necentric Computing") ? "selected" : "" %>>BSc Necentric Computing</option>
                    <option value="BSc Intelligent System Engineering" <%= profile.getProgram().equals("BSc Intelligent System Engineering") ? "selected" : "" %>>BSc Intelligent System Engineering</option>
                    <option value="BSc Networking" <%= profile.getProgram().equals("BSc Networking") ? "selected" : "" %>>BSc Networking</option>
                    <option value="BSc Information System Engineering" <%= profile.getProgram().equals("BSc Information System Engineering") ? "selected" : "" %>>BSc Information System Engineering</option>
                    <option value="BSc Software Engineering" <%= profile.getProgram().equals("BSc Software Engineering") ? "selected" : "" %>>BSc Software Engineering</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= profile.getEmail() %>" required>
            </div>
            
            <div class="form-group">
                <label>Hobbies:</label>
                <div class="hobbies">
                    <div class="hobby-item">
                        <input type="checkbox" id="reading" name="hobbies" value="Reading" <%= hobbyChecked[0] ? "checked" : "" %>>
                        <label for="reading">&#128218; Reading</label>
                    </div>
                    <div class="hobby-item">
                        <input type="checkbox" id="gaming" name="hobbies" value="Gaming" <%= hobbyChecked[1] ? "checked" : "" %>>
                        <label for="gaming">&#127918; Gaming</label>
                    </div>
                    <div class="hobby-item">
                        <input type="checkbox" id="sports" name="hobbies" value="Sports" <%= hobbyChecked[2] ? "checked" : "" %>>
                        <label for="sports">&#9917; Sports</label>
                    </div>
                    <div class="hobby-item">
                        <input type="checkbox" id="coding" name="hobbies" value="Coding" <%= hobbyChecked[3] ? "checked" : "" %>>
                        <label for="coding">&#128187; Coding</label>
                    </div>
                    <div class="hobby-item">
                        <input type="checkbox" id="music" name="hobbies" value="Music" <%= hobbyChecked[4] ? "checked" : "" %>>
                        <label for="music">&#127925; Music</label>
                    </div>
                    <div class="hobby-item">
                        <input type="checkbox" id="travel" name="hobbies" value="Travel" <%= hobbyChecked[5] ? "checked" : "" %>>
                        <label for="travel">&#9992; Travel</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="introduction">About Me:</label>
                <textarea id="introduction" name="introduction" rows="5" required><%= profile.getIntroduction() %></textarea>
            </div>
            
            <button type="submit" class="submit-btn">
                &#128190; Update Profile
            </button>
        </form>
    </div>
</body>
</html>