create database EMPRESA

SET DATEFORMAT dmy

use EMPRESA

/*INSERTADO*/
create table empleado
(	codigo_empleado int primary key,
	apellido char(50)not null,
	nombre char(50) not null,
	fecha_nacimiento datetime,
	codigo_jefe int not null,
	codigo_oficina int not null,
	numero_documento char(8)not null,
	codigo_documento int not null,
	foreign key (codigo_oficina)
	references oficina(codigo_oficina)
	on update cascade on  delete no action,
	foreign key(codigo_documento)
	references documento(codigo_documento)
	on update cascade on  delete no action	
);

/*INSERTADO*/
create table datos_contrato 
( 	codigo_empleado int primary key,
	fecha_contrato datetime not null,
	cuota money not null,
	ventas money,
	foreign key(codigo_empleado)
	references empleado(codigo_empleado)
	on update cascade on delete no action 
);


/*INSERTADO*/
create table documento 
(
	codigo_documento int primary key identity(1,1),
	descripcion char(50)
);


/*INSERTADO*/
create table producto 
(	codigo_producto int primary  key identity(1001,1),
	descripcion char(50),
	precio_costo money default 0,
	codigo_fabricante int,
	foreign key(codigo_fabricante)
	references fabricante(codigo_fabricante)
	on update cascade on delete no action
);


/*INSERTADO*/
create table stock   
( 	
	codigo_producto int primary key,
	cantidad numeric not null default 0,
	pto_reposicion numeric default 0,
	foreign key (codigo_producto)
	references producto(codigo_producto)
	on update cascade on delete no action			
);


/*INSERTADO*/
create table fabricante
 (
	codigo_fabricante int primary key identity(1,1),
	 razon_social char(50) not null
);


/*INSERTADO*/

create table precio_venta
(	
	codigo_producto int ,
	codigo_lista int ,
	precio money not null default 0,
	primary key(codigo_producto,codigo_lista),
	foreign key(codigo_producto)
	references producto(codigo_producto)
	on update cascade on delete no action,
	foreign key(codigo_lista)
	references lista(codigo_lista)
	on update cascade on delete no action
);


/*INSERTADO*/
create table cliente 
(	
	codigo_cliente int primary key identity(1,1),
	codigo_lista int not null,
	razon_social char(50) not null,
	foreign key(codigo_lista)
	references lista(codigo_lista)
	on update cascade on delete no action
);


/*INSERTADO*/
create table pedido
(
	codigo_pedido int primary key identity(1,1),
	fecha_pedido datetime not null,
	codigo_empleado int not null,
	codigo_cliente int not null,
	foreign key(codigo_empleado)
	references empleado(codigo_empleado)
	on update cascade on delete no action,
	foreign key(codigo_cliente)
	references cliente(codigo_cliente)
	on update cascade on delete no action				  

);


/*INSERTADO*/
create table  detalle_pedido 
(	
	codigo_pedido int,
	numero_linea int,
	codigo_producto int not null,
	primary key(codigo_pedido,numero_linea),
	foreign key(codigo_pedido)
	references pedido(codigo_pedido) 
	on update cascade on delete no action,
	foreign key(codigo_producto )
	references producto(codigo_producto)
	on update cascade on delete no action
);


/*INSERTADO*/
create table lista
(	
	codigo_lista int primary key identity(1,1),
	descripcion char(20) not null,
	ganancia_porcentaje numeric(5,2) not null
);

/*INSERTADO*/
create table oficina
(
	codigo_oficina int primary key identity(1,1),
	codigo_director int,
	descripcion char(50) not null
);


insert into documento(descripcion)values('Documento Nacional de Identidad')
insert into documento(descripcion)values('Cédula de Identidad')
insert into documento(descripcion)values('Pasaporte')
insert into documento(descripcion)values('Libreta de Enrolamiento')

select * from documento

insert into oficina(descripcion,codigo_director)values('Presidencia',101)
insert into oficina(descripcion,codigo_director)values('Gerencia',102)
insert into oficina(descripcion,codigo_director)values('Ventas Interior',104)
insert into oficina(descripcion)values('Ventas Exterior')

