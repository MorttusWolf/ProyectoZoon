<?php
function GenKey($len, $random, $table, $colunm){
    $result="";
    $response=null;
    $bucle=true;
    do {
        if ($random==true) {
            for ($i=0; $i < $len; $i++) { 
                $coderesponse[$i] = random_int(0, 2);
                if ($coderesponse[$i] == 1) {
                    $coderesponse[$i] = random_int(65, 88);
                    $coderesponse[$i] = chr($coderesponse[$i]);
                }elseif ($coderesponse[$i] == 2) {
                    $coderesponse[$i] = random_int(97, 122);
                    $coderesponse[$i] = chr($coderesponse[$i]);
                }else {
                    $coderesponse[$i] = random_int(0, 9);
                }
                $result = $result.$coderesponse[$i];
            }
            $response = mysqli_query($_SESSION['MasterConnect'], "SELECT $colunm FROM $table WHERE $colunm RLIKE('.*$result.*')");
            $response = $response->fetch_assoc();
            echo $response;
            if ($response == null or $response != $result) {
                $bucle=false;
            }
        }else{
            $response = mysqli_query($_SESSION['MasterConnect'], "SELECT max($colunm) FROM $table");
            $response = $response->fetch_assoc();
            if ($response==null or $response==""){
                $bucle=false;
                $result='no hay codigos';
                echo $result;
            }else {
                foreach ($response as $key => $value) {
                    $result = $value + 1;
                    $bucle=false;
                    echo $result;
                }
            }

        }
    } while ($bucle != false);
    return $result;
}
?>