<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <title>eCEMS | Login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/index.css" type="text/css">
</head>

<body>
    <main>
        <!-- Login/Sign Up -->
        <div class="card">
            <img class="card__logo" src="image/uitm_logo.png" alt="UiTM Logo">
            <div class="card__title">
                <h1>Welcome to UiTM eCEMS 👋🏻</h1>
                <p>Sign in into your account</p>
            </div>

            <!-- Login Form -->
            <form class="card__form" action="LoginServlet" method="POST">
                <div>
                    <label for="studentNo">Student No.</label>
                    <input name="" type="text" placeholder="Enter your Student No.">
                </div>
                <div>
                    <label for="password">Password</label>
                    <input name="" type="password" placeholder="············">
                </div>
                <div class="card__button">
                    <button type="submit">Sign In</button>
                </div>
            </form>
            <!-- End Login Form-->

            <div class="card__button">
                <button onclick="location.href='home_staff.html'">Sign In as Admin (Temporary)</button>
            </div>

            <p class="card__footer">
                New on our platform?
                <a href="register.html">Create an account</a>
            </p>
        </div>
        <!-- End Login/Sign Up -->

        <!-- Banner -->
        <div class="banner">
            <img src="image/banner.png" alt="Banner">
        </div>
        <!-- End Banner -->
    </main>
</body>

</html>