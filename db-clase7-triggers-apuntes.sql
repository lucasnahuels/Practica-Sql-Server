use EMPRESA

--Elimina un trigger

--drop trigger nombre_trigger;

--Inserted y Deleted son dos tablas que se crean automaticamente cada vez que se dispara un trigger

--Inserted almacena cualquier fila que se vaya a añadir a la tabla
--Deleted almacena cualquier fila que se vaya a borrar de la tabla

drop trigger ingreso_stock;

--Vemos algunos triggers de ejemplo, ver la query.
--El trigger lo vemos en la carpeta Triggers de la tabla correspondiente en Tables

--Esto funciona a pesar del error que tira aca, seleccionar el bloque
create TRIGGER ingreso_stock on producto FOR insert
AS
begin
	insert into stock(codigo_producto, cantidad, pto_reposicion)
	select ins.codigo_producto, 0, 50 from inserted ins
end

--Para ejecutar el trigger, hago un insert en la tabla que tenga el trigger

insert into producto(descripcion, precio_costo, codigo_fabricante)
values ('Motor trifasico 500C', 3563, 2);

--Deshabilitar / Habilitar un trigger

--Siempre mirar la tabla que involucra al trigger para poder validar el correcto funcionamiento del trigger
select * from stock

alter table producto disable trigger ingreso_stock;
alter table producto enable trigger ingreso_stock;

--Comprueba que la cantidad que se intenta pedir sea menor o igual al stock del producto, y actualiza el campo "stock" de "producto", restando al anterior la cantidad ??
use EMPRESA
select * from detalle_pedido

create trigger control_pedidos on detalle_pedido
for insert
	as
	declare @stock int
	select @stock = s.cantidad from stock s 
	join inserted on inserted.codigo_producto = s.codigo_producto
	where s.codigo_producto = inserted.codigo_producto
	
	if (@stock >= (select cantidad from inserted))
		update stock set cantidad = s.cantidad - inserted.cantidad
		from stock s
		join inserted on inserted.codigo_producto = s.codigo_producto
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

--Crear un trigger que grabe en la tabla auditoria_producto los valores anteriores del registro modificado en la tabla producto
create table auditoria_producto 
(
	codigo_producto int,
	descripcion varchar(50),
	precio_costo money,
	codigo_fabricante int,
	fecha_actualizacion datetime,
	usuario varchar(50)
)

create trigger modif_producto on producto for update as
insert into auditoria_producto(codigo_producto, descripcion, precio_costo, codigo_fabricante, fecha_actualizacion, usuario)

--Si lo traes de un select no hace falta un VALUES

select del.codigo_producto, del.descripcion, del.precio_costo, del.codigo_fabricante, getdate(), user_name()
from deleted del

select * from producto
select * from auditoria_producto

update producto set precio_costo = 5 where codigo_producto = 1001

select * from producto
select * from auditoria_producto

--Esto es de la guia de TPs
--TP 3, creo

--2. Listar los empleados que no estan en la oficina "Ventas Interior"
select * from oficina
select * from empleado

select codigo_oficina from oficina
where descripcion = 'Ventas Interior'

--Se puede hacer sin una subconsulta, pero la idea es que las practiquemos
--Se pueden hacer varias subconsultas anidades, pero habria que revisar la logica de la consulta, porque seria raro tener que hacer eso; capaz seria mejor hacer una vista de los datos, por ejemplo

select apellido, nombre from empleado
where codigo_oficina not in
(
	select codigo_oficina from oficina
	where descripcion = 'Ventas Interior'
)

--5. Listar sin repetir la razon social de aquellos clientes que hicieron por lo menos un pedido cuyo importe total sea mayor que $850
select * from pedido
select* from cliente
select * from detalle_pedido
select * from precio_venta /*codigo_lista significa que uno es mayorista y otro minorista. Dependiendo que cliente es le voy a cobrar un precio o otro*/

--Aca tenemos dos niveles de anidamiento (2 subconsultas) Conviene hacerlas y probarlas desde el interior para afuera

select razon_social from cliente
	where codigo_cliente in
	(
		select codigo_cliente from pedido where codigo_pedido in
		(
			select pe.codigo_pedido from pedido pe, detalle_pedido dp, cliente c, precio_venta pv
			where pe.codigo_pedido = dp.codigo_pedido and
				pe.codigo_cliente = c.codigo_cliente and
				dp.codigo_producto = pv.codigo_producto and
				pv.codigo_lista = c.codigo_lista /*codigo_lista y codigo_producto van de la mano ambas como pk de precio_venta*/
			group by pe.codigo_pedido
			having (sum(dp.cantidad*pv.precio)>850) 
		) 
	)
order by razon_social

--8. Listar sin repetir los productos que figuren con por lo menos una cantidad pedida mayor a 70 en el mes de marzo.
select * from producto
select * from pedido
select * from detalle_pedido
select * from detalle_pedido dp, pedido p where p.codigo_pedido = dp.codigo_pedido
select descripcion from producto
/*distinct me seleciona quita las repetidas de la tabla*/

select distinct descripcion from producto
where codigo_producto in(select dp.codigo_producto from detalle_pedido dp, pedido p
where month(p.fecha_pedido) = 3 
and p.codigo_pedido = dp.codigo_pedido
group by codigo_producto
having sum(cantidad)>70)
								
/*el select de la subconsulta debe ser igual al where de la consulta*/								
/*el group by suele ser el mismo que el select*/
/*Nota aparte: join es necesario usarlo en lugar de un where cuando necesito especificar si es un left join o right join*/
