<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <title>|| Smaran ||</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@600&display=swap" rel="stylesheet">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
    </style>
    <script>
    function takenUsername() {
      //document.getElementById("uname_taken").innerHTML = str;
      var xhttp;
      var str = document.getElementById("uname").value;
      if(str == "") {
        return;
      }
      xhttp = new XMLHttpRequest();
      try {
      xhttp.onreadystatechange = function () {
        if(this.readyState == 4 && this.status == 200) {
          //alert(this.responseText);
          document.getElementById("uname_taken").innerHTML = this.responseText;
          //var st = document.getElementById("uname_taken").value;
          //alert(st);
          //return true;
        }
      };
      xhttp.open("GET", "uname_used_check.jsp?username="+str, true);
      xhttp.send();
      }
      catch(e) {
        alert("Err");
      }
    }
    </script>
  </head>
  <body style="background-image: url('wal.jpg'); font-family: 'Quicksand', sans-serif;">

    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: gray;color:white;opacity:0.6;">
      <div class="navbar-brand mx-auto">
          <img src="logo.png" alt="logo">
          <a style="font-size:30px;">|| Smaran ||</a>
      </div>

    </nav>
    <br>
      <div class="container-fluid" style="font-size:20px;" >
        <div class="login">
          <div class="row">
            <div class='col'></div>
            <div class='col'></div>
            <div class='col'>
              <div class="logind"> Login </div>
            </div>
          </div>
          <div class="row" >
            <div class='col'></div>
            <div class='col'></div>
            <div class='col'>
            <form id="login" action="login_check.jsp" method="post">
              <input type="text" name="user_name" class="form-control-sm" id ="user_name" placeholder="Username" maxlength="20" required>
              <br>
              <input type="password" name="pwd" class="form-control-sm" id="pwd" placeholder="Password" maxlength="20" required>
              <br><br>
              <input type="submit" id="login_but" class="btn btn-dark btn-sm" name="login_but">
              <br>
            </form>
            </div>
          </div>
        </div>
        <br>
        <div class="signup">
          <div class="row">
            <div class='col'></div>
            <div class='col'></div>
            <div class='col'>
              <div class="signupd"> Sign Up </div>
            </div>
          </div>

          <div class="row">
              <div class='col'></div>
              <div class='col'></div>
              <div class='col'>
              <form id="signup" action="regn_complete.jsp" method="post">

                <input type="text" name="fname" class="form-control-sm" id ="fname" placeholder="Your Name" maxlength="30" required>
                <br>
                <input type="text" name="mail" class="form-control-sm" id ="mail" placeholder="E-Mail ID" maxlength="30" required>
                <br>
                <input type="text" name="uname" class="form-control-sm" id ="uname" placeholder="Username" onchange="takenUsername()" maxlength="20" required>
                <br>
                <input type="password" name="pass" class="form-control-sm" id ="pass" placeholder="Password" maxlength="20" required>
                <br>
                <input type="password" name="repass" class="form-control-sm" id ="repass" placeholder="Re enter Password" maxlength="20" required>
                <br><br>
                <input type="submit" id="signup_but" class="rotating btn btn-dark btn-sm" name="signup_but">
                <br>
              </form>
              <div id="uname_taken"> </div>
              </div>
          </div>
        </div>
      </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>
