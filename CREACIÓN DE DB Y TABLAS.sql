/* Creamos la base de datos con el perfil guatemalteco */
-- Database: dev_goeat

-- DROP DATABASE IF EXISTS dev_goeat;

CREATE DATABASE goeat
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Guatemala.1252'
    LC_CTYPE = 'Spanish_Guatemala.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

/* Comienza la declaración de tablas sin relación */
CREATE TABLE tipos_usuarios(
	id_tipo_usuario SMALLSERIAL PRIMARY KEY NOT NULL,
	tipo varchar(30)
);

CREATE TABLE usuarios(
	id_usuario uuid DEFAULT gen_random_uuid() PRIMARY KEY UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	usuario VARCHAR(50) NOT NULL,
	contraseña VARCHAR(300) NOT NULL,
	id_tipo_usuario SMALLINT NOT NULL,
	FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuarios(id_tipo_usuario)
);

CREATE TABLE menu(
	id_platillo SERIAL PRIMARY KEY NOT NULL,
	platillo VARCHAR(100) NOT NULL,
	precio MONEY NOT NULL 
);

CREATE TABLE meseros(
	id_mesero SMALLSERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(100) NOT NULL
);

CREATE TABLE clientes(
	id_cliente SERIAL PRIMARY KEY NOT NULL,
	nombre_apellido VARCHAR(100) NOT NULL,
	fecha DATE,
	institucion VARCHAR(100),
	puesto VARCHAR(50)
);

CREATE TABLE proveedores(
	id_proveedor SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(100) NOT NULL, 
	telefono VARCHAR(12)
);

CREATE TABLE tipo_movimiento_caja(
	id_tipo_movimiento SMALLSERIAL PRIMARY KEY NOT NULL,
	tipo VARCHAR(15)
);

CREATE TABLE caja_diaria(
	id_caja_diaria BIGSERIAL PRIMARY KEY NOT NULL,
	fecha DATE NOT NULL,
	saldo_inicial MONEY NOT NULL,
	saldo_final MONEY
);

/* Comienza la declaración de tablas con relaciones */
CREATE TABLE movimiento_caja(
	id_movimiento SERIAL PRIMARY KEY NOT NULL,
	id_tipo_movimiento SMALLINT,
	id_caja_diaria BIGINT,
	concepto VARCHAR(255),
	total MONEY,
	FOREIGN KEY (id_tipo_movimiento) REFERENCES tipo_movimiento_caja(id_tipo_movimientO),
	FOREIGN KEY (id_caja_diaria) REFERENCES caja_diaria(id_caja_diaria)
);

CREATE TABLE ventas(
	id_venta BIGSERIAL PRIMARY KEY NOT NULL,
	numero_comanda VARCHAR(100),
	fecha DATE,
	total MONEY,
	id_mesero SMALLINT,
	id_cliente INT,
	FOREIGN KEY (id_mesero) REFERENCES meseros(id_mesero),
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE gastos(
	id_gasto BIGSERIAL PRIMARY KEY NOT NULL,
	numero_documento VARCHAR(255),
	fecha DATE,
	concepto VARCHAR(255),
	total MONEY,
	id_proveedor INT,
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

CREATE TABLE detalle_venta(
	id_detalle_venta BIGSERIAL PRIMARY KEY NOT NULL,
	id_platillo INT,
	id_venta BIGINT,
	cantidad SMALLINT,
	subtotal MONEY,
	observaciones VARCHAR(255),
	FOREIGN KEY (id_platillo) REFERENCES menu(id_platillo),
	FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);


/* Tablas para los trigers */
CREATE TABLE venta_movimiento_caja(
	id_venta_movimiento_caja BIGSERIAL PRIMARY KEY NOT NULL,
	id_venta BIGINT,
	id_movimiento_caja BIGINT,
	FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
	FOREIGN KEY (id_movimiento_caja) REFERENCES movimiento_caja(id_movimiento)
);

CREATE TABLE gastos_movimiento_caja(
	id_gasto_movimiento_caja BIGSERIAL PRIMARY KEY NOT NULL,
	id_gasto BIGINT,
	id_movimiento_caja BIGINT,
	FOREIGN KEY (id_gasto) REFERENCES gastos(id_gasto),
	FOREIGN KEY (id_movimiento_caja) REFERENCES movimiento_caja(id_movimiento)
);
