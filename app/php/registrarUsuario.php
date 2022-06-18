<?php
    $nick="";
    if ($_POST['CliCustodiado']=="true") {
        $CliGuardian[0] = $_POST['CliDocumentoG'];
        $CliGuardian[1] = $_POST['CliTipoDocumentoG'];
        $RelacionCliCli = $_POST['CliCusRelacion'];
        //mysqli_query($_SESSION['MasterConnect'], "INSERT INTO " );
    }
    if ($Regnombre[1]=="") {
        $nick=0;
    }else{
        $nick=1;
    }
    mysqli_query($_SESSION['MasterConnect'], 
    "INSERT INTO clientes(Usr_Identificacion, Clt_ID_Cliente, _Nickname)
    VALUES ((SELECT Usr_Identificacion FROM usuarios WHERE Identificacion = $RegDocumento[1]), DEFAULT, '$Regnombre[$nick].$RegNacimiento')
        ON duplicate KEY UPDATE Usr_Identificacion = Usr_Identificacion"
    );
    require 'Security.php'
    SesionCheck('')
?>