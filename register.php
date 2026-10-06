<?php
require_once "auth.php";
require_once "database.php";   // your existing mysqli $conn

$message = "";
$messageType = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $studentId       = trim($_POST["studentId"] ?? "");
    $fullName        = trim($_POST["fName"] ?? "");
    $email           = strtolower(trim($_POST["email"] ?? ""));
    $phone           = trim($_POST["tel"] ?? "");
    $password        = $_POST["password"] ?? "";
    $confirmPassword = $_POST["confirm_password"] ?? "";

    // ---------- SERVER-SIDE VALIDATION ----------
    if (!csrf_verify()) {
        $message = "Session expired. Please try again.";
    } elseif (!preg_match('/^\d{4}-\d{5}$/', $studentId)) {
        $message = "Student ID must look like 2026-12345.";
    } elseif ($fullName === "" || mb_strlen($fullName) > 100) {
        $message = "Please enter your full name.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL) || substr($email, -12) !== "@ncst.edu.ph") {
        $message = "Please use your NCST school email (@ncst.edu.ph).";
    } elseif (!preg_match('/^\d{11}$/', $phone)) {
        $message = "Phone number must be 11 digits.";
    } elseif (strlen($password) < 8) {
        $message = "Password must be at least 8 characters.";
    } elseif ($password !== $confirmPassword) {
        $message = "Passwords do not match!";
    } else {

        // ---------- DUPLICATE CHECK ----------
        $check = $conn->prepare("SELECT id FROM users WHERE student_id = ? OR email = ?");
        $check->bind_param("ss", $studentId, $email);
        $check->execute();

        if ($check->get_result()->num_rows > 0) {

            $message = "Student ID or Email already exists!";

        } else {

            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

            // role is forced to 'student' - never taken from the form
            $insert = $conn->prepare("
                INSERT INTO users (student_id, full_name, email, phone, password, role)
                VALUES (?, ?, ?, ?, ?, 'student')
            ");
            $insert->bind_param("sssss", $studentId, $fullName, $email, $phone, $hashedPassword);

            if ($insert->execute()) {
                header("Location: login.php");
                exit();
            }

            $message = "Registration failed. Please try again.";
        }
    }

    $messageType = "error";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link rel="stylesheet" href="register.css">
</head>
<body>

    <form method="POST" action="">

        <?php echo csrf_field(); ?>

        <div class="name-container">

            <h1>REGISTRATION</h1>

            <?php if ($message !== ""): ?>
                <p style="text-align:center; color: <?php echo ($messageType === 'success') ? 'green' : 'red'; ?>;">
                    <?php echo e($message); ?>
                </p>
            <?php endif; ?>

            <div class="sub">

                <div class="left">

                    <label for="studentId">Student ID:</label>
                    <input type="text" id="studentId" name="studentId" placeholder="2026-12345"
                           maxlength="10" pattern="\d{4}-\d{5}" required
                           value="<?php echo e($_POST['studentId'] ?? ''); ?>">
                    <br>

                    <label for="fName">Full Name:</label>
                    <input type="text" id="fName" name="fName" placeholder="Ex. Mark PJ" required
                           value="<?php echo e($_POST['fName'] ?? ''); ?>">
                    <br>

                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" placeholder="yourname@ncst.edu.ph" required
                           value="<?php echo e($_POST['email'] ?? ''); ?>">
                    <br>

                </div>

                <div class="right">

                    <label for="tel">Phone Number:</label>
                    <input type="tel" id="tel" name="tel" placeholder="09123456789"
                           maxlength="11" pattern="\d{11}" required
                           value="<?php echo e($_POST['tel'] ?? ''); ?>">
                    <br>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" placeholder="At least 8 characters"
                           minlength="8" required>
                    <br>

                    <label for="confirm_password">Confirm Password:</label>
                    <input type="password" id="confirm_password" name="confirm_password" placeholder="****" required>
                    <br>

                </div>

            </div>

            <div class="btn">
                <button type="submit">Submit</button>
            </div>

            <p style="text-align:center; margin-top:15px;">
                Already have an account? <a href="login.php">Login</a>
            </p>

        </div>

    </form>

    <script src="register.js"></script>
</body>
</html>