select * from oficina 

insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(101,'Viguer','Antonio','20/05/56',12456897,0,1,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(102,'Jaumes','Alvaro','30/03/55',12654897,101,2,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(103,'Rovira','Juan','21/06/60',15789546,102,3,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(104,'Gonzales','Analia','23/04/58',13456789,102,3,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(105,'Pantalla','Marcela','02/12/63',14875987,102,3,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(106,'Bustamante','Jorge','05/05/63',4756984,102,3,2)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(107,'Sunta','Maria','21/06/70',16789547,101,2,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(108,'Victor','Juan','18/09/66',13854789,107,4,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(109,'Alvarez ','Adriana','30/09/56',12465879,107,4,1)
insert into empleado(codigo_empleado,apellido,Nombre,fecha_nacimiento,numero_documento,codigo_jefe,codigo_oficina,codigo_documento)values(110,'Clavel','Maria','02/07/64',99875987,107,4,3)

select * from empleado

insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(101,'20/01/98',57000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(102,'15/03/98',57000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(103,'10/06/99',57000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(104,'21/04/97',45000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(105,'13/05/98',45000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(106,'21/06/99',45000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(107,'14/06/97',45000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(108,'15/03/95',120000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(109,'12/03/87',120000)
insert into datos_contrato(codigo_empleado,fecha_contrato,cuota)values(110,'15/06/88',90000)

select * from datos_contrato

insert into fabricante(razon_social)values('ABC Comercial')
insert into fabricante(razon_social)values('General de Negocios S.A.')
insert into fabricante(razon_social)values('Tomasti Hnos.')
insert into fabricante(razon_social)values('Basic')
insert into fabricante(razon_social)values('Ferreteria Sudamericana')
insert into fabricante(razon_social)values('Pampas S.R.L.')

select * from fabricante

insert into lista(descripcion,ganancia_porcentaje)values('Mayorista',20)
insert into lista(descripcion,ganancia_porcentaje)values('Minorista',30)

select * from lista

insert into producto(descripcion,precio_costo,codigo_fabricante)values('Arandela',0.50,1)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Bisagra',1,2)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Extractor',135,3)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Junta',21,2)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Cubo',350,4)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Perno',21,5)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Red',821,3)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Escofina',35,2)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Bomba V6',1012,1)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Rele',35,3)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Bagueta A3',48,5)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Ventilador',289,1)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Linterna 2X',28,2)
insert into producto(descripcion,precio_costo,codigo_fabricante)values('Linterna 3X',38,2)

select * from producto


insert into stock(codigo_producto,cantidad,pto_reposicion)values(1001,1000,1000)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1002,1500,1000)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1003,450,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1004,830,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1005,180,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1006,1000,1000)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1007,500,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1008,300,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1009,450,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1010,320,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1011,750,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1012,450,1000)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1013,150,500)
insert into stock(codigo_producto,cantidad,pto_reposicion)values(1014,300,500)

select * from stock

insert into precio_venta(codigo_producto,codigo_lista)values(1001,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1001,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1002,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1002,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1003,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1003,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1004,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1004,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1005,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1005,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1006,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1006,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1007,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1008,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1009,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1010,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1010,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1011,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1011,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1012,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1012,2)
insert into precio_venta(codigo_producto,codigo_lista)values(1013,1)
insert into precio_venta(codigo_producto,codigo_lista)values(1014,1)

select * from precio_venta

insert into cliente(codigo_lista,razon_social)values(1,'Luis garcia Antón')
insert into cliente(codigo_lista,razon_social)values(1,'Jaime LLorens')
insert into cliente(codigo_lista,razon_social)values(1,'El Triángulo')
insert into cliente(codigo_lista,razon_social)values(1,'Bujes y Pernos')
insert into cliente(codigo_lista,razon_social)values(1,'Carlos Tena')
insert into cliente(codigo_lista,razon_social)values(2,'La Manivela')
insert into cliente(codigo_lista,razon_social)values(2,'Juan Bolto')
insert into cliente(codigo_lista,razon_social)values(2,'Alvarez Hnos.')
insert into cliente(codigo_lista,razon_social)values(1,'ORSAN S.A.')
insert into cliente(codigo_lista,razon_social)values(2,'Cristóbal García')
insert into cliente(codigo_lista,razon_social)values(1,'La Fontella')
insert into cliente(codigo_lista,razon_social)values(1,'Sunshine Ready')
insert into cliente(codigo_lista,razon_social)values(2,'San Antonio')
insert into cliente(codigo_lista,razon_social)values(2,'Castelnuovo S.A.')
insert into cliente(codigo_lista,razon_social)values(1,'BlueMoon')
insert into cliente(codigo_lista,razon_social)values(1,'Las Cabañas')
insert into cliente(codigo_lista,razon_social)values(2,'Electrosur')

select * from cliente

insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('15/03/02',101,1)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('15/03/02',101,2)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('15/03/02',102,3)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('16/03/02',104,4)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('16/03/02',104,1)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('16/03/02',104,5)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('16/03/02',105,4)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('21/03/02',108,7)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('22/03/02',108,6)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('22/03/02',104,6)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('22/03/02',101,1)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('22/03/02',110,4)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('01/04/02',110,12)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('01/04/02',102,12)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('12/04/02',104,15)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('12/04/02',108,15)
insert into pedido(fecha_pedido,codigo_empleado,codigo_cliente)values('14/04/02',101,12)


select * from pedido

alter table detalle_pedido 
ADD cantidad integer

alter table detalle_pedido
DROP column cantidad;

SELECT * FROM detalle_pedido

DELETE FROM detalle_pedido

alter table detalle_pedido 
ADD cantidad integer not null;

/*FALTA INSERTAR ESTO*/
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(1,1,1003,10)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(1,2,1005,12)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(1,3,1007,45)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(2,1,1001,78)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(3,1,1008,32)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(3,2,1009,5)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(3,3,1003,46)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(4,1,1004,12)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(4,2,1005,45)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(5,1,1002,23)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(6,1,1007,30)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(6,2,1008,14)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(7,1,1006,7)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(7,2,1005,65)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(7,3,1004,120)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(8,1,1004,32)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(8,2,1006,74)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(9,1,1009,115)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(9,2,1003,89)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(10,1,1004,10)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(10,2,1001,12)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(11,1,1003,12)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(11,2,1008,6)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(11,3,1009,38)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(12,1,1005,65)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(12,2,1001,56)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(12,3,1009,45)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(12,4,1004,18)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(12,5,1003,14)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(13,1,1011,21)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(13,2,1012,32)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(14,1,1013,100)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(14,2,1014,6)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(14,3,1010,18)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(15,1,1009,9)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(15,2,1012,32)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(16,1,1014,5)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(17,1,1011,10)
insert into detalle_pedido(codigo_pedido,numero_linea,codigo_producto,cantidad)values(17,2,1001,12)

SELECT * FROM detalle_pedido

alter table  cliente
add limite_credito money default 0;
/*PROBAR SI EL DEFAULT PUEDE SER 1 Y ELIMINARLO*/

SELECT * FROM cliente

alter table lista 
add constraint mayor_cero /*constraint es restriccion */
check (ganancia_porcentaje>0);

SELECT * FROM lista

sp_help lista

insert into lista(codigo_lista, descripcion, ganancia_porcentaje)
VALUES (100,'AASA',-3);/*NO ME DEJA POR EL CODIGO_LISTA*/

insert into lista( descripcion, ganancia_porcentaje)
VALUES ('AASA',-3);/*NO ME DEJA POR EL CODIGO_LISTA*/

insert into lista(codigo_lista, descripcion, ganancia_porcentaje)
VALUES (100,'AASA',3)

SELECT * FROM lista

SELECT * FROM pedido

ALTER TABLE pedido
add fecga_entrega 
as (fecha_pedido + 30)

SELECT getdate();

SELECT year(getdate())

SELECT f.razon_social, p.descripcion, p.precio_costo
FROM fabricante f, producto p
WHERE p.codigo_fabricante = f.codigo_fabricante

SELECT f.razon_social as fabricante, p.descripcion as producto, p.precio_costo as 'Precio Producto'
FROM fabricante f, producto p
WHERE p.codigo_fabricante = f.codigo_fabricante

SELECT producto.descripcion, fabricante.razon_social, stock.cantidad
FROM producto, fabricante, stock
WHERE producto.codigo_producto = stock.codigo_producto AND producto.codigo_fabricante = fabricante.codigo_fabricante

SELECT COUNT(*) FROM producto

SELECT * FROM producto

SELECT RTRIM(apellido) +',' + RTRIM(nombre) + ',' + numero_documento 
FROM empleado

SELECT 14*6

CREATE VIEW DATOS_PRODUCTO AS 
SELECT f.razon_social as fabricante, p.descripcion as producto, p.precio_costo as 'Precio Producto'
FROM fabricante f, producto p
WHERE p.codigo_fabricante = f.codigo_fabricante

SELECT * FROM DATOS_PRODUCTO


/*------------------------------------------------------------------*/

/*PUNTO 1*/

SELECT *from oficina

SELECT descripcion as Nombre FROM oficina

/*PUNTO 2*/

SELECT * FROM Producto

SELECT descripcion as Producto, precio_costo as 'Precio sin IVA', precio_costo+(Precio_costo*0.21) as 'Precio con IVA'
FROM producto

/*PUNTO 3*/

SELECT apellido Apellido, nombre Nombre, CONVERT(VARCHAR(5),fecha_nacimiento,101) 'Fecha Cumpleaños' , (YEAR(getdate())-YEAR(fecha_nacimiento)) 'Edad' 
FROM empleado

/*PUNTO 4*/

SELECT * FROM empleado
where codigo_jefe <> 0

/*PUNTO 5*/

SELECT * FROM empleado
WHERE nombre='Maria'
ORDER BY apellido 

/*PUNTO 6*/

SELECT * FROM cliente
WHERE razon_social LIKE 'L%'
ORDER BY codigo_cliente

/*PUNTO 7*/

SELECT * FROM pedido
WHERE MONTH(fecha_pedido)= 03
ORDER BY fecha_pedido

/*PUNTO 8*/

SELECT * FROM oficina
WHERE codigo_director is null

/*PUNTO 9*/

SELECT TOP 4 * FROM producto
ORDER BY precio_costo

/*PUNTO 10*/

SELECT TOP 3 * FROM datos_contrato
ORDER BY cuota DESC


/*CONSULTAS MULTITABLAS*/
/*PUNTO 1*/
SELECT * FROM stock
SELECT * FROM producto

SELECT p.descripcion Producto, f.razon_social 'Razon Social', s.cantidad STOCK 
FROM producto p, fabricante f, stock s
WHERE p.codigo_producto = s.codigo_producto AND p.codigo_fabricante = f.codigo_fabricante
ORDER BY f.razon_social,p.descripcion

/*PUNTO 2*/

SELECT p.codigo_pedido 'Codigo del Pedido',p.fecha_pedido 'Fecha de Pedido',e.apellido Apellido, c.razon_social 'Razon Social Cliente'
FROM pedido p, empleado e, cliente c
WHERE p.codigo_empleado = e.codigo_empleado AND p.codigo_cliente = c.codigo_cliente

/*PUNTO 3*/
CREATE VIEW aux_empleado as SELECT * from empleado

Select * from empleado

/*Punto 10
Listar aquellos empleados cuya cuota es menor a 50000 o mayor a 100000 */

select*from empleado
SELECT *FROM datos_contrato

SELECT *
FROM datos_contrato dt, empleado e
WHERE dt.codigo_empleado = e.codigo_empleado AND (dt.cuota < 50000 OR dt.cuota > 100000)

SELECT *
FROM datos_contrato dt
WHERE (dt.cuota < 50000.00) OR (dt.cuota > 100000.00)

/*2da clase--------------------------------------------------------------------*/

SELECT * INTO copia_fabricante FROM fabricante;
SELECT * FROM copia_fabricante;

CREATE VIEW aux_fabr AS
SELECT * FROM fabricante


INSERT INTO fabricante (razon_social)
VALUES ('A');

/*NOTAR QUE AUX_FABR(CREATE VIEW) SE ACTUALIZA Y COPIA_FABRICANTE(SELECT* INSERT) NO*/
SELECT * FROM aux_fabr
SELECT * FROM copia_fabricante;



BEGIN transaction;
	DELETE FROM copia_fabricante;
	SELECT * FROM copia_fabricante;
ROLLBACK;

SELECT * FROM copia_fabricante;

BEGIN transaction
	DELETE FROM copia_fabricante;
	SELECT * FROM copia_fabricante;
COMMIT

SELECT * FROM copia_fabricante;

/*rollback tiene vuelta atras y commit no*/

/* # representa temporal */
/*-----------*/

CREATE TABLE cuenta(numero_cuenta int, saldo numeric (10,2));
INSERT INTO cuenta VALUES (1001,23000);
INSERT INTO cuenta VALUES (1035,2000);
SELECT * FROM cuenta
/*DELETE FROM cuenta*/

BEGIN transaction
	DECLARE @error int
	SET @error = 0 /* SI ES CERO NO HUBO ERROR*/
	UPDATE cuenta SET saldo = (saldo-5000)
	WHERE numero_cuenta=1001

IF @@error <> 0 /*HUBO ERROR SI ES DISTINTO DE CERO*/
BEGIN
	SET @error =1 /*SI HUBO ERROR LE SOY VALOR DE UNO*/
END

/*-----------*/
UPDATE cuenta SET saldo = (saldo+5000)
WHERE numero_cuenta=1035

IF @@error <>0
BEGIN
	SET @error =1
END

IF @error =1
BEGIN 
	ROLLBACK
END
ELSE 
BEGIN
	COMMIT
END
/*-----------------*/

/*CURSORES SON VECTORES*/
use EMPRESA

/*-------------------*/
alter table empleado 
add clave varchar(100)

declare @codigo_empleado as int
declare @apellido as varchar(50)
declare @nombre as varchar(50)
declare @clave as varchar(100)

/*declaramos un cursor llamado cambioclave*/

declare cambioclave cursor for 
select codigo_empleado, apellido, nombre FROM empleado

open cambioclave 
fetch next from cambioclave into @codigo_empleado, @apellido, @nombre

while @@FETCH_STATUS =0 /*@@fetch_status sirve para validar el comportamiento de un while*/
begin
	set @clave = @apellido
	update empleado
	set clave = @clave
	where codigo_empleado= @codigo_empleado

	fetch next from cambioclave into @codigo_empleado, @apellido, @nombre
end 

close cambioclave
deallocate cambioclave /*libera espacio de memoria*/

select * from empleado

/*EJERCICIOS*/

/*FABRICANTES QUE NO TIENEN PRODUCTOS*/
select  codigo_fabricante from fabricante 
WHERE codigo_fabricante NOT IN 
(
	select codigo_fabricante from producto
)


delete from fabricante 
WHERE codigo_fabricante 
NOT IN 
(
	select codigo_fabricante from producto
)


select codigo_producto FROM producto
where codigo_fabricante IN
(
	6,7
)

select * from fabricante

delete from fabricante 
/*no se va a poder hacer porque hay una relacion referencial con productos.
esto significa que es una base de datos consistente*/
	
	
/*punto 5*/
UPDATE datos_contrato 
SET cuota =(cuota + cuota*0.05)
WHERE fecha_contrato < '1999-01-01'

select * from datos_contrato


/*punto 6*/
update empleado 
set codigo_empleado= codigo_empleado+2
where codigo_empleado= 110
/*actualizacion en cascada significa que ese valor se actualice en todas las tablas en las que es 
referencia tambien. Para eso hay que actualizar la tabla en la que el valor es pk, y todas las fk
se van a actualizar automaticamente*/

/*punto 2*/
update precio_venta
set precio= (p.precio_costo + (p.precio_costo * l.ganancia_porcentaje /100))
from lista l, producto p, precio_venta pv
WHERE pv.codigo_lista = l.codigo_lista and pv.codigo_producto = p.codigo_producto

select* from precio_venta
