<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var = "user_data" driver = "com.mysql.jdbc.Driver"
    url = "jdbc:mysql://localhost/testdb"
    user = "root" password = "lqSMy28!"/>
<sql:query dataSource="${user_data}" var="result">
  select name from FlashUsers where username = ?
  <sql:param value = "${final_user_name}" />
</sql:query>
<c:if test="${result.rowCount < 1}" >
  <c:redirect url="index.jsp" />
</c:if>
<sql:query dataSource="${user_data}" var="result1">
  select deckname from Decks where username = ?
  <sql:param value = "${final_user_name}" />
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
      <nav class="navbar navbar-expand-md navbar-dark" style="font-size:30px;background-color:gray;opacity:0.8;">
        <form class="form-inline" action="deck_insert.jsp" method="post">
          <div class="form-group mr-2">
          <input name = "deck_name" class="form-control-sm" type="text" placeholder="Deck's Name" maxlength="40" required>
          </div>
          <div class="form-group mr-2">
          <input type="submit" class="btn btn-sm btn-outline-light" value = "Add Deck">
          </div>
        </form>
      </nav>
    </div>
    <div class="container-fluid" style="font-size:20px;">
      <div class="row"> <br> </div>
      <c:if test="${result1.rowCount < 1}">
        <div class="row">
          <div class="col-sm-3">
            <div id="nodecks" class="card text-white bg-secondary mb-4">
              <div class="card-body">
                <div class="card-title">
                  No Decks Added
                </div>
              </div>
            </div>
          </div>
        </div>
      </c:if>
      <div class="row">

      <c:forEach var = "row1" items = "${result1.rows}">

          <div class="col-sm-3" style="opacity:0.7">
            <div id="${row1.deckname}_id" class="card text-white bg-secondary mb-4">
              <div class="card-body">
                <div class="card-title">
                  <c:out value = "${row1.deckname}" />
                </div>
                <div class="card-text">
                  <a id="${row1.deckname}_list" class="btn btn-dark btn-sm" href="questions.jsp?vq=${row1.deckname}">
                    View & Add Questions
                  </a>
                </div>
                <div class="card-text">
                  <a id="${row1.deckname}_play" class="btn btn-dark btn-sm" href="play.jsp?deck_name=${row1.deckname}">
                    Play Questions
                  </a>
                </div>
                 <div class="card-text">
                    <a id="${row1.deckname}_del" class="btn btn-dark btn-sm" href="del_deck.jsp?dd=${row1.deckname}">
                      Delete Deck
                    </a>
                  </div>
                </div>
              </div>
            </div>
      </c:forEach>
      </div>
    </div>

      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  </body>
</html>
