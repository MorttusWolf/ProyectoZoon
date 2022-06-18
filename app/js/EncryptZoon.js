class encryptZoon{
    constructor(type, text, code){
        this.tipo = type;
        this.texto = text.split("");
        this.codigo = code.split("");
        this.result = "OxOc";
        this.accion(this.tipo)
    }
    accion(tipo){
        if (tipo = "encriptar"){
            this.encryptData(this.texto, this.codigo)
        } else{
            this.descryptData(this.texto, this.codigo)
        }
    }
    encryptData(x, y){
        y.forEach((Ye, Yi)=>{
            x.forEach((Xe, Xi) => {
                if (!(Yi%2==0)){
                    this.result += `${Xi}${Ye}`
                }else{
                    this.result = `0x${Xi}P${Xe}${Yi}`
                    Yi = Xi;
                    Xi = 0;
                }
                if ((Yi!=Xi)&&!(Yi%3==1)){
                    this.result += `${Yi}${Xi}${Xe}${Ye}`
                }else{
                    this.result = `0x${Yi+Xi}?${Yi}${Xi}${Xe}${Ye}`;
                    Yi -= 1;
                }
            })
        });
        this.result += "0x0e"
        console.log(this.result)
    }
}