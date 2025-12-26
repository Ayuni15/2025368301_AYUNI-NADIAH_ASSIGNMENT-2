<%-- 
    Document   : displayProfile
    Created on : Nov 11, 2025, 11:01:12 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        
        .profile-container {
            max-width: 800px;
            margin: 20px auto;
            background: white;
            border-radius: 20px; 
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .profile-header {
            background: #2c3e50;
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
            background: #3498db;
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
        }
        
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #e74c3c; 
            color: white;
        }
        
        .btn-secondary:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h1> ${name}</h1>
            <div class="subtitle">Profile Created Successfully!</div>
        </div>
        
        <div class="profile-content">
            <div class="info-section">
                <h3> Personal Information</h3>
                <div class="info-grid">
                    <div class="info-label">Student ID:</div>
                    <div>${studentId}</div>
                    
                    <div class="info-label">Program:</div>
                    <div>${program}</div>
                    
                    <div class="info-label">Email:</div>
                    <div>${email}</div>
                </div>
            </div>
            
            <div class="info-section">
                <h3> Hobbies & Interests</h3>
                <div class="hobby-tags">
                    <c:forEach var="hobby" items="${hobbies}">
                        <div class="hobby-tag">${hobby}</div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="info-section">
                <h3> About Me</h3>
                <div class="introduction-box">
                    ${introduction}
                </div>
            </div>
        </div>
        
        <div class="actions">
            <a href="index.html" class="btn btn-primary"> Create New Profile</a>
            <a href="welcome.html" class="btn btn-secondary"> Home</a>
        </div>
    </div>
</body>
</html>