<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var = "user_data" driver = "com.mysql.jdbc.Driver"
    url = "jdbc:mysql://localhost/testdb"
    user = "root" password = "lqSMy28!"/>
<c:set var="cur_deck" value="${param.vq}" />
<sql:query dataSource="${user_data}" var="result">
  select name from FlashUsers where username = ?
  <sql:param value = "${final_user_name}" />
</sql:query>
<c:if test="${result.rowCount < 1}" >
  <c:redirect url="index.jsp" />
</c:if>
<sql:query dataSource="${user_data}" var="result2">
  select deckname from Decks where username = ? and deckname = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${cur_deck}" />
</sql:query>
<c:if test="${result2.rowCount < 1}" >
  <c:redirect url="home.jsp" />
</c:if>
<sql:query dataSource="${user_data}" var="result1">
  select question, answer from FlashDecks where username = ? and deckname = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${cur_deck}" />
</sql:query>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>

    <meta charset="utf-8">
    <title>|| Smaran ||</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@600&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>
  <body style="background-image: url('wal.jpg');font-family: 'Quicksand', sans-serif;">
    <div class="container-fluid">
      <nav class="navbar navbar-expand-md navbar-dark" style="font-size:30px;background-color:gray;color:white;opacity:0.6;">
        <img src="logo.png" alt="logo">
        <a style="font-size:30px;">|| Smaran ||</a>
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarCollapse" style="font-size:20px;">
          <div class="navbar-nav" style="padding-left:30px;">
            <a href="home.jsp" class="nav-item nav-link">
              Home
            </a>
          </div>
          <div class="navbar-nav ml-auto">
            <a class="nav-item nav-link"  style="color:white;">
              <c:out value = "${'Welcome'}" />
              <c:forEach var = "row" items = "${result.rows}">
                <c:out value =  "${row.name}! " />
              </c:forEach>
            </a>
            <a href="logout.jsp" class="nav-item nav-link"  style="padding-left: 30px;"> Logout </a>
          </div>
        </div>
      </nav>
    </div>
      <div style="text-align:center;font-size:26px;">
        <div> Deck Name: ${cur_deck} </div>
      </div>
      <div style="font-size:18px;padding-left: 15px">
        <div> New Question </div>
      </div>
      <div class="container-fluid">
        <form class="question_add" action="question_insert.jsp?vq=${cur_deck}" method="post">
          <div class="form-group">
            <input style="font-size:16px;" type="text" name = "question_name" class="form-control"  maxlength="99" placeholder="Question" required>
          </div>
          <div class="form-group">
            <textarea style="font-size:16px;" rows="4" class="form-control" name="answer_name" maxlength="499" placeholder="Answer" required></textarea>
          </div>
          <div class="form-group">
            <input type="submit" class="btn btn-sm btn-dark" value = "Add">
          </div>
        </form>
      </div>
      <div class="container-fluid" style="font-size:20px;">
        <div class="row">
          <div class="col" style="text-align:center";>
            Added Questions
          </div>
        </div>
      </div>
      <div class="container-fluid"> .</div>
      <div class="container-fluid" style="opacity:0.7">
        <c:forEach var = "row1" items = "${result1.rows}">
          <div class="card text-white bg-secondary mb-4">
            <div class="card-body">
              <div id="${row1.question}_id" class="card-title" style="font-size:16px;">
                <c:out value = "Q. ${row1.question}" />
              </div>
              <div id="${row1.answer}_id"class="card-text" style="font-size:16px;">
                <c:out value = "A. ${row1.answer}" />
              </div>
              <div class="card-text">
                <a id="${row1.question}_del" class="btn btn-dark btn-sm" href="del_ques.jsp?dd=${cur_deck}&dq=${row1.question}">
                  Delete Question
                </a>
              </div>
            </div>
          </div>
        </c:forEach>
        <c:if test="${result1.rowCount < 1}" >
          <div class="card text-white bg-secondary mb-4">
            <div class="card-body">
              <div class="card-title" style="font-size:20px;text-align:center" >
                <c:out value = "You have not added any questions" />
              </div>
            </div>
          </div>
        </c:if>
      </div>
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>
