<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify User</title>
</head>
<body>

<!--SQL Driver init-->
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
url="jdbc:mysql://localhost:3306/wiki_db" user="root" password="password"/>

<!-- Admin check -->
<sql:query dataSource="${snapshot}" var="adminResult">
    SELECT COUNT(*) AS adminQuery
    FROM admin_login
    WHERE username = ? AND password_hash = MD5(?)
    <sql:param value="${param.usernameForm}" />
    <sql:param value="${param.passwordForm}" />
</sql:query>

<!-- Evaluate admin login -->
<c:forEach items="${adminResult.rows}" var="rEval">
    <c:choose>
        <c:when test="${rEval.adminQuery == 1}">
            <!--Hold sessiondata on successful login and report-->
            <c:set var = "usernameSession" scope = "session" value="${param.usernameForm}" />
            <c:set var="isAdmin" value="true" scope="session" />
            <c:out value="Admin login successful for ${usernameSession}" />
        </c:when>
        <c:when test="${rEval.adminQuery > 1}">
            <c:out value="ERROR! CREDENTIAL DUPLICATION IN ADMIN TABLE"/>
        </c:when>
        <c:otherwise>
        <!-- Evaluate user login on admin login fail -->
            <sql:query dataSource="${snapshot}" var="result">
                SELECT COUNT(*) AS userQuery
                FROM user_login 
                WHERE username = ? AND password_hash = MD5(?)
                <sql:param value="${param.usernameForm}" />
                <sql:param value="${param.passwordForm}" />
            </sql:query>
            <!--Select and assess-->
            <c:forEach items="${result.rows}" var="rEval">
                <c:choose>
                    <c:when test="${rEval.userQuery == 1}">
                        <!--Hold sessiondata on successful login and report-->
                        <c:set var = "usernameSession" scope = "session" value="${param.usernameForm}" />
                        <c:out value="User login successful for ${usernameSession}" />
                    </c:when>
                    <c:when test="${rEval.userQuery > 1}">
                        <c:out value="ERROR! CREDENTIAL DUPLICATION IN USER TABLE"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="Account auth failed! User not found or password incorrect."/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</c:forEach>
<br>
<a href="login.jsp">Back</a>
</body>
</html