<?php
// Параметры подключения к базе данных
$host = 'localhost'; // адрес хоста
$username = 'root'; // имя пользователя базы данных
$password = '2004'; // пароль пользователя базы данных
$dbname = 'mydb'; // имя базы данных

// Устанавливаем соединение с базой данных
$conn = new mysqli($host, $username, $password, $dbname);

// Проверяем соединение на ошибки
if ($conn->connect_error) {
    die("Ошибка соединения с базой данных: " . $conn->connect_error);
}

// Получаем данные из формы
$phone = $_POST['phone'];
$email = $_POST['email'];
$ticket = $_POST['ticket'];
$rating = $_POST['rating'];

// Проверяем наличие клиента в базе данных
$sql_check_client = "SELECT idКлиенты FROM Клиенты WHERE phone_number = '$phone' AND email = '$email'";
$result_check_client = $conn->query($sql_check_client);

if ($result_check_client->num_rows > 0) {
    // Клиент уже существует
    $row_check_client = $result_check_client->fetch_assoc();
    $client_id = $row_check_client['idКлиенты'];
} else {
    // Клиент не найден, добавляем нового клиента
    $sql_add_client = "INSERT INTO Клиенты (phone_number, email, Талоны_ticket_id) VALUES ('$phone', '$email', '$ticket')";

    if ($conn->query($sql_add_client) === TRUE) {
        $client_id = $conn->insert_id;
    } else {
        echo "Ошибка при добавлении клиента: " . $conn->error;
        exit(); // Предотвращаем добавление отзыва при ошибке добавления клиента
    }
}

// Получаем первый символ талона
$sql_first_symbol = "SELECT SUBSTRING(ticket_id, 1, 1) AS first_symbol FROM Талоны WHERE ticket_id = '$ticket'";
$result_first_symbol = $conn->query($sql_first_symbol);

if ($result_first_symbol->num_rows > 0) {
    $row_first_symbol = $result_first_symbol->fetch_assoc();
    $first_symbol = $row_first_symbol['first_symbol'];

    // Вставляем отзыв в таблицу
    $sql_review = "INSERT INTO Отзывы (fk_client_id, fk_ticket_id, fk_window_id, evaluation)
    VALUES ('$client_id', '$ticket', '$first_symbol', '$rating')";

    if ($conn->query($sql_review) === TRUE) {
        // Отзыв успешно добавлен
        echo "Отзыв добавлен";
    } else {
        echo "Ошибка при добавлении отзыва: " . $conn->error;
    }
} else {
    echo "Талон не найден.";
    // Предотвращаем добавление отзыва при отсутствии талона
    exit();
}

// Закрываем соединение с базой данных
$conn->close();
?>
