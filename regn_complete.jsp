<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "java.lang.*" %>
<html>
<head>
	<title>Check</title>
	<style>
	.center {
		padding: 200px 0;
		text-align: center;
	}
	</style>
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@600&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body style="font-family: 'Quicksand', sans-serif;">
	<div class="center">
	<c:set var="Uname" value="${param.uname}" />
	<c:set var="Email" value = "${param.mail}" />
	<c:set var="Password" value = "${param.pass}" />
	<c:set var="Repassword" value="${param.repass}" />
	<c:set var="Nameo" value="${param.fname}" />
	<c:set var="ok" value="true"/>
	<c:if test="${empty Uname}">
		<font style="color:red;font-size:20px"> Please enter a username </font><br>
		<c:set var="ok" value="false"/>
	</c:if>
	<c:if test="${empty Email}">
		<font style="color:red;font-size:20px"> Please enter an Email Address </font><br>
		<c:set var="ok" value="false"/>
	</c:if>
	<c:if test="${empty Password}">
		<font style="color:red;font-size:20px"> Please enter a password </font><br>
		<c:set var="ok" value="false"/>
	</c:if>
	<c:if test="${Password != Repassword}">
		<font style="color:red;font-size:20px"> The two passwords do not match </font><br>
		<c:set var="ok" value="false"/>
	</c:if>
	<c:if test="${empty Nameo}">
		<font style="color:red;font-size:20px"> Please enter a name </font><br>
		<c:set var="ok" value="false"/>
	</c:if>
	<c:choose>
		<c:when test="${fn:contains(Email, '@')}">
		</c:when>
		<c:otherwise>
			<font style="color:red;font-size:20px"> Please enter valid Email Address </font><br>
			<c:set var="ok" value="false"/>
		</c:otherwise>
	</c:choose>
	<sql:setDataSource var = "user_data" driver = "com.mysql.jdbc.Driver"
			url = "jdbc:mysql://localhost/testdb"
			user = "root" password = "lqSMy28!"/>

	<sql:query dataSource="${user_data}" var="result">
		select username from FlashUsers where username = ?
		<sql:param value = "${Uname}" />
	</sql:query>
	<c:choose>
		<c:when test = "${result.rowCount >= 1}">
			<font style="color:red;font-size:20px"> Username Already Taken </font><br>
			<br>
			<c:set var="ok" value="false"/>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>

	<sql:query dataSource="${user_data}" var="result">
		select email from FlashUsers where email = ?
		<sql:param value = "${Email}" />
	</sql:query>
	<c:choose>
		<c:when test = "${result.rowCount >= 1}">
			<font style="color:red;font-size:20px"> Email address already used by another account </font><br>
			<br>
			<c:set var="ok" value="false"/>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>

	<c:if test="${ok eq true}">
	    <sql:update dataSource = "${user_data}" var="res">
	      insert into FlashUsers values(?, ?, ?, ?);
				<sql:param value = "${Uname}" />
	      <sql:param value = "${Password}" />
	      <sql:param value = "${Email}" />
	      <sql:param value = "${Nameo}" />
	    </sql:update>
			<c:if test="${res < 1}">
				<c:set var="ok" value="false"/>
			</c:if>

	</c:if>
	<c:if test="${ok eq true}">
		<font style="color:green;font-size:20px"> You were successfully registered </font><br>
		<br>
		<a href="index.jsp" class="btn btn-outline-primary btn-lg"> Go back to login page</a>
	</c:if>
	<c:if test="${ok eq false}">
		<font style="color:red;font-size:20px"> You were not registered </font><br>
		<br>
		<a href="index.jsp" class="btn btn-outline-danger btn-lg"> Go back to login page</a>
	</c:if>
</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
