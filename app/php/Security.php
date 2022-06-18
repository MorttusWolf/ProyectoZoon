<?php
    if (!isset($_SESSION['MasterUserNickname'])){
        header("Location: //$_SERVER[HTTP_HOST]/Zoon/index.html");
    }
?>