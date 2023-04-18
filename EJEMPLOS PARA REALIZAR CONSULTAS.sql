/* EJEMPLOS PARA REALIZAR CONSULTAS */
/* CONSULTAS PARA TRAER DATOS DE LA TABLA USUARIOS */
-- Consulta para traer los datos de todos los usuarios
SELECT * FROM usuarios;

-- Consulta para traer los datos de un usuario específico
SELECT nombres, apellidos, usuario, contraseña FROM usuarios WHERE id_usuario='1cb22a65-6bea-4624-a684-2dfaa66cf0d3';

/* CONSULTAS SOBRE LAS VENTAS */
-- Consulta para traer todos las ventas existentes
SELECT * FROM ventas;
-- Consulta para traer ventas por un rango de fechas
SELECT * FROM ventas WHERE fecha BETWEEN '1/3/2023' AND '2/3/2023';
-- Consulta para traer ventas de una fecha específica
SELECT * FROM ventas WHERE fecha = '2/3/2023';
-- Consulta para traer el detalle de una venta
SELECT * FROM detalle_venta WHERE id_venta = 2;
-- CONSULTA PARA TRAER EL DETALLE DE UNA VENTA
SELECT ve.numero_comanda, dv.cantidad, me.platillo, me.precio, dv.subtotal FROM detalle_venta as dv
INNER JOIN menu as me ON dv.id_platillo = me.id_platillo
INNER JOIN ventas as ve ON dv.id_venta = ve.id_venta
WHERE dv.id_venta = 2;


/* CONSULTAS PARA OBTENER GASTOS */


/* CONSULTAS  */
-- CONSULTA PARA TRAER EL MOVIMIENTO DE INVENTARIO (VENTAS Y GASTOS)
SELECT mc.concepto, cd.fecha, mc.total FROM movimiento_caja as mc
INNER JOIN caja_diaria as cd ON cd.id_caja_diaria = mc.id_caja_diaria
INNER JOIN tipo_movimiento_caja AS tmc ON tmc.id_tipo_movimiento = mc.id_tipo_movimiento
WHERE mc.id_tipo_movimiento IN (1,2) AND cd.fecha BETWEEN '1/3/2023' AND '2/3/2023';

/* CONSULTAS PARA OBTENER DATOS DEL USUARIO */
-- Consulta para buscar a un usuario por su nombre de usuario
SELECT us.id_usuario, us.nombres, us.contraseña, tu.tipo FROM usuario_tipo AS ut
INNER JOIN usuarios AS us ON ut.id_usuario = us.id_usuario
INNER JOIN tipos_usuarios AS tu ON tu.id_tipo_usuario = ut.id_tipo_usuario
WHERE us.usuario = 'aadmin';