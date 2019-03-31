use EMPRESA

select * from fabricante
select * from stock
select * from pedido
select * from empleado
select * from oficina
select * from lista
select * from documento
select * from datos_contrato
select * from cuenta
select * from copia_fabricante
select * from cliente
select * from precio_venta
select * from detalle_pedido
select * from producto

/*ejercicio 9 multitabla 
OBTENER UNA LISTA CON LAS DESCRIPCION
DE AQUELLOS PRODUCTOS CUYO STOCK ESTA POR DEBAJO DEL PTO DE REPOSICION 
INDICANDO CANTIDAD A COMPRAR Y RAZON SOCIAL DEL FABRICANTE ORDENADA POR RAZON SOCIAL Y DESCRIPCION*/

select * from producto
select * from stock
select * from fabricante

select pr.descripcion, (s.pto_reposicion-s.cantidad) as 'cantidad a comprar', f.razon_social
from producto pr, fabricante f, stock s
where pr.codigo_fabricante=f.codigo_fabricante and pr.codigo_producto= s.codigo_producto and s.cantidad < s.pto_reposicion
group by pr.descripcion, f.razon_social, s.pto_reposicion, s.cantidad
order by pr.descripcion, f.razon_social



/*ejercicio 10 multitabla*/
SELECT* FROM datos_contrato

SELECT e.nombre
FROM datos_contrato dt, empleado e
WHERE dt.codigo_empleado = e.codigo_empleado AND (dt.cuota < 50000 OR dt.cuota > 100000)


/*Subconsulta EJ.10 bien hecha*/
select *
from  cliente c
where c.codigo_cliente in (select codigo_cliente from pedido where codigo_pedido in
							(select pe.codigo_pedido 
							 from pedido pe, detalle_pedido dp, cliente c, precio_venta pv
							 where pe.codigo_pedido = dp.codigo_pedido and
							  pe.codigo_cliente = c.codigo_cliente and
						      dp.codigo_producto = pv.codigo_producto and
						      pv.codigo_lista = c.codigo_lista /*codigo_lista y codigo_producto van de la mano ambas como pk de precio_venta*/
						      and pe.codigo_empleado in (select codigo_empleado
														 from empleado e
														 where e.nombre='Antonio' and e.apellido = 'Viguer' )
							  group by pe.codigo_pedido
							  having (sum(dp.cantidad*pv.precio)>1000) ) )  
	


/*Funciona pero no esta hecho con subconsulta, por lo que esta MAL*/
SELECT c.codigo_cliente,p.codigo_pedido, SUM(cantidad*precio) total
FROM pedido p
LEFT JOIN cliente c ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN empleado e ON e.codigo_empleado = p.codigo_empleado
LEFT JOIN detalle_pedido dp ON dp.codigo_pedido = p.codigo_pedido
LEFT JOIN precio_venta pv ON pv.codigo_lista = c.codigo_lista AND pv.codigo_producto = dp.codigo_producto
WHERE e.apellido = 'Viguer' AND e.nombre = 'Antonio'
GROUP BY c.codigo_cliente, p.codigo_pedido
HAVING SUM(cantidad*precio) < 1000
/*------------------------------------*/

/*EJERCICIO 4 DE SUBCOSNULTAS*/
SELECT * FROM PRODUCTO
SELECT * FROM PEDIDO
SELECT * FROM DETALLE_PEDIDO

select * 
from producto p 
where p.codigo_producto IN(select dp.codigo_producto 
							from detalle_pedido dp, pedido p
							where dp.codigo_pedido = p.codigo_pedido and MONTH(p.fecha_pedido)=03
							group by dp.codigo_producto
							having SUM(dp.cantidad)<200)
							
