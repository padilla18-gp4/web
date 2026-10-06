<?php
require_once "auth.php";
require_once "database.php";   // your existing mysqli $conn

// Already logged in? Go to the right dashboard.
if (!empty($_SESSION['user_id']) && !empty($_SESSION['role'])) {
    header("Location: " . dashboard_for($_SESSION['role']));
    exit();
}

$error = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    if (!csrf_verify()) {

        $error = "Session expired. Please try again.";

    } else {

        $identifier = trim($_POST["username"] ?? "");   // Student ID OR email
        $password   = $_POST["password"] ?? "";

        $stmt = $conn->prepare("
            SELECT id, student_id, full_name, email, password, role, status
            FROM users
            WHERE student_id = ? OR email = ?
            LIMIT 1
        ");
        $stmt->bind_param("ss", $identifier, $identifier);
        $stmt->execute();
        $user = $stmt->get_result()->fetch_assoc();

        if ($user && password_verify($password, $user["password"])) {

            if ($user["status"] !== "active") {

                $error = "This account has been disabled. Please contact the administrator.";

            } else {

                session_regenerate_id(true);   // prevents session fixation

                $_SESSION["user_id"]   = (int)$user["id"];
                $_SESSION["role"]      = $user["role"];
                $_SESSION["studentID"] = $user["student_id"];   // kept for your existing homepage.php
                $_SESSION["full_name"] = $user["full_name"];
                $_SESSION["email"]     = $user["email"];

                header("Location: " . dashboard_for($user["role"]));
                exit();
            }

        } else {

            $error = "Invalid Student ID/Email or Password.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="login.css">
    <title>Login - Scheduling System</title>
</head>
<body>

    <h1>SCHEDULING SYSTEM</h1>

    <form method="POST" action="">

        <?php echo csrf_field(); ?>

        <div class="name-container">

            <h1>Welcome Back!</h1>
            <h3>Login to your account</h3>

            <?php if ($error !== ""): ?>
                <p style="color: red;"><?php echo e($error); ?></p>
            <?php endif; ?>

            <label for="username">Student ID or Email:</label>

            <input
                type="text"
                id="username"
                name="username"
                placeholder="2023-12345 or you@ncst.edu.ph"
                maxlength="100"
                required
            >

            <br>

            <label for="password">Password:</label>

            <div class="password-container">
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="****"
                    required
                >
                <button type="button" id="togglePassword" class="eye-button">👁</button>
            </div>

            <br>

            <input type="submit" value="Login" id="login">

            <br><br>

            <span>Don't have an account?</span>
            <a href="register.php" id="register">Register here</a>

        </div>

    </form>

<script>
const password = document.getElementById("password");
const togglePassword = document.getElementById("togglePassword");

togglePassword.addEventListener("click", function () {
    if (password.type === "password") {
        password.type = "text";
        togglePassword.textContent = "🙈";
    } else {
        password.type = "password";
        togglePassword.textContent = "👁";
    }
});
</script>

</body>
</html>
