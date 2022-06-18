<?php
session_start();
    //registrar Elementos en la BBDD de zoo
    $Regnombre[0] = $_POST['RegNombre'];
    $Regnombre[1] = $_POST['RegNombre2'];
    $Regnombre[2] = $_POST['RegApellido'];
    $Regnombre[3] = $_POST['RegApellido2'];

    $RegNacimiento = $_POST['RegFechaNa'];

    $RegNumero[0] = $_POST['RegIndiceNum'];
    $RegNumero[1] = $_POST['RegNumero'];
    $RegNumero[2] = $_POST['RegIndiceTel'];
    $RegNumero[3] = $_POST['RegTelefono'];

    $RegEmail[1] = $_POST['RegCorreo'];
    $RegEmail[0] = $_POST['RegDominioCorreo'];

    switch ($_POST['CliTipoDocumento']) {
        case 1:
            $RegDocumento[0] = "CC";
            break;
        case 2:
            $RegDocumento[0] = "CE";
            break;
        case 3:
            $RegDocumento[0] = "TI";
    }
    $RegDocumento[1] = $_POST['CliDocumento'];
    
    $_SESSION['MasterConnect'] = mysqli_connect($_SESSION['MasterUserServices'], $_SESSION['MasterUserNickname'], $_SESSION['MasterUserPassword'], "zoom");

    mysqli_query($_SESSION['MasterConnect'],
     "INSERT INTO usuarios(Identificacion, _TipoIdentificacion, _FechaNacimiento, __actividad, _PrimerNombre, _OtrosNombres, _NombreDePila, _UltimoNombre)
     VALUES ($RegDocumento[1], '$RegDocumento[0]', $RegNacimiento, true, '$Regnombre[0]', '$Regnombre[1]', '$Regnombre[2]', '$Regnombre[3]')
     ON DUPLICATE KEY UPDATE Identificacion=$RegDocumento[1]");
    require "GeneradorClave.php";
    $CodeGen1 = GenKey(8, true, "contactos", "ID_Contacto");
    mysqli_query($_SESSION['MasterConnect'],
    "INSERT INTO contactos(ID_Contacto, Usr_Identificacion, __Celular, __IndicativoCelular, __Correo, __OrganizacionCorreo, __Telefono, __IndicativoTelefono)
     VALUES('$CodeGen1', (SELECT Usr_Identificacion FROM usuarios WHERE Identificacion=$RegDocumento[1]), $RegNumero[1], $RegNumero[0], '$RegEmail[1]', '$RegEmail[0]', $RegNumero[3], $RegNumero[2])
     ON DUPLICATE KEY UPDATE __Correo = '$RegEmail[1]'"
);

    $TipoReg = $_POST['TypeReg'];
    switch ($TipoReg) {
        case 'UserCli':
            require "registrarUsuario.php";
            break;
        case `UserPro`:
            require "registrarProveedor.php";
            break;
    }
?>