/*EJERCICIO 5 SUBCOSNULTAS*/							
/*Listar sin repetir la razon social de aquellos clientes que hicieron por lo menos un pedido cuyo importe total sea mayor que $850*/
select * from pedido
select* from cliente
select * from detalle_pedido
select * from precio_venta /*codigo_lista significa que uno es mayorista y otro minorista. Dependiendo que cliente es le voy a cobrar un precio o otro*/
--Aca tenemos dos niveles de anidamiento (2 subconsultas) Conviene hacerlas y probarlas desde el interior para afuera
select razon_social from cliente
	where codigo_cliente in
	(select codigo_cliente from pedido where codigo_pedido in
		(select pe.codigo_pedido from pedido pe, detalle_pedido dp, cliente c, precio_venta pv
			where pe.codigo_pedido = dp.codigo_pedido and
				pe.codigo_cliente = c.codigo_cliente and
				dp.codigo_producto = pv.codigo_producto and
				pv.codigo_lista = c.codigo_lista /*codigo_lista y codigo_producto van de la mano ambas como pk de precio_venta*/
			group by pe.codigo_pedido
			having (sum(dp.cantidad*pv.precio)>850) ) )
order by razon_social

							
/*EJERCICIO 7 DE SUBCOSNULTAS*/
SELECT * FROM CLIENTE
SELECT * FROM FABRICANTE
SELECT * FROM PRODUCTO
SELECT * FROM PEDIDO
SELECT * FROM DETALLE_PEDIDO


select f.razon_social
from fabricante f
where f.codigo_fabricante IN(select pr.codigo_fabricante
							from producto pr
							where pr.codigo_producto IN(select dp.codigo_producto
														from detalle_pedido dp
														where dp.codigo_pedido IN (select p.codigo_pedido
																					from pedido p
																					where MONTH(p.fecha_pedido)=04 ) ) )
																					
/*EJERCICIO 8 DE SUBCOSNULTAS*/
SELECT * FROM PRODUCTO

select distinct descripcion from producto
where codigo_producto in(select dp.codigo_producto from detalle_pedido dp, pedido p
							where month(p.fecha_pedido) = 3 and
								p.codigo_pedido = dp.codigo_pedido
								group by codigo_producto
								having sum(cantidad)>70)
								
/*ejercicio 9 subconsultas: Listar los productos de los cuales no se tiene precio minorista*/
select * from precio_venta
select * from producto

select p.codigo_producto
from producto p
where p.codigo_producto in (select pv.codigo_producto
							from precio_venta pv
							where pv.codigo_lista=2)								
/*------------------------------------------------------------*/

/*consultas de actualizacion de datos*/
/*1*/
Select * into aux_empleado from empleado
select * from aux_empleado

select * from empleado																					

/*2*/
select * from cliente
select * from producto
select * from precio_venta

select pr.descripcion, pv.codigo_lista, pv.precio
from producto pr, cliente c, precio_venta pv
where pr.codigo_producto=  pv.codigo_producto 
GROUP BY pr.descripcion, pv.codigo_lista, pv.precio

/*5*/

select * from empleado
select * from datos_contrato

update datos_contrato
set cuota = cuota + (cuota * 5 / 100)
where fecha_contrato < '1999-01-01'

/*6*/
update empleado 
set codigo_empleado= codigo_empleado+2
where codigo_empleado= 110
/*actualizacion en cascada significa que ese valor se actualice en todas las tablas en las que es 
referencia tambien. Para eso hay que actualizar la tabla en la que el valor es pk, y todas las fk
se van a actualizar automaticamente*/

/*7*/

Select * into aux_producto from producto
select * from aux_producto

/*8*/
select * from producto
update producto
set precio_costo = precio_costo + (precio_costo * 10 /100)

/*9*/
select * from aux_producto
select * from producto

update producto
set precio_costo = a.precio_costo
from aux_producto a,producto /*p*/
where a.codigo_producto=p.codigo_producto

/*10*/
select * from stock
select * from fabricante
select * from producto

update stock
set pto_reposicion= 600
where codigo_producto IN(select pr.codigo_producto
								from producto pr
								where pr.codigo_fabricante in (select f.codigo_fabricante
																from fabricante f
																where f.razon_social='Tomasti Hnos.'))
							
/*--------------------------------------------------------------*/

