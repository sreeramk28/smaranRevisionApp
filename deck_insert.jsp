<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var="deck_data" driver="com.mysql.jdbc.Driver"
  url= "jdbc:mysql://localhost/testdb"
  user="root" password="lqSMy28!" />
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

<sql:query dataSource="${deck_data}" var="result">
  select username, deckname from Decks where username = ? and deckname = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.deck_name}" />
</sql:query>
<c:if test="${empty param.deck_name}">
  <c:redirect url="home.jsp" />
</c:if>
<c:choose>
  <c:when test = "${result.rowCount >= 1}">
    <body style="font-family:'Quicksand', sans-serif;">
      <div class="center">
        <div style="color:red;font-size:20px"> You have already used the same Deck Name  </div>
        <br>
        <a href="home.jsp" class="btn btn-outline-danger btn-lg"> Go back to Home Page </a>
      </div>
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
  </c:when>
  <c:otherwise>

    <sql:update dataSource="${deck_data}" var="res">
      insert into Decks values(?, ?);
      <sql:param value = "${final_user_name}" />
      <sql:param value = "${param.deck_name}" />
    </sql:update>
    <c:redirect url="home.jsp" />
  </c:otherwise>
</c:choose>
