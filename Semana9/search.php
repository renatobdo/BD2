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
                <input name="nomeCliente" id="txt_nomeCliente" placeholder="Consultar por nome do cliente" type="text" class="form-control">
            </div>
            <div class="form-group input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                <input name="cidade" id="txt_cidade" placeholder="Consultar por cidade" type="text" class="form-control">
            </div>
            <div class="form-group input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                <input name="estado" id="txt_estado" placeholder="Consultar por estado" type="text" class="form-control">
            </div>
            
            <div class="form-group input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                <input name="pais" id="txt_pais" placeholder="Consultar por país" type="text" class="form-control">
            </div>
            <input type="submit" class="btn btn-primary" name="pesquisar" value="pesquisar" />
            <br><br>
        </form>
        <?php
        if ($_SERVER['REQUEST_METHOD'] == "POST")
            if (isset($_POST['pesquisar']) && (empty($_POST['nomeCliente'])) && (empty($_POST['cidade'])) && (empty($_POST['pais']))) {
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
                } else if (isset($_POST['pesquisar']) && !(empty($_POST['nomeCliente']))) {
                    // execute the stored procedure
                    try {
                        $pdo2 = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
                        $sql2 = 'CALL GetCustomersByName(' . '"' . $_POST['nomeCliente'] . '"' . ')';
                        //    echo "sql2 = " . $sql2;
                        // call the stored procedure
                        $q2 = $pdo2->query($sql2);
                        if (!$q2) {
                            echo "\nPDO::errorInfo():\n";
                            print_r($pdo2->errorInfo());
                        }
                        $q2->setFetchMode(PDO::FETCH_ASSOC);
                    } catch (PDOException $e) {
                        die("Error occurred:" . $e->getMessage());
                    }
                    ?><table id="tabela" class="table table-striped table-hover">

                        <tr>
                            <th>Customer Name</th>
                            <th>City</th>
                            <th>State</th>
                            <th>Postal Code</th>
                            <th>Country</th>
                        </tr>
                        <?php while ($row2 = $q2->fetch()): ?>
                            <tr>
                                <td><?php echo $row2['customerName'] ?></td>
                                <td><?php echo $row2['city'] ?></td>
                                <td><?php echo $row2['state'] ?></td>
                                <td><?php echo $row2['postalCode'] ?></td>
                                <td><?php echo $row2['country'] ?></td>


                            </tr>

                            <?php
                        endwhile;
                    } else if (isset($_POST['pesquisar']) && !(empty($_POST['cidade']))) {
                        // execute the stored procedure
                        try {
                            $pdo3 = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
                            $sql3 = 'CALL GetCustomersByCity(' . '"' . $_POST['cidade'] . '"' . ')';
                            //    echo "sql2 = " . $sql2;
                            // call the stored procedure
                            $q3 = $pdo3->query($sql3);
                            if (!$q3) {
                                echo "\nPDO::errorInfo():\n";
                                print_r($pdo3->errorInfo());
                            }
                            $q3->setFetchMode(PDO::FETCH_ASSOC);
                        } catch (PDOException $e) {
                            die("Error occurred:" . $e->getMessage());
                        }
                        ?><table id="tabela" class="table table-striped table-hover">

                            <tr>
                                <th>Customer Name</th>
                                <th>City</th>
                                <th>State</th>
                                <th>Postal Code</th>
                                <th>Country</th>
                            </tr>
                            <?php while ($row3 = $q3->fetch()): ?>
                                <tr>
                                    <td><?php echo $row3['customerName'] ?></td>
                                    <td><?php echo $row3['city'] ?></td>
                                    <td><?php echo $row3['state'] ?></td>
                                    <td><?php echo $row3['postalCode'] ?></td>
                                    <td><?php echo $row3['country'] ?></td>


                                </tr>

                                <?php
                            endwhile;
                        }else if (isset($_POST['pesquisar']) && !(empty($_POST['pais']))) {
                        // execute the stored procedure
                        try {
                            $pdo4 = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
                            $sql4 = 'CALL GetCustomersByCountry(' . '"' . $_POST['pais'] . '"' . ')';
                            //    echo "sql2 = " . $sql2;
                            // call the stored procedure
                            $q4 = $pdo4->query($sql4);
                            if (!$q4) {
                                echo "\nPDO::errorInfo():\n";
                                print_r($pdo4->errorInfo());
                            }
                            $q4->setFetchMode(PDO::FETCH_ASSOC);
                        } catch (PDOException $e) {
                            die("Error occurred:" . $e->getMessage());
                        }
                        ?><table id="tabela" class="table table-striped table-hover">

                            <tr>
                                <th>Customer Name</th>
                                <th>City</th>
                                <th>State</th>
                                <th>Postal Code</th>
                                <th>Country</th>
                            </tr>
                            <?php while ($row4 = $q4->fetch()): ?>
                                <tr>
                                    <td><?php echo $row4['customerName'] ?></td>
                                    <td><?php echo $row4['city'] ?></td>
                                    <td><?php echo $row4['state'] ?></td>
                                    <td><?php echo $row4['postalCode'] ?></td>
                                    <td><?php echo $row4['country'] ?></td>


                                </tr>

                                <?php
                            endwhile;
                        }else if (isset($_POST['pesquisar']) && !(empty($_POST['estado']))) {
                        // execute the stored procedure
                        try {
                            $pdo5 = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
                            $sql5 = 'CALL GetCustomersByEstado(' . '"' . $_POST['estado'] . '"' . ')';
                            //    echo "sql2 = " . $sql2;
                            // call the stored procedure
                            $q5 = $pdo5->query($sql5);
                            if (!$q5) {
                                echo "\nPDO::errorInfo():\n";
                                print_r($pdo5->errorInfo());
                            }
                            $q4->setFetchMode(PDO::FETCH_ASSOC);
                        } catch (PDOException $e) {
                            die("Error occurred:" . $e->getMessage());
                        }
                        ?><table id="tabela" class="table table-striped table-hover">

                            <tr>
                                <th>Customer Name</th>
                                <th>City</th>
                                <th>State</th>
                                <th>Postal Code</th>
                                <th>Country</th>
                            </tr>
                            <?php while ($row5 = $q5->fetch()): ?>
                                <tr>
                                    <td><?php echo $row5['customerName'] ?></td>
                                    <td><?php echo $row5['city'] ?></td>
                                    <td><?php echo $row5['state'] ?></td>
                                    <td><?php echo $row5['postalCode'] ?></td>
                                    <td><?php echo $row5['country'] ?></td>


                                </tr>

                                <?php
                            endwhile;
                        }
                    ?>
                </table>
                </body>
                </html>
