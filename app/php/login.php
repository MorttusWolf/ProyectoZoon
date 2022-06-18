<?php
        try {
            session_start();
            if ($_POST["LoginNickname"]==null) {
                throw new Exception("No digito ningun usuario, intentelo de nuevo", 1);
            } else{
                $nombre= $_POST["LoginNickname"];
            }
            if ($_POST["LoginPassword"]==null) {
                throw new Exception("No digito ninguna contraseña, intentelo de nuevo", 2);
            } else {
                $contrasenia= $_POST["LoginPassword"];
            }

            if(!($Services = $_SERVER["HTTP_HOST"])){
                throw new Exception("Por favor inicie sesion desde direccion IP válida", 4);
            }elseif (!($user = mysqli_connect($Services, $nombre, $contrasenia, "zoom"))) {
                throw new Exception("Usuario no existente en la Red con ip $Services, intentelo de nuevo", 3);
            }
            else {
                $DataUser[0] = mysqli_get_host_info($user);
                $response = mysqli_query(mysqli_connect("localhost", "root", "", "mysql"), "SELECT * FROM `user` WHERE user.User='$nombre' AND user.Host='$Services'");
                $DataUser[1] = $response->fetch_assoc();
             ?>
             <script src="../js/IniciarZoom.js"></script>
             <script src="../js/ZoomApp_Funciones.js"></script>
             <script src="../js/EncryptZoom.js"></script>
             <script type="text/javascript">
                document.addEventListener(`DOMContentLoaded`, (ev) =>{
                    let codigo =  "<?php echo $Services.$nombre ?>"
                    let texto = new encryptZoom("encriptar", "<?php echo $contrasenia ?>", codigo)
                    CargarZoom( "<?php echo $DataUser[0] ?>", "<?php echo $nombre ?>", [codigo, texto.result], 
                    {<?php foreach ($DataUser[1] as $key => $value) {
                        echo $key.":"."'$value'".",";  
                    }?>});
                })
             </script>
             <?php
             $_SESSION['MasterUserNickname']=$nombre;
             $_SESSION['MasterUserPassword']=$contrasenia;
             $_SESSION['MasterUserServices']=$Services;
             $_SESSION['MasterConnect']=$user;
            }
        } catch (\Exception $ex) {
            switch ($ex->getCode()) {
                case 1:
                    ?>
                    <script type="text/javascript">
                        window.alert("<?php echo $ex->getMessage() ?>")
                        window.location.assign("../../index.html")
                    </script>
                    <?php
                    break;
                case 2:
                    ?>
                    <script type="text/javascript">
                        window.alert("<?php echo $ex->getMessage() ?>")
                        window.location.assign("../../index.html")
                    </script>
                    <?php
                    break;
                case 3:
                    ?>
                    <script type="text/javascript">
                        window.alert("<?php echo $ex->getMessage() ?>")
                        window.location.assign("../../index.html")
                    </script>
                    <?php
                case 4:
                    ?>
                    <script type="text/javascript">
                        window.alert("<?php echo $ex->getMessage() ?>")
                        window.location.assign("../../index.html")
                    </script>
                   <?php
                case 1044:
                    ?>
                    <script type="text/javascript">
                        window.alert("Acceso denegado para el usuario <?php echo $nombre ?>")
                        window.location.assign("../../index.html")
                    </script>
                    <?php
                case 1045:
                    ?>
                    <script type="text/javascript">
                        window.alert("Usuario o contraseña incorrectos, intentelo de nuevo")
                        window.location.assign("../../index.html")
                    </script>
                    <?php
                case 2002:
                    ?>
                    <script type="text/javascript">
                        window.alert("Servidor IP no registrado, inicie sesion desde un dispositivo autorizado")
                        window.location.assign("../../index.html")
                    </script>
                    <?php
                default:
                    echo "no se puede procesar porque ".$ex->getCode()." a ocurrido<br>".$ex->getMessage();
                    break;
            }
        }    
?>