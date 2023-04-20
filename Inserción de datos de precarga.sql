/* DATOS DE TABLAS QUE NECESITA EL SISTEMA COMO PRECARGA */
-- EL PRIMER CLIENTE ES CONSUMIDOR FINAL
INSERT INTO clientes (nombre_apellido) VALUES ('CF');
-- TIPOS DE MOVIMINETOS
INSERT INTO tipo_movimiento_caja (tipo) VALUES ('Venta');
INSERT INTO tipo_movimiento_caja (tipo) VALUES ('Gasto');
INSERT INTO tipo_movimiento_caja (tipo) VALUES ('Otros ingresos');
INSERT INTO tipo_movimiento_caja (tipo) VALUES ('Otros egresos');
-- EL PRIMER PROVEEDOR ES OTRO
INSERT INTO proveedores (nombre, telefono) VALUES ('Otros','00000000');

/* Empezamos con datos de prueba */
/* ALERTA: SOLO UTILIZAR PARA PRUEBA, NO PARA PRODUCCIÓN */
INSERT INTO tipos_usuarios(tipo) VALUES ('Administrador'), ('Invitado');
INSERT INTO usuarios (nombre, contraseña, usuario, id_tipo_usuario)
	VALUES ('Carmen Ajcalon', 'secreto1234', 'admin', 1);
INSERT INTO menu (platillo, precio) VALUES ('Carne asada', 40), ('Arroz frito', 35),
	('Menu del dia', 25), ('Fresco de piña', 15), ('Horchata', 10);
INSERT INTO meseros (nombre) VALUES ('Roberto'), ('Carlos'),
	('Pedro'), ('Maria');
INSERT INTO clientes (nombre_apellido) VALUES ('Juana Perez'), ('Sonia Tun'), ('Pedro Pascal'),
	('Dua Lipa'), ('Gobernacion');
INSERT INTO proveedores (nombre, telefono) VALUES ('Super carnes', '1234'),
	('Aguas el Victor', '1234'), ('Mercado', '1234');
INSERT INTO ventas (numero_comanda, fecha, total, id_mesero, id_cliente) VALUES
	('12', '1/3/2023', 200, 1, 1), ('13', '1/3/2023', 80, 2, 1), ('13', '2/3/2023', 70, 2, 6),
	('14', '3/3/2023', 125, 3, 5), ('15', '3/3/2023', 200, 1, 4);
INSERT INTO detalle_venta (id_venta, id_platillo, cantidad, subtotal, observaciones) VALUES
	(1, 1, 5, 200, ' '), (2, 3, 2, 50, ' '), (2, 4, 2, 30, ' '), (3, 2, 2, 70, 'Pedro Benjamin - Cajero'),
	(4, 3, 3, 75, ' '), (4, 5, 5, 50, ' ');
INSERT INTO caja_diaria (fecha, saldo_inicial, saldo_final) VALUES
	('1/3/2023', 0, 205), ('2/3/2023', 205, 445), ('3/3/2023', 445, NULL);
INSERT INTO movimiento_caja (id_tipo_movimiento, id_caja_diaria, concepto, total) VALUES
	(1, 1, 'Ventas', 200), (1, 1, 'Ventas', 80), (2, 1, 'Compra de agua', 25), (2, 1, 'Ventas', 50),
	(1, 2, 'Ventas', 70), (2, 2, 'Compra de agua', 30), (4, 2, 'Depósito bancario', 300), (3, 2, 'Sencillo para el dia', 500);
INSERT INTO gastos (numero_documento, fecha, concepto, total, id_proveedor) VALUES
	('8545', '1/3/2023', 'Compra de agua', 25, 2), ('3264', '1/3/2023', 'Compra de carne', 50, 1),
	('9645', '2/3/2023', 'Compra de agua', 30, 2), ('6145', '3/3/2023', 'Compra de vegetales', 25, 3),
	(null, '3/3/2023', 'Pago Planilla', 100, null);

