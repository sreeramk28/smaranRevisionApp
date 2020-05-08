<%@ page contentType = "text/html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var = "user_data" driver = "com.mysql.jdbc.Driver"
    url = "jdbc:mysql://localhost/testdb"
    user = "root" password = "lqSMy28!"/>
<sql:update dataSource="${user_data}" var="result">
  update FlashDecks set mindex = mindex + 1 where username = ? and deckname = ? and question = ?
  and mindex < 3;
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.deck_name}" />
  <sql:param value = "${param.question}" />
</sql:update>
<sql:query dataSource="${user_data}" var="result0">
  select mindex from FlashDecks where username = ? and deckname = ?
  and mindex = 3;
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.deck_name}" />

</sql:query>
<sql:query dataSource="${user_data}" var="result1">
  select mindex from FlashDecks where username = ? and deckname = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.deck_name}" />
</sql:query>
<c:if test="${result1.rowCount > 0}">
  <c:set var="perc" ><fmt:parseNumber type="number" value="${result0.rowCount / result1.rowCount * 100}" /></c:set>
</c:if>
<c:if test="${result1.rowCount == 0}">
  <c:set var="perc" value="0" />
</c:if>
<p style="font-size:25px;"> Questions Well Known: ${result0.rowCount} / ${result1.rowCount} </p>
<div style="width:400px;" class="progress">
<div class="progress-bar-striped bg-warning" role="progressbar" style="width: ${perc}%" aria-valuemin="0" aria-valuemax="100"></div>
</div>