/*Trabajo practico numero 4 */

/*1*/

select * from producto
select * from fabricante
select * from stock

create view fabricante_productos as
select f.razon_social, pr.descripcion, s.cantidad
from fabricante f, producto pr, stock s
where f.codigo_fabricante = pr.codigo_fabricante and pr.codigo_producto = s.codigo_producto

select * from fabricante_productos

/*2 ---------------------------------------------------------------------------------------listar mediante cursores para cada oficina: nombre de oficina, nombre y apellido del director, nombre y apellido de los empleados asignados a las oficinas*/

select* from oficina
select* from empleado
/*
alter table oficina 
add nombre_director varchar(100), apellido_director varchar(100)
	

create procedure agregarATRIBUTOS
(@cod_oficina int,
@nomoficina varchar(100),
@nomdirector varchar(100),
@apdirector varchar(100) )
as

	
update oficina
set nombre_oficina= @nomoficina, nombre_director = @nomdirector, apellido_director= @apdirector
where codigo_oficina=@cod_oficina
				
			

exec agregarATRIBUTOS @cod_oficina= 1, @nomoficina='oficina12', @nomdirector='julio', @apdirector='ricardo'
exec agregarATRIBUTOS @cod_oficina= 3, @nomoficina='oficina Sur', @nomdirector='Angela', @apdirector='Rodriguez'
exec agregarATRIBUTOS @cod_oficina= 4, @nomoficina='oficina Sur', @nomdirector='Roberto', @apdirector='Lopez'
exec agregarATRIBUTOS @cod_oficina= 2, @nomoficina='oficina Oeste', @nomdirector='Juani', @apdirector='Martinez'
drop procedure agregarATRIBUTOS

select *
from oficina o, empleado e
where e.codigo_oficina = o.codigo_oficina*/

alter table oficina
drop COLUMN nombre_empleado

alter table oficina
drop COLUMN apellido_empleado

alter table oficina
drop COLUMN nombre_director

alter table oficina
drop COLUMN apellido_director

alter table oficina
drop COLUMN nombre_oficina


drop table director
/*----------------------------------------------------------------------*/

/*2listar mediante cursores para cada oficina: nombre de oficina,
 nombre y apellido del director, nombre y 
 apellido de los empleados asignados a las oficinas*/
/*----------------------------------------------------------*/
create table director (codigo_director int primary key,
					 nombre varchar(100) not null,
					 apellido varchar(100) not null );
insert into director(codigo_director, nombre, apellido) values(101, 'Roberto', 'Giordano') 
insert into director(codigo_director, nombre, apellido) values(102, 'Juan', 'Carlos') 
insert into director(codigo_director, nombre, apellido) values(104, 'Jorge', 'Rodriguez') 
insert into director(codigo_director, nombre, apellido) values(105, 'Federico', 'Luan') 

update oficina
set codigo_director=105
where codigo_oficina=4

select* from oficina
select *from director
select *from empleado

declare ver_oficina cursor for
select o.codigo_oficina o.decripcion
/*2------------------------------------------------------------------*/
declare @codigo_oficina as int
declare @apellidoDIRECTOR as varchar(50)
declare @nombreDIRECTOR as varchar(50)
declare @apellidoEMPLEADO as varchar(100)
declare @nombreEMPLEADO as varchar(100)
declare @nombreOFICINA as varchar(100)

declare ver_oficina cursor for
select o.codigo_oficina, o.descripcion, d.nombre as nombre_director, d.apellido as apellido_director, e.nombre as nombre_empleado, e.apellido as apellido_empleado
from oficina o, director d, empleado e
where o.codigo_director = d.codigo_director and e.codigo_oficina= o.codigo_oficina
group by o.codigo_oficina, o.descripcion, d.nombre , d.apellido , e.nombre , e.apellido



