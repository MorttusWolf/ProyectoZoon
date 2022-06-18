class IniciarZoom {
    constructor(conexion, nombre, codificacion, detalles){
        this.user = nombre;
        this.conection = conexion;
        this.contrasenia = codificacion;
        this.details = detalles;
        this.cargarapp();
    }
    cargarapp(){
        console.log(`conexion realizada con exito ${this.conection}`)
        this.cargarpagina(this.user)
    }
    cargarpagina(x){
        window.alert(`Bienvenido de vuelta ${x}`)
    }
    
}

