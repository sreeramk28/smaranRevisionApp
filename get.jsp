<%@ page contentType = "text/xml" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var = "user_data" driver = "com.mysql.jdbc.Driver"
    url = "jdbc:mysql://localhost/testdb"
    user = "root" password = "lqSMy28!"/>
<sql:query dataSource="${user_data}" var="result">
  select question, answer, mindex from FlashDecks where username = ? and deckname = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.deck_name}" />
</sql:query>
<total>
  <c:forEach var="row" items = "${result.rows}">
    <block>
      <que><c:out value = "${row.question}" /></que>
      <ans><c:out value = "${row.answer}" /></ans>
      <midx><c:out value = "${row.midx}" /></midx>
    </block>
  </c:forEach>
</total>
