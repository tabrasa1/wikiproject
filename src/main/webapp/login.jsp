<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Hello JSP</title>
</head>
<body>
        <p>Armok's most scuffed Login page</p>
            <form action="verify.jsp" method="post">
            <p>
                <p> 
                    <label for="username"><b>Username: </b></label>
                    <input type="text" placeholder="..." name="usernameForm" required>
                </p>
                <p>
                    <label for="password"><b>Password: </b></label>
                    <input type="password" placeholder="..." name="passwordForm" required>
                </p>
            </p>
        <button type="submit">Verify</button>
    </form>

</body>
</html>
