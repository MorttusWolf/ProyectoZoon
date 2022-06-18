CargarZoom=(usuario, nombre, contrasenia, DetallesUsuario)=> {
    CurrentUser = new IniciarZoom(usuario, nombre, contrasenia, DetallesUsuario)
    window.localStorage.setItem("Sesion", JSON.stringify(CurrentUser))
    window.location.assign("../Zoom.php")
}
tg = (x/* la etiqueta con la que se toma el evento */, y /* la propiedad o accion única del evento */) => {return y.target.matches(x)}
function CerrarZoom(){
    window.location.assign("../../index.html")
}
function ReiniciarZoom(){
    window.location.reload()
}
function IniciarUsuario() {
    console.log("Usted esta iniciando un usuario")
}