class animatedObjs {
 constructor(led, background, animate1, animate2, delay) {
  // DEFINE LOS PARAMETROS INICIALES
  this.animacion = [animate1, animate2];
  this.pantalla = document.querySelector(`.${led}`);
  this.fondo = document.querySelector(`.${background}`);
  this.retraso = delay * 1000
  this.begin_animate(this.animacion[0], led);
  this.finish_animate(this.animacion[1], background);
 }
 defined_animation(animacion) {
  //  Define el tipo de animacion enviada
  this.typeanimated = null;
  switch (animacion) {
   case `natural`:
    this.typeanimated = ``;
    break;
   case `apear`:
    this.typeanimated = `Aparecer`;
    break;
   case `darken`:
    this.typeanimated = `Oscurecer`;
    break;
   case `null`:
    this.typeanimated = `Activar`;
    break;
  }
 }
 delay_animation() {
  //  si tiene unretrazo se realiza
  if (this.retraso) {
   setTimeout(() => {
    console.log(`${this.retraso} contados`);
   }, this.retraso);
  } else {
   console.log(`no hay cuenta`);
  }
 }
 begin_animate(animacion, destinate) {
  this.defined_animation(animacion);
  //  Definir los estilos iniciales y cambiar la clase
  if (this.pantalla.hasAttribute(`style`)) {
   this.pantalla.setAttribute(
    `class`,
    `${this.typeanimated} ${destinate}`
   );
   this.delay_animation();
  } else {
    this.pantalla.setAttribute(
   `class`,
   `${this.typeanimated} ${destinate}`
  );
  this.delay_animation();}
 }
 finish_animate(animacion, origin) {
  // Segunda animacion si la hay
  if (animacion) {
   this.defined_animation(animacion);
   //  Definir los estilos iniciales y cambiar la clase
   if (this.fondo.hasAttribute(`style`)) {
    this.fondo.setAttribute(`class`, `${this.typeanimated} ${origin}`);
    this.delay_animation();
   }
   this.fondo.setAttribute(`class`, `${this.typeanimated} ${origin}`);
   this.delay_animation();
  } else {
   console.log(`no hay segunda animacion`);
  }
 }
}
