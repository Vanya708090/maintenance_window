<?php
$host = 'localhost'; // адрес хоста
$username = 'root'; // имя пользователя базы данных
$password = '2004'; // пароль пользователя базы данных
$dbname = 'mydb'; // имя базы данных

$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Ошибка подключения к базе данных: " . $conn->connect_error);
}

$sql = "DELETE FROM Параметры;";
$result = $conn->query($sql);

$sql = "INSERT INTO Параметры (total_evaluations, quality_score, total_reviews, average_rating, total_points, Окна_обслуживания_window_id, name_employer, department)
SELECT
  sub.total_evaluations,
  sub.quality_score,
  sub.total_reviews,
  sub.average_rating,
  sub.total_points,
  sub.fk_window_id,
  o.employee_name AS name_employer,
  o.department AS department
FROM
  (
    SELECT
      fk_window_id,
      COUNT(*) AS total_evaluations,
      SUM(evaluation) AS quality_score,
      COUNT(*) AS total_reviews,
      AVG(evaluation) AS average_rating,
      SUM(evaluation) AS total_points
    FROM
      Отзывы
    GROUP BY
      fk_window_id
  ) AS sub
JOIN
  `Окна обслуживания` AS o ON o.window_id = sub.fk_window_id;";
$result = $conn->query($sql);

$sql = "SELECT * FROM Параметры";
$result = $conn->query($sql);

require 'vendor/autoload.php';
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();

$sheet->setCellValue('A1', 'Отделение');
$sheet->setCellValue('B1', 'Имя сотрудника');
$sheet->setCellValue('C1', 'Количество оценок');
$sheet->setCellValue('D1', 'Балл по качественным показателям');
$sheet->setCellValue('E1', 'Количество отзывов');
$sheet->setCellValue('F1', 'Средняя оценка');
$sheet->setCellValue('G1', 'Общее количество баллов');

$row = 2;
if ($result->num_rows > 0) {
    while ($row_data = $result->fetch_assoc()) {
        $sheet->setCellValue('A' . $row, $row_data['department']);
        $sheet->setCellValue('B' . $row, $row_data['name_employer']);
        $sheet->setCellValue('C' . $row, $row_data['total_reviews']);
        $sheet->setCellValue('D' . $row, $row_data['quality_score']);
        $sheet->setCellValue('E' . $row, $row_data['total_reviews']);
        $sheet->setCellValue('F' . $row, $row_data['average_rating']);
        $sheet->setCellValue('G' . $row, $row_data['total_points']);
    
        $row++;
    }
}

$sheet->getColumnDimension('A')->setWidth(10);
$sheet->getColumnDimension('B')->setWidth(30);
$sheet->getColumnDimension('C')->setWidth(20);
$sheet->getColumnDimension('D')->setWidth(30);
$sheet->getColumnDimension('E')->setWidth(20);
$sheet->getColumnDimension('F')->setWidth(20);
$sheet->getColumnDimension('G')->setWidth(30);


$uploadDir = __DIR__ . '/download';

$filename = 'export.xlsx';
$filePath = $uploadDir . '/' . $filename;


$writer = new Xlsx($spreadsheet);
$writer->save($filePath);
// Отправка заголовков для скачивания файла
header('Content-Description: File Transfer');
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename=' . basename($filePath));
header('Content-Transfer-Encoding: binary');
header('Content-Length: ' . filesize($filePath));

// Отправка файла на скачивание
readfile($filePath);
echo file_get_contents($filePath);
exit();


?>
