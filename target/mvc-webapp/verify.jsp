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

<!--Acquire Username: Do not acquire password til validated-->

<c:set var = "usernameEntered" scope = "session" value="${param.usernameForm}"/>

<!--Conn and Query-->
<sql:query dataSource="${snapshot}" var="result">
    SELECT COUNT(*) AS CountUsers
    FROM user_login
    WHERE username = ?
<sql:param value="${usernameEntered}" />
</sql:query>

<!--Extract data from result set-->
<c:forEach items="${result.rows}" var="r">
    <c:choose>
        <c:when test="${r.countUsers > 0}">
            <c:out value="Username ${usernameEntered} exists"/>

            <!--Begin password eval-->
            <c:set var="password" value="${param.passwordForm}" />

            <sql:query dataSource="${snapshot}" var="result">
                SELECT COUNT(*) AS pwQuery 
                FROM user_login 
                WHERE username = ? AND password_hash = ?
                <sql:param value="${usernameEntered}" />
                <sql:param value="${param.passwordForm}" />
            </sql:query>

            <!--Select-->
            <c:forEach items="${result.rows}" var="r">
            <!--Assessment-->
                <c:choose>
                    <c:when test="${r.pwQuery > 0}">
                        <c:out value="Password exists"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value=" Password eval fail"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
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