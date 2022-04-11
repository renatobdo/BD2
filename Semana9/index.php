<!DOCTYPE html>
<html>
    <head>
        <title>PHP MySQL Stored Procedure Demo 1</title>
        <link rel="stylesheet" href="css/table.css" type="text/css" />
    </head>
    <body>
        <?php
        require_once 'dbconfig.php';
        try {
            $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
            // execute the stored procedure
            $sql = 'CALL GetCustomers()';
            // call the stored procedure
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            die("Error occurred:" . $e->getMessage());
        }
        ?>
        <table>
            <tr>
                <th>Customer Name</th>
                <th>City</th>
                <th>State</th>
                <th>Postal Code</th>
                <th>Country</th>
            </tr>
            <?php while ($row = $q->fetch()): ?>
                <tr>
                    <td><?php echo $row['customerName'] ?></td>
                    <td><?php echo $row['city'] ?></td>
                    <td><?php echo $row['state'] ?></td>
                    <td><?php echo $row['postalCode'] ?></td>
                    <td><?php echo $row['country'] ?></td>
                    
                   
                </tr>
            <?php endwhile; ?>
        </table>
    </body>
</html>