open ver_oficina
declare @oficina_aux as varchar(100)

	fetch next from ver_oficina into @codigo_oficina, @nombreOFICINA, @nombreDIRECTOR, @apellidoDIRECTOR, @nombreEMPLEADO, @apellidoEMPLEADO
	print rtrim(ltrim(@nombreOFICINA))+', '+'Nombre director:'+@nombreDIRECTOR+' '+@apellidoDIRECTOR
	while @@FETCH_STATUS =0 		
		begin
		if(@oficina_aux!=@nombreOFICINA)
		begin
			 print rtrim(ltrim(@nombreOFICINA))+', '+'Nombre director:'+@nombreDIRECTOR+' '+@apellidoDIRECTOR
		end
		
		print 'Nombre empleados:'+@nombreEMPLEADO
		
		set @oficina_aux=@nombreOFICINA
		fetch next from ver_oficina into @codigo_oficina, @nombreOFICINA, @nombreDIRECTOR, @apellidoDIRECTOR, @nombreEMPLEADO, @apellidoEMPLEADO	
		end
close ver_oficina 
deallocate ver_oficina



/*3*/

select * from pedido



/*4*/
alter table empleado 
add clave varchar(100)

declare @codigo_empleado as int
declare @apellido as varchar(50)
declare @nombre as varchar(50)
declare @clave as varchar(100)

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

/*5*/
use EMPRESA
select * from precio_venta

select *
from precio_venta where codigo_lista=1 and precio > (select AVG(pv.precio)
													from precio_venta pv)

create procedure actualizar_precios
(@codigo_lista int,
@porcentaje_aumento int)
as

begin transaction
	update precio_venta
	set precio= precio + (precio * @porcentaje_aumento) /100 
	where codigo_lista=@codigo_lista and precio > (select AVG(pv.precio)
													from precio_venta pv)

	if(@@error<>0)
	begin
		rollback transaction
		print 'no se pudo'
		return
	end
commit transaction

exec actualizar_precios @codigo_lista=1, @porcentaje_aumento=5



/*6*/

create procedure devuelve_datos_producto
(@descripcion varchar(100)=NULL)
as
begin transaction
	if(@descripcion IS NULL)
	select * from producto
	
	else select *
		 from producto pr
		 where pr.descripcion = @descripcion
	
	
	if(@@error<>0)
	begin
		rollback transaction
		print 'no se pudo'
		return
	end
commit transaction

exec devuelve_datos_producto
exec devuelve_datos_producto @descripcion='Arandela'

DROP PROCEDURE devuelve_datos_producto

/*7*/
select * from producto
select * from fabricante

create procedure agregar_producto
(@codigoPRODUCTO int=null,
@descripcion varchar(100),
@precioCOSTO int,
@codigoFABRICANTE int)
as 
begin transaction
	insert into producto values(@descripcion, @precioCOSTO, @codigoFABRICANTE)
	


	if(@@error<>0)
		begin
			rollback transaction
			print 'no se pudo'
			return
		end
commit transaction

exec agregar_producto @descripcion='tornillos', @precioCOSTO= 4.5, @codigoFABRICANTE=2

drop procedure agregar_producto

/*8*/
select * from fabricante
select * from producto
select * from stock


create procedure informe_fabricante
(@razon_social varchar(100)=null)
as
begin transaction
declare @descripcion as varchar(100)
declare @cantREPONER as int
declare @precioCOSTO as int

	if(@razon_social is null)
	begin
		declare mostrar_a_reponer cursor for
		select f.razon_social, pr.descripcion, (s.pto_reposicion - s.cantidad) as 'cantidad a reponer', pr.precio_costo
		from producto pr, stock s, fabricante f
		where s.codigo_producto = pr.codigo_producto and f.codigo_fabricante = pr.codigo_fabricante and s.cantidad<s.pto_reposicion
		order by f.razon_social
	end
	else
	begin
		declare mostrar_a_reponer cursor for
		select f.razon_social, pr.descripcion, (s.pto_reposicion - s.cantidad) as 'cantidad a reponer', pr.precio_costo
		from producto pr, stock s, fabricante f
		where s.codigo_producto = pr.codigo_producto and f.codigo_fabricante = pr.codigo_fabricante and s.cantidad<s.pto_reposicion and f.razon_social=@razon_social
		order by f.razon_social
	end

	if(@@error<>0)
		begin
			rollback transaction
			print 'no se pudo'
			return
		end


