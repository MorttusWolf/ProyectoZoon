<?php
    if (!isset($_SESSION['MasterUserNickname'])){
        header("Location: //$_SERVER[HTTP_HOST]/Zoom/index.html");
    }
?>