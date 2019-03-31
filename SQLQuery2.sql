use EMPRESA

create procedure nuevo_producto
	(@descripcion varchar(50),
	@codigo_fabricante int,
	@precio_costo money)
	as
	begin transaction
/*Inserta nuevo articulo*/
	insert into producto (descripcion, precio_costo, codigo_fabricante)
	values(@descripcion, @precio_costo, @codigo_fabricante)
			if(@@error <> 0) /*@@error me dice si se ejecuto bien o no una instruccion*/ /*todos los doble arroba (@@) son instrucciones propias de sql server*/
			begin
				rollback transaction
				print 'No se pudo agregar el producto'
				return
			end
	commit transaction /*commit confirma transaccion. Rollback la deshace*/
return

select * from producto

/*Ejecutar el procedimiento almacenado*/
exec nuevo_producto
	@descripcion = 'Mesa triangular',
	@codigo_fabricante = 2,
	@precio_costo = 10
	
/*Este no anda porque no hay un codigo_fabricante = 36*/
exec nuevo_producto
	@descripcion = 'Mesa redonda',
	@codigo_fabricante = 36,
	@precio_costo = 15
	
/*Ver el codigo del procedimiento almacenado*/
sp_helptext nuevo_producto;

/*Eliminar el procedimiento almacenado*/
drop procedure nuevo_producto;

select * from stock
/*stock procedure cursor*/

Create procedure control_stock
(@descripcion varchar(50)=NULL)
as
declare @pedir as int
if(@descripcion is NULL)
	begin
		declare stock cursor for /*los cursores se declaran con los nombres de las tablas y el cursos se llenara con los siguientes datos del select (el cursor son todas las filas)*/
		select p.descripcion, (s.pto_reposicion - s.cantidad) /*(punto de repocision - cantidad) es lo que hay que reponer*/
		from producto p join stock s on	p.codigo_producto = s.codigo_producto
		where (s.pto_reposicion - s.cantidad) > 0 /*donde hay algo que reponer*/
		order by p.descripcion
	end
else
	begin
		print @descripcion
		declare stock cursor for
		select p.descripcion, (s.pto_reposicion - s.cantidad)
		from producto p join stock s on	p.codigo_producto = s.codigo_producto
		where (s.pto_reposicion - s.cantidad) > 0 
			and p.descripcion like @descripcion
	end


open stock
fetch next from stock
into @descripcion, @pedir
while @@fetch_status = 0/*@@fetch_status sirve para validar el comportamiento de un while*/
	Begin
		print rtrim(ltrim(@descripcion)) +','+'pedir:'+ cast(@pedir as char(10))
		fetch next from stock into @descripcion, @pedir
	end
close stock
deallocate stock
return

/*las siguientes dos lineas ejecutan el cursor de formas distintas*/
exec control_stock /*@descripcion aca estaria nulo y entra a la parte de if(@descripcion is NULL)*/

exec control_stock @descripcion = '%Linterna%' /*@descripcion aca si tiene valor y entra a la parte del else*/

/*------------------------------*/
/*Nombre del fabricante del producto*/

/*-------------*/
select p.descripcion, p.precio_costo
from producto p 

select AVG(precio_costo) promedio
from producto p

select* from fabricante

/*1era forma*/
select f.razon_social, AVG(p.precio_costo) promedio
from producto p, fabricante f
where f.codigo_fabricante = p.codigo_fabricante
and f.razon_social = 'ABC Comercial'
group by f.razon_social

/*otra forma igual*/
select f.razon_social, AVG(p.precio_costo) promedio
from producto p join fabricante f on f.codigo_fabricante = p.codigo_fabricante
where f.razon_social = 'ABC Comercial'
group by f.razon_social

/*informar por cada pedido: codigo de pedido, fecha de pedido, razon social del cliente y importe total */
select p.codigo_pedido, p.fecha_pedido, c.razon_social, SUM(dp.cantidad*pv.precio)as importe_total 
from pedido p join cliente c on p.codigo_cliente=c.codigo_cliente 
              join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido 
			  join precio_venta pv on dp.codigo_producto = pv.codigo_producto and c.codigo_lista = pv.codigo_lista
group by p.codigo_pedido, p.fecha_pedido, c.razon_social

/*-----------------------------------------------------------------------*/

select p.codigo_pedido, p.fecha_pedido, c.razon_social, SUM(dp.cantidad*pv.precio)as importe_total /*SUM(dp.cantidad*pv.precio).... ESTO ES LO QUE ME OBLIGA A AGRUPAR TODO*/
from pedido p , detalle_pedido dp, precio_venta pv, cliente c 
where p.codigo_cliente=c.codigo_cliente AND p.codigo_pedido = dp.codigo_pedido AND dp.codigo_producto = pv.codigo_producto 
AND c.codigo_lista = pv.codigo_lista
group by  p.fecha_pedido, p.codigo_pedido, c.razon_social


/*actualizar la columna ventas en la tabla datos_contrato con el importe correspondiente al total de pedidos de cada empleado*/


select * from datos_contrato
select * from pedido
select * from detalle_pedido
select * from precio_venta
select * from cliente


/*------------------------------------------*/			
delete from fabricante
where codigo_fabricante NOT IN (select codigo_fabricante from producto)
			
	
