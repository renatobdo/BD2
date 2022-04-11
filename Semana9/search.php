<?php
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHP.php to edit this template
 * https://getbootstrap.com/docs/5.1/content/tables/ 
 */
?>
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quicksearch e bootstrap</title>
        <script src="https://code.jquery.com/jquery-3.1.1.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.quicksearch/2.3.1/jquery.quicksearch.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="procedures.css">
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
        <br><br>

        <form  method="post">
            <div class="form-group input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                <input name="consulta" id="txt_consulta" placeholder="Consultar" type="text" class="form-control">
            </div>
            <input type="submit" class="btn btn-primary" name="pesquisar" value="pesquisar" />
            <br><br>
        </form>
<?php
if ($_SERVER['REQUEST_METHOD'] == "POST")
    if (isset($_POST['pesquisar'])) {
        ?>


                <table id="tabela" class="table table-striped table-hover">

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
            <?php
        endwhile;
    } 
      
?>
            </table>
    </body>
</html>
