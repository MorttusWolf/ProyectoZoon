class LoadZoon{
    constructor(){
        this.DoEventList()
        this.SetLedAtributes(innerHeight, innerWidth)
    //        this.Sets= new SettingsGlobals()
    }

    SetLedAtributes=(x, y)=>{
        document.querySelector(`.MenuPrl`).setAttribute("style", `height:${x}px; width:${y}px`)
    }
    AnimatePages=(led, bg, animation)=>{
        switch (animation) {
            case "MostrarReg":
                new animatedObjs(led, bg, "apear", "darken", 0.3)
                new animatedObjs("RegbUsers", "RegbProducts", "null", "natural", 0.1)
                new animatedObjs("ProP", "UserP", "natural", "null", 0.1)
                this.beginUsersPage()
                break;
            case "OcultarReg":
                new animatedObjs(led, bg, "natural", "natural", 0.3);
                break;
            case "MostrarProductos":
                new animatedObjs(led, bg, "natural", "null", 0.1)
                new animatedObjs("ProP", "UserP", "null", "natural", 0.1)
                new animatedObjs("RegbUsers2", "RegbUsers1", "natural", "natural", 0.1)
                break;
            case "MostrarUsuarios":
                new animatedObjs(bg, led, "null", "natural", 0.1)
                new animatedObjs("ProP", "UserP", "natural", "null", 0.1)
                this.beginUsersPage()
                break;
            case "DesplegarClientes":
                new animatedObjs(led, bg, "natural", "null", 0.1)
                new animatedObjs("SelectClis", "SelectPros", "null", "natural", 0.1)
                break;
            case "DesplegarProveedores":
                new animatedObjs(led, bg, "natural", "null", 0.1)
                new animatedObjs("SelectPros", "SelectClis", "null", "natural", 0.1)
                break;
            case "AlertNuevoUsuario":
                new animatedObjs(led, bg, "apear", "darken", 0.3)
                this.FillContent(`.${led}s`, "NewUserSlave")
                break;
            default:
                console.log("animacion no creada")
                break;
        }
    }
    FillContent(clase, action){
        switch (action) {
            case "NewUserSlave":
                
                break;
        
            default:
                break;
        }
        clase.innerHTML="<p>hola buenas</p>"
    }
    beginUsersPage(){
        new animatedObjs(`RegbUsers2`,`RegbUsers1`,`natural`,`null`, 0.1)
        new animatedObjs(`SelectPros`, `SelectClis`, `natural`, `null`, 0.1)
    }
    setItem=(value)=>{
        let origin = window.document
        .querySelector(`#TypeReg`)
        .getAttribute(`value`)
        if(origin === value){
            return console.log(value)
        }else{
            window.document
            .querySelector(`#TypeReg`)
            .setAttribute(`value`, value)
        }
    }
    DoEventList(){
    document.addEventListener(`click`, (ev)=>{
        if (tg(`#Register`, ev)){
            this.AnimatePages("Registros", "MenuPrl", "MostrarReg")
            this.setItem("UserCli")
        }else if(tg(`#ComeBackRegisters`, ev)) {
            this.AnimatePages("MenuPrl", "Registros", "OcultarReg")
        }else if(tg(`#ProPage`, ev)) {
            this.AnimatePages("RegbUsers", "RegbProducts", "MostrarProductos") 
            this.setItem("Prodcuts")
        }else if(tg(`#UserPage`, ev)) {
            this.AnimatePages("RegbProducts", "RegbUsers", "MostrarUsuarios")
        }else if(tg(`#UserCli`, ev)) {
            this.AnimatePages("RegbUsers2", "RegbUsers1", "DesplegarClientes") 
            this.setItem("UserCli")
        }else if(tg(`#UserPro`, ev)) {
            this.AnimatePages("RegbUsers1", "RegbUsers2", "DesplegarProveedores")
            this.setItem("UserPro")
        }else if (tg(`#LoginUser`, ev)) {
            this.AnimatePages("Alert", "MenuPrl", "AlertNuevoUsuario")
            IniciarUsuario()
        } else {
            
        }
    })
    }
}
window.document.addEventListener(`DOMContentLoaded`, ()=>{
    new LoadZoon()
}
)