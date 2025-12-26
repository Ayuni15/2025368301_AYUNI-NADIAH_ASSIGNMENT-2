<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${profile.name} - Student Profile</title>
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
        
        .profile-container {
            max-width: 800px;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px; 
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            overflow: hidden;
            backdrop-filter: blur(5px);
        }
        
        .profile-header {
            background: #3498db; 
            color: white;
            padding: 30px;
            text-align: center;
            border-radius: 20px 20px 0 0; 
        }
        
        .profile-header h1 {
            margin: 0;
            font-size: 2.5em;
        }
        
        .profile-header .subtitle {
            font-size: 1.2em;
            opacity: 0.8;
            margin-top: 10px;
        }
        
        .profile-content {
            padding: 40px; 
        }
        
        .info-section {
            margin-bottom: 30px; 
        }
        
        .info-section h3 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 8px;
            margin-bottom: 15px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 12px;
            margin-bottom: 12px;
        }
        
        .info-label {
            font-weight: bold;
            color: #34495e;
        }
        
        .hobby-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .hobby-tag {
            background: #9b59b6;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
        }
        
        .introduction-box {
            background: #ecf0f1;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #3498db;
            line-height: 1.6;
        }
        
        .actions {
            text-align: center;
            margin-top: 40px; 
            padding: 30px;
            border-top: 1px solid #bdc3c7;
            background: #f8f9fa;
            border-radius: 0 0 20px 20px; 
        }
        
        .btn {
            padding: 12px 25px;
            margin: 0 15px; 
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
        }
        
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(52, 152, 219, 0.4);
        }
        
        .btn-secondary {
            background: #27ae60; 
            color: white;
            box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
        }
        
        .btn-secondary:hover {
            background: #219653;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(39, 174, 96, 0.4);
        }
        
        .btn-view {
            background: #f39c12;
            color: white;
            box-shadow: 0 4px 8px rgba(243, 156, 18, 0.3);
        }
        
        .btn-view:hover {
            background: #e67e22;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(243, 156, 18, 0.4);
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h1>${profile.name}</h1>
            <div class="subtitle">
                <c:choose>
                    <c:when test="${not empty param.id}">
                        &#128065; Viewing Student Profile
                    </c:when>
                    <c:otherwise>
                        &#10004; Profile Saved Successfully!
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="profile-content">
            <div class="info-section">
                <h3>&#128203; Personal Information</h3>
                <div class="info-grid">
                    <div class="info-label">Student ID:</div>
                    <div>${profile.studentId}</div>
                    
                    <div class="info-label">Program:</div>
                    <div>${profile.program}</div>
                    
                    <div class="info-label">Email:</div>
                    <div>${profile.email}</div>
                    
                    <c:if test="${not empty profile.id}">
                        <div class="info-label">Profile ID:</div>
                        <div>${profile.id}</div>
                    </c:if>
                </div>
            </div>
            
            <div class="info-section">
                <h3>&#127919; Hobbies & Interests</h3>
                <div class="hobby-tags">
                    <c:forEach var="hobby" items="${profile.hobbies.split(',')}">
                        <div class="hobby-tag">${hobby}</div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="info-section">
                <h3>&#128221; About Me</h3>
                <div class="introduction-box">
                    ${profile.introduction}
                </div>
            </div>
        </div>
        
        <div class="actions">
            <a href="index.html" class="btn btn-primary">&#10133; Create New Profile</a>
            <a href="viewProfiles.jsp" class="btn btn-view">&#128101; Back to All Profiles</a>
            <a href="welcome.html" class="btn btn-secondary">&#127968; Home</a>
        </div>
    </div>
</body>
</html>