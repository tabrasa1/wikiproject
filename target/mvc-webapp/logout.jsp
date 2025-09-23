<%@ page language="java" %>
<%
    // Invalidate the session
    session.invalidate();
%>

<jsp:forward page="login.jsp"/>

