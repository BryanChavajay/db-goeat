/* TRIGGER PARA DETECTAR UNA VENTA Y REGISTRAR EL EFECTIVO EN CAJA */
CREATE FUNCTION SP_TR_INSERTAR_VENTA_EN_CAJA() RETURNS TRIGGER
AS
$$
DECLARE
ultima_caja_diaria BIGINT;
id_ultimo_movimiento_caja_diaria BIGINT;
BEGIN

SELECT id_caja_diaria INTO ultima_caja_diaria FROM caja_diaria ORDER BY id_caja_diaria DESC LIMIT 1;
INSERT INTO movimiento_caja (id_tipo_movimiento, id_caja_diaria, concepto, total) VALUES 
	(1, ultima_caja_diaria, 'Venta', new.total);

SELECT id_movimiento INTO id_ultimo_movimiento_caja_diaria FROM movimiento_caja ORDER BY id_movimiento DESC LIMIT 1;
INSERT INTO venta_movimiento_caja (id_venta, id_movimiento_caja) VALUES
	(new.id_venta, id_ultimo_movimiento_caja_diaria);

RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_INSERTAR_VENTA_EN_CAJA AFTER INSERT ON ventas
FOR EACH ROW
EXECUTE PROCEDURE SP_TR_INSERTAR_VENTA_EN_CAJA();
/* Aca termina el trigger para insertar el total de la venta en caja */

/* TRIGGER PARA REGISTRAR EL TOTAL DE UN GASTO EN CAJA */
CREATE FUNCTION SP_TR_INSERTAR_GASTO_EN_CAJA() RETURNS TRIGGER
AS
$$
DECLARE
ultima_caja_diaria BIGINT;
id_ultimo_movimiento_caja_diaria BIGINT;
BEGIN

SELECT id_caja_diaria INTO ultima_caja_diaria FROM caja_diaria ORDER BY id_caja_diaria DESC LIMIT 1;
INSERT INTO movimiento_caja (id_tipo_movimiento, id_caja_diaria, concepto, total) VALUES 
	(2, ultima_caja_diaria, new.concepto, new.total);

SELECT id_movimiento INTO id_ultimo_movimiento_caja_diaria FROM movimiento_caja ORDER BY id_movimiento DESC LIMIT 1;
INSERT INTO gastos_movimiento_caja(id_gasto, id_movimiento_caja) VALUES (new.id_gasto, id_ultimo_movimiento_caja_diaria);

RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_INSERTAR_GASTO_EN_CAJA AFTER INSERT ON GASTOS
FOR EACH ROW
EXECUTE PROCEDURE SP_TR_INSERTAR_GASTO_EN_CAJA();
/* Aca termina el trigger para insertar el total de una gasto en caja */