open mostrar_a_reponer

declare @aux as varchar(100)	
fetch next from mostrar_a_reponer into @razon_social, @descripcion, @cantREPONER, @precioCOSTO
print @razon_social
while @@fetch_status = 0
begin
	if(@razon_social!=@aux) print @razon_social
	print 'producto:'+rtrim(ltrim(@descripcion))+', Cantidad a reponer:'+cast(@cantREPONER as char(10))+', Precio costo producto:$'+cast(@precioCOSTO as char(10))

	
	set @aux=@razon_social	
	fetch next from mostrar_a_reponer into @razon_social, @descripcion, @cantREPONER, @precioCOSTO
end

close mostrar_a_reponer
deallocate mostrar_a_reponer

commit transaction

exec informe_fabricante @razon_social='Abc Comercial'
exec informe_fabricante @razon_social='Basic'

drop procedure informe_fabricante

/*9 hecho por mi----------------------------------*/
select * from producto
select * from stock
select * from fabricante

create procedure producto_comprado
(@nombrePRODUCTO as varchar(100),
@cantidadCOMPRADA as int,
@codigoFABRICANTE as int=null,
@precioCOSTO as int=null
)
as
begin transaction
	declare verificarEXISTENCIAPRODUCTOS cursor for
	select pr.descripcion from producto pr
	
	declare @verificacion as varchar(100)
	declare @bandera as int
	set @bandera=0
	open verificarEXISTENCIAPRODUCTOS
	fetch next from verificarEXISTENCIAPRODUCTOS into @verificacion
		while @@FETCH_STATUS=0
		begin
			if(@verificacion=@nombrePRODUCTO) set @bandera=1
		fetch next from verificarEXISTENCIAPRODUCTOS into @verificacion	
		end
	close verificarEXISTENCIAPRODUCTOS
	deallocate verificarEXISTENCIAPRODUCTOS
	
	if(@bandera=0) insert into producto values( @nombrePRODUCTO, @precioCOSTO, @codigoFABRICANTE)
	
	
	update stock
	set cantidad= cantidad + @cantidadCOMPRADA, pto_reposicion = pto_reposicion -@cantidadCOMPRADA
	where codigo_producto in (select pr.codigo_producto
								from producto pr
								where pr. descripcion=@nombrePRODUCTO)


	
	if(@@error<>0)
		begin
			rollback transaction
			print 'no se pudo'
			return
		end		
commit transaction

exec producto_comprado @nombrePRODUCTO='Sierra electrica', @cantidadCOMPRADA=30, @codigoFABRICANTE=3, @precioCOSTO=500
exec producto_comprado @nombrePRODUCTO='Arandela', @cantidadCOMPRADA=30, @codigoFABRICANTE=1, @precioCOSTO=5.00
DROP PROCEDURE producto_comprado 
/*9 hecho por Martin-----------------*/

create procedure agregarproducto  
    (@nombre varchar(15),  
    @cant_comprada int = null,  
    @cod_fabr int = null,  
    @precio_c money = null)  
as  
declare @contador INT = 0  
declare @cod_prod INT  
begin transaction  
 SELECT @contador = COUNT(*) FROM producto where descripcion = @nombre   
 if(@contador = 0)  
 begin  
  insert into producto (descripcion,precio_costo,codigo_fabricante)  
  VALUES(@nombre,@precio_c,@cod_fabr)  
  if(@@ERROR<>0)  
  begin  
   print 'No se pudo completar la operacion'  
   ROLLBACK TRANSACTION  
   return  
  end  
  SELECT @cod_prod = codigo_producto FROM producto where descripcion = @nombre  
    
  insert into stock(codigo_producto,cantidad,pto_reposicion)  
  VALUES(@cod_prod, @cant_comprada,500)  
  if(@@ERROR<>0)  
  begin  
   print 'No se pudo completar la operacion'  
   ROLLBACK TRANSACTION  
   return  
  end  
  COMMIT TRANSACTION  
 end  
 if(@contador = 1)  
 begin  
  SELECT @cod_prod = codigo_producto FROM producto where descripcion = @nombre  
    
  UPDATE stock  
  SET cantidad = cantidad + @cant_comprada  
  WHERE codigo_producto = @cod_prod  
    
  if(@@ERROR<>0)  
  begin  
   print 'No se pudo completar la operacion'  
   ROLLBACK TRANSACTION  
   return  
  end  
  COMMIT TRANSACTION  
 end

/*10*/
use EMPRESA
select * from lista
select * from precio_venta
select * from producto

alter table precio_venta add precio_venta money
alter table precio_venta drop column precio_venta 

create trigger incorporar_pv on producto 
for insert
as
begin transaction

	declare @ganancia_mayorista as float
	select @ganancia_mayorista=l.ganancia_porcentaje
	from lista l
	where l.codigo_lista=1
	
	insert into precio_venta(codigo_producto, codigo_lista, precio)
	select ins.codigo_producto, 1, ins.precio_costo + (@ganancia_mayorista * ins.precio_costo / 100) 
	from inserted ins 
	
	
	declare @ganancia_minorista as float
	select @ganancia_minorista=l.ganancia_porcentaje
	from lista l
	where l.codigo_lista=2
	print @ganancia_minorista
	
	insert into precio_venta(codigo_producto, codigo_lista, precio)
	select ins.codigo_producto, 2, ins.precio_costo + (@ganancia_minorista * ins.precio_costo / 100) 
	from inserted ins 
	
	if(@@error<>0)
		begin
			rollback transaction
			print 'no se pudo'
			return
		end		
commit transaction	

select *from producto
select * from precio_venta
insert producto values('Martillo',30.0, 1)
drop trigger incorporar_pv

--11)Crear un trigger que grabe en la tabla auditoria_producto los valores anteriores del registro modificado en la tabla producto
create table auditoria_producto (codigo_producto int,
								descripcion varchar(50),
								precio_costo money,
								codigo_fabricante int,
								fecha_actualizacion datetime,
								usuario varchar(50))

create trigger modif_producto on producto for update as
	insert into auditoria_producto(codigo_producto, descripcion, precio_costo, codigo_fabricante, fecha_actualizacion, usuario)
	--Si lo traes de un select no hace falta un VALUES
	select del.codigo_producto, del.descripcion, del.precio_costo, del.codigo_fabricante, getdate(), user_name()
	from deleted del

/*12----------------------------------*/
--Comprueba que la cantidad que se intenta pedir sea menor o igual al stock del producto, y actualiza el campo "stock" de "producto", restando al anterior la cantidad ??
use EMPRESA
select * from detalle_pedido

create trigger control_pedidos on detalle_pedido
	for insert
		as
			declare @stock int
			select @stock = s.cantidad from stock s join inserted
				on inserted.codigo_producto = s.codigo_producto
				where s.codigo_producto = inserted.codigo_producto
		if (@stock >= (select cantidad from inserted))
			update stock set cantidad = s.cantidad - inserted.cantidad
			from stock s join inserted
				on inserted.codigo_producto = s.codigo_producto
					where s.codigo_producto = inserted.codigo_producto
		else
		begin
			raiserror('Hay menos productos en stock de los solicitados para el pedido', 16, 1)
			rollback transaction
		end

/*Se le puede poner o no el 'as begin' al trigger. Mejor ponerlo para encontrar mejor donde comienza y termina el trigger*/
--Probamos el trigger

insert into detalle_pedido values(17, 3, 1001, 500);
insert into detalle_pedido values(17, 4, 1005, 500);


/*13------------------------------------------------------------------------------*/
enable trigger nombre_trigger on tabla_trigger
disable trigger nombre_trigger on tabla_trigger

alter table producto disable trigger ingreso_stock;
alter table producto enable trigger ingreso_stock;