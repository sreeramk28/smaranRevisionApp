<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var="deck_data" driver="com.mysql.jdbc.Driver"
  url= "jdbc:mysql://localhost/testdb"
  user="root" password="lqSMy28!" />
<sql:update dataSource="${deck_data}" var="res">
  delete from FlashDecks where username = ? and deckname = ?
  and question = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.dd}" />
  <sql:param value = "${param.dq}" />
</sql:update>
<c:redirect url="questions.jsp?vq=${param.dd}" />
