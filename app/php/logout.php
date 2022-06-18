<?php 
session_start();
    session_unset();
    if (isset($_SESSION['MasterUserNickname'])) {
        echo $_SESSION['MasterUserNickname'];
    }else{
        echo 'none one set';
    }
    header("Location: //$_SERVER[HTTP_HOST]/Zoon/index.html");
?>