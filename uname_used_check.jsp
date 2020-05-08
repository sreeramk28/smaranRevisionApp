<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "java.lang.*" %>
    <%
      String unname = request.getParameter("username");
      pageContext.setAttribute("unname", unname);
    %>
    <sql:setDataSource var="user_data" driver="com.mysql.jdbc.Driver"
      url= "jdbc:mysql://localhost/testdb"
      user="root" password="lqSMy28!" />
    <sql:query dataSource="${user_data}" var="result">
      select username from FlashUsers where username = ?
      <sql:param value = "${unname}" />
    </sql:query>
    <c:choose>
      <c:when test = "${result.rowCount >= 1}">
        <p> Username Taken </p>
      </c:when>
      <c:otherwise>
        <p> Username Available </p>
      </c:otherwise>
    </c:choose>
