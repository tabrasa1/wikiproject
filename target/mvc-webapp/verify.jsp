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

<%
//JDBC driver name and database URL
//STEP 2: Register JDBC driver
%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
url="jdbc:mysql://localhost:3306/wiki_db" user="root" password="password"/>

<%
//Getting Request parameters
%>

<c:set var = "usernameEntered" scope = "session" value="${param.usernameForm}"/>

<% //STEP 3: Open a connection
//STEP 4: Execute a query
%>
<sql:query dataSource="${snapshot}" var="result"> select count(*) as countUsers from user_login where username = ?
<sql:param value="${usernameEntered}" />
</sql:query>
<%
//STEP 5: Extract data from result set
%>
<c:forEach items="${result.rows}" var="r">
<c:choose>
<c:when test="${r.countUsers > 0}">
<c:out value="Username ${usernameEntered} exists"/>
</c:when>
<c:otherwise>
<c:out value=" Username ${usernameEntered} does not exist!"/>
</c:otherwise>
</c:choose>
</c:forEach>
<br>
<a href="login.jsp">Back</a>
</body>
</html