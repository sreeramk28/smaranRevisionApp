<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.ArrayList"%>
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
<sql:query dataSource="${user_data}" var="result2">
  select deckname from Decks where username = ? and deckname = ?
  <sql:param value = "${final_user_name}" />
  <sql:param value = "${param.deck_name}" />
</sql:query>
<c:if test="${result2.rowCount < 1}" >
  <c:redirect url="home.jsp" />
</c:if>
<html>
  <head>
    <meta charset="utf-8">
    <title>|| Smaran ||</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@600&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
      body { background-image: url('wal.jpg');font-family: 'Quicksand', sans-serif; }

      .scene {
        width: 600px;
        height: 320px;
        border: 1px solid #CCC;
        perspective: 600px;
      }

      .card {

        width: 100%;
        height: 100%;
        transition: transform 2.0s;
        transform-style: preserve-3d;
        cursor: pointer;
        position: relative;
      }

      .card.is-flipped {
        transform : rotateY(180deg);
      }

      .card__face {
        position: absolute;
        width: 100%;
        height: 100%;

        font-weight: bold;
        font-size: 20px;
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
      }

      .card__face--front {
        background: #C0C0C0;
        color: black;
      }

      .card__face--back {
        background: black;
        color: white;
        transform: rotateY(180deg);
      }
    </style>

  </head>
  <body>

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
      <div style="text-align:center;font-size:26px;">
        <div> Deck Name: ${param.deck_name} </div>
      </div>
    </div>
    <div class="container-fluid">
      <div class="row"> <br> <br> </div>
      <div class="row">
        <div class="col"></div>
        <div class="col">
          <div class="scene">
            <div class="card">
              <div id = "fnt" class="card__face card__face--front">
              </div>
              <div id = "bk" class="card__face card__face--back">
              </div>
            </div>
          </div>
        </div>
        <div class="col"></div>
      </div>
      <div id="progress"></div>
    </div>
    <script>

      var arr = [];
      var result;
      var ix = 0;
      var n;
      var xhttp;
      var idxperm;
      xhttp = new XMLHttpRequest();
      try {
      xhttp.onreadystatechange = function () {
        if(this.readyState == 4 && this.status == 200) {
          result = this.responseXML.getElementsByTagName("block");
          //alert(n);
          //solve();
          n = result.length;
          //alert(n);
          //alert("lol");
          shuffle();
          initProgress();
          go();
          //alert(arr);
        }
      };
      //alert("ok");
      xhttp.open("GET", "get.jsp?deck_name=${param.deck_name}", true);
      xhttp.send();
      }
      catch(e) {
        alert("Err");
      }

      function go() {
        //alert(arr);
        if(n == 0) {
          document.getElementById("fnt").innerHTML = "No Questions added";
          document.getElementById("bk").innerHTML = "No Questions added";
        }
        else {
          setHtml(arr[ix]);
        }
      }
      function setHtmlBack() {
        //alert("ok");
        var pref = "Answer: ";
        var xyz = document.createTextNode(pref);
        var brk = document.createElement('br');
        var st = document.createTextNode(result[arr[ix]].getElementsByTagName("ans")[0].childNodes[0].nodeValue);
        var dv = document.createElement('div');
        dv.appendChild(xyz);
        dv.appendChild(brk);
        dv.appendChild(st);
        document.getElementById("bk").appendChild(dv);
        ix = (ix + 1) % n;
      }
      function setHtml(idx) {
        var pref = "Question: ";
        document.getElementById("bk").innerHTML = "";
        document.getElementById("fnt").innerHTML = "";
        var brk = document.createElement('br');
        var b2 = document.createElement('button');
        var txt2 = document.createTextNode("VIEW ANSWER");
        b2.id = "ansc";
        b2.className = "btn btn-dark btn-md";
        b2.appendChild(txt2);
        var dd = document.createElement("div");
        dd.appendChild(b2);
        var txt_q = document.createTextNode(pref);
        //txt_q.appendChild(brk);
        var txt3 = document.createTextNode(result[idx].getElementsByTagName("que")[0].childNodes[0].nodeValue);

        var dd1 = document.createElement("div");
        dd1.appendChild(txt_q);
        dd1.appendChild(brk);
        dd1.appendChild(txt3);

        document.getElementById("fnt").appendChild(dd);
        //document.getElementById("fnt").innerHTML +=pref;
        document.getElementById("fnt").appendChild(dd1);

        b2.addEventListener("click", function() {
          //alert("enda");
          //alert("..");
          dispNext();

        });
        $("#ansc").on('click', function() {
          $(this).prop('disabled', true);
        });
      }
      function dispNext() {

        //alert("ok");

        //upd();
        var cur;
        var txt0 = document.createTextNode("KNEW");
        var txt1 = document.createTextNode("DIDN'T KNOW");
        var b0 = document.createElement('button');
        var b1 = document.createElement('button');
        b0.id = "remm";
        b1.id = "forg";
        b0.className = "btn btn-dark btn-md";
        b1.className = "btn btn-dark btn-md";

        b0.appendChild(txt0);
        b1.appendChild(txt1);
        b1.addEventListener('click', function() {
          //alert(ix); alert(ix - 1);
          upd1(arr[(ix-1+n)%n]);
          //cur = arr[ix];
          if(ix == 0) shuffle();
          setHtml(arr[ix]);
        });

        b0.addEventListener('click', function() {
          //alert(ix); alert(ix - 1);
          upd0(arr[(ix-1+n)%n]);
          if(ix == 0) shuffle();
          setHtml(arr[ix]);
        });

        var d = document.createElement("div");
        //d.appendChild(b2);
        //d.className = "fc";
        var spc =document.createTextNode("  ");

        d.appendChild(b0); d.appendChild(spc); d.appendChild(b1);
        document.getElementById("bk").appendChild(d);
        //document.getElementById("bk").appendChild(b1);
          setHtmlBack();

      }
      function upd0(idx) {
        //alert(idx);
        var xhttp;
        xhttp = new XMLHttpRequest();
        try {
          xhttp.onreadystatechange = function () {
            if(this.readyState == 4 && this.status == 200) {
              //alert(this.responseText);
              document.getElementById("progress").innerHTML = this.responseText;
            }
          };
          var str = "plus.jsp?deck_name=${param.deck_name}&question=";
          var str2 = result[idx].getElementsByTagName("que")[0].childNodes[0].nodeValue;
          //str2 = str2.trim();
          str += str2;
          //alert(str+str2.length);

          xhttp.open("GET", str, true);
          xhttp.send();
        }
        catch(e) {
          alert("Err");
        }
      }
      function upd1(idx) {
        //alert(idx);
        var xhttp;
        xhttp = new XMLHttpRequest();
        try {
          xhttp.onreadystatechange = function () {
            if(this.readyState == 4 && this.status == 200) {
              document.getElementById("progress").innerHTML = this.responseText;
            }
          };
          var str = "zero.jsp?deck_name=${param.deck_name}&question=" +
          result[idx].getElementsByTagName("que")[0].childNodes[0].nodeValue;
          //alert(str);
          xhttp.open("GET", str, true);
          xhttp.send();
        }
        catch(e) {
          alert("Err");
        }
      }
      function shuffle() {
        arr = []
        for (var i = 0; i < n; i++) {
          arr.push(i);
        }
        //alert(arr);
        for(var i = n - 1; i > 0; i--) {
          var j = Math.floor(Math.random() * (i + 1));
          var tmp = arr[i];
          arr[i] = arr[j];
          arr[j] = tmp;
        }
        //alert("." + arr);
      }
      function initProgress() {
        var xhttp;
        xhttp = new XMLHttpRequest();
        try {
          xhttp.onreadystatechange = function () {
            if(this.readyState == 4 && this.status == 200) {
              document.getElementById("progress").innerHTML = this.responseText;
            }
          };
          var str = "zero.jsp?deck_name=${param.deck_name}&question=";
          xhttp.open("GET", str, true);
          xhttp.send();
        }
        catch(e) {
          alert("Err");
        }
      }
    </script>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script>
    var card = document.querySelector('.card');
    card.addEventListener('click', function() {
      card.classList.toggle('is-flipped');
    });
    </script>

  </body>

</html>
