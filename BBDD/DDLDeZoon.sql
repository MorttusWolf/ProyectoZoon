/*Crear base de datos con el lenguaje apropiado*/
DROP DATABASE IF EXISTS Zoon;
CREATE DATABASE Zoon CHARACTER SET utf8mb4 COLLATE utf8mb4_nopad_bin;
Use Zoon;
/*Definicion de la base de datos del proyecto en curso*/
Create table Factorages(
    ID_Factorage varchar(18) not null PRIMARY KEY, 
    _Cobro float not null,
    _Fondos float not null,
    _Recaudos float not null,
    _Entidad varchar(20) not null
)ENGINE=INNODB;
CREATE TABLE Usuarios(
    Usr_Identificacion varchar(18) not null DEFAULT concat(Identificacion, _TipoIdentificacion, _FechaNacimiento) PRIMARY KEY,
    Identificacion integer(10) not null,
    _TipoIdentificacion varchar(2) not null default "CC",
    _FechaNacimiento integer(6) not null,
    __actividad boolean DEFAULT true,
    _PrimerNombre text not null,
    _OtrosNombres text null,
    _NombreDePila text not null,
    _UltimoNombre text null
)ENGINE=INNODB;
CREATE TABLE Contactos(
    no varchar(30) not null DEFAULT concat(ID_Contacto,"-", Usr_Identificacion),
    ID_Contacto varchar(8) not null,
    Usr_Identificacion varchar(18) not null, 
    __Celular integer(10) unique, 
    __IndicativoCelular text not null default "+57",
    __Correo text null unique,
    __OrganizacionCorreo text not null default "@gmail.com",
    __Telefono integer(7) unique, 
    __IndicativoTelefono text not null default "601",
    PRIMARY KEY (no),
    INDEX ContactosUsuarios(`no`, `Usr_Identificacion`), 
    CONSTRAINT `Fk_ConUsr`
        FOREIGN KEY (Usr_Identificacion) REFERENCES `Usuarios` (Usr_Identificacion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Proveedores(
    ID_Proveedor varchar(20) not null default concat(Usr_Identificacion,"pp"), 
    Usr_Identificacion varchar(18) not null,
    _Marca text null,
    PRIMARY KEY(ID_Proveedor),
    INDEX ProveedorUsuario(`ID_Proveedor`, `Usr_Identificacion`), 
    CONSTRAINT `Fk_ProUrs`
        FOREIGN KEY (Usr_Identificacion) REFERENCES `Usuarios` (Usr_Identificacion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Empleados(
    ID_Empleado varchar(20) not null default concat(Usr_Identificacion,"ee"), 
    Usr_Identificacion varchar(18) not null,
    __Sueldo float not null default 1015000.00, 
    __Puesto text not null default "empleado",
    PRIMARY KEY(ID_Empleado), 
    INDEX EmpleadoUsuario(`ID_Empleado`, `Usr_Identificacion`),
    CONSTRAINT `Fk_EmpUsr`
        FOREIGN KEY (Usr_Identificacion) REFERENCES `Usuarios`(Usr_Identificacion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Clientes(
    ID_Cliente varchar(20) not null default concat(Usr_Identificacion, "uu"), 
    Usr_Identificacion varchar(18) not null, 
    Clt_ID_Cliente varchar(20) null,
    _Bono boolean not null default false, 
    _BancaPuntos float not null default 0.00,
    _Billetera float null, 
    _Custodiado float not null default false, 
    _Nickname text null,
    PRIMARY KEY(ID_Cliente), 
    INDEX ClienteUsuario(`ID_Cliente`, `Usr_Identificacion`), 
    INDEX ClienteCliente(`ID_Cliente`, `Clt_ID_Cliente`),
    CONSTRAINT `Fk_CliUsr`
        FOREIGN KEY (Usr_Identificacion) REFERENCES `Usuarios` (Usr_Identificacion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    CONSTRAINT `Fk_CliCli`
        FOREIGN KEY(Clt_ID_Cliente) REFERENCES `Clientes`(ID_Cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Custodiados (
    no integer unsigned AUTO_INCREMENT not null,
    _IDCustodiado varchar(20) not null,
    _IDGuardian varchar(20) not null,
    __Relacion text(500) null,
    PRIMARY KEY (no),
    INDEX CustodiadosCliente(`no`, `_IDCustodiado`), 
    INDEX CustodiadosGuardian(`no`, `_IDGuardian`),
    CONSTRAINT `Fk_CusCli`
        FOREIGN KEY (_IDCustodiado) REFERENCES `Clientes`(ID_Cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        FOREIGN KEY (_IDGuardian) REFERENCES `Clientes`(ID_Cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE TipoFacturas(
    ID_TipoFactura integer(1) unsigned not null default 0 PRIMARY KEY,
    Detalles text not null default "Factura o factorage invalido, por favor intete el procedimiento nuevamente"
)ENGINE=INNODB;
INSERT INTO TipoFacturas(ID_TipoFactura, Detalles)
Values (1, "Venta"),
       (2, "Compra"),
       (3, "Inversion"),
       (default, default);
CREATE TABLE Facturas(
    ID_Factura varchar(20) not null default concat(NFactura,"-", TipoFactura),
    NFactura varchar(18) not null,
    TipoFactura integer(1) unsigned not null, 
    ID_Empleado varchar(20) not null, 
    ID_Cliente varchar(20) null, 
    ID_Proveedor varchar(20) null,
    _CosteTotal float not null default 0.00, 
    _FechaFactura date,
    PRIMARY KEY (ID_Factura),
    INDEX FacturaTFactura(`ID_Factura`, `TipoFactura`),
    INDEX FacturaEmpleado(`ID_Factura`, `ID_Empleado`), 
    INDEX FacturaCliente(`ID_Factura`, `ID_Cliente`), 
    INDEX FacturaProveedor(`ID_Factura`, `ID_Proveedor`), 
    CONSTRAINT `Fk_FacTfa`
        FOREIGN KEY(TipoFactura) REFERENCES `TipoFacturas`(ID_TipoFactura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT `Fk_FacEmp`
        FOREIGN KEY(ID_Empleado) REFERENCES `Empleados`(ID_Empleado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT `Fk_FacCli`
        FOREIGN KEY(ID_Cliente) REFERENCES `Clientes`(ID_Cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT `Fk_facPro`
        FOREIGN KEY(ID_Proveedor) REFERENCES `Proveedores`(ID_Proveedor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Historialcompras(
    no varchar(30) not null DEFAULT concat(ID_HistorialCompras,"-", Usr_Identificacion),
    ID_HistorialCompras varchar(8) not null,
    Usr_Identificacion varchar(18) not null,
    Frt_ID_Factura varchar(18) not null,
    _NumeroDeCompras integer not null default 0,
    PRIMARY KEY (no), 
    INDEX HistorialcomprasFacturas(`no`, `Frt_ID_Factura`), 
    INDEX HistorialcomprasUsuarios(`no`, `Usr_Identificacion`),
    CONSTRAINT `Fk_HCfact`
        FOREIGN KEY(Frt_ID_Factura) REFERENCES `Facturas` (ID_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT `Fk_HCUsua`
        FOREIGN KEY(Usr_Identificacion) REFERENCES `Usuarios`(Usr_Identificacion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Promocion(
    ID_Promocion varchar(18) not null,
    Emp_IdentificacionEmp varchar(20) not null,
    _FechaInicial date not null, 
    _lapso varchar(4) not null default "0100",
    PRIMARY KEY(ID_Promocion), 
    INDEX PromocionEmpleado(`ID_Promocion`, `Emp_IdentificacionEmp`), 
    CONSTRAINT `Fk_ProEmp`
        FOREIGN KEY(Emp_IdentificacionEmp) REFERENCES `Empleados`(ID_Empleado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE ContenidoProm(
    no varchar(30) not null default concat(ID_ContenidoPublicidad, "-", Prm_ID_Publicidad),
    ID_ContenidoPublicidad varchar(8) not null,
    Prm_ID_Publicidad varchar(18) not null,
    _limite integer null,
    _DescuentoPuntos float not null,
    _DescuentoAdicional float null,
    PRIMARY KEY(no),
    INDEX ContenidoPromPromocion(`no`, `Prm_ID_Publicidad`), 
    CONSTRAINT `Fk_ConPro`
        FOREIGN KEY(Prm_ID_Publicidad) REFERENCES `Promocion`(ID_Promocion) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE DetallesFactorage(
    no integer unsigned AUTO_INCREMENT not null,
    Fct_IDFactura varchar(20) not null,
    Ftg_IDFactorage varchar(18) not null,
    _inversion float null, 
    PRIMARY KEY(no),
    INDEX DetallesFactorageFactura(`no`, `Fct_IDFactura`), 
    INDEX DetallesFactorageFactorage(`no`, `Ftg_IDFactorage`), 
    CONSTRAINT `Fk_DftFac`
        FOREIGN KEY(Fct_IDFactura) REFERENCES `Facturas`(ID_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    CONSTRAINT `Fk_DftFtg`
        FOREIGN KEY(Ftg_IDFactorage) REFERENCES `Factorages`(ID_Factorage)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Inventarios(
    ID_inventario varchar(18) not null PRIMARY KEY, 
    _Acumulacion integer not null default 0
)ENGINE=INNODB;
CREATE TABLE Productos(
    ID_Producto varchar(18) not null, 
    Inv_ID_inventario varchar(18) not null, 
    _FechaAdquisicion date not null, 
    _FechaFabricacion date not null, 
    nombreProducto text not null, 
    PRIMARY KEY(ID_Producto), 
    INDEX ProductosInventarios(`ID_Producto`, `Inv_ID_inventario`), 
    CONSTRAINT `Fk_ProInv`
        FOREIGN KEY(Inv_ID_inventario) REFERENCES `Inventarios`(ID_inventario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE DetallesFactura(
    ID_FacturaMas varchar(18) not null, 
    Fct_ID_Factura varchar(18) not null, 
    Prt_ID_Producto varchar(18) not null, 
    _CostoxUnidad float not null, 
    _Cantidad integer not null default 0,
    PRIMARY KEY(ID_FacturaMas), 
    INDEX DetallesFacturaFacturas(`ID_FacturaMas`, `Fct_ID_Factura`), 
    INDEX DetallesFacturaProductos(`ID_FacturaMas`, `Prt_ID_Producto`),
    CONSTRAINT `Fk_DcfFac`
        FOREIGN KEY(Fct_ID_Factura) REFERENCES `Facturas`(ID_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    CONSTRAINT `Fk_DcfPro`
        FOREIGN KEY(Prt_ID_Producto) REFERENCES `Productos`(ID_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Caracteristicas(
    no varchar(30) not null default concat(ID_Caracteristicas, "-", Prt_ID_Producto), 
    ID_Caracteristicas varchar(8) not null, 
    Prt_ID_Producto varchar(18) not null, 
    categoria text null, 
    descripcion varchar(200) null, 
    _Puntuacion float(2) not null,
    __generacion integer(1) not null, 
    color varchar(20) null, 
    PRIMARY KEY(no), 
    INDEX CaracteristicasProductos(`no`, `Prt_ID_Producto`), 
    CONSTRAINT `Fk_CrtPrt`
        FOREIGN KEY(Prt_ID_Producto) REFERENCES `Productos`(ID_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE Almacenes(
    ID_Almacen varchar(18) not null, 
    Inv_ID_inventario varchar(18) not null,
    _Longitud float null, 
    PRIMARY KEY(ID_Almacen), 
    INDEX AlmacenInventarios(`ID_Almacen`, `Inv_ID_inventario`), 
    CONSTRAINT `Fk_AlmInv`
        FOREIGN KEY(Inv_ID_inventario) REFERENCES `Inventarios`(ID_inventario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
CREATE TABLE ContenidoLt(
    no varchar(30) not null default concat(ID_ContenidoAlmacen, "-", Alm_ID_Almacen), 
    ID_ContenidoAlmacen varchar(8) not null, 
    Alm_ID_Almacen varchar(18) not null, 
    _CantidadTotal integer not null default 0, 
    PRIMARY KEY (no), 
    INDEX ContenidoLtAlmacen(`no`, `Alm_ID_Almacen`), 
    CONSTRAINT `Fk_CLtAlm`
        FOREIGN KEY(Alm_ID_Almacen) REFERENCES `Almacenes`(ID_Almacen)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)ENGINE=INNODB;
