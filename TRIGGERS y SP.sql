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


/* TRIGGER PARA DETECTAR UNA ACTUALIZACIÓN DEL TOTAL DE UNA VENTA
   ACTUALIZAR EL TOTAL DE ESA VENTA EN CAJA
*/ 
CREATE FUNCTION SP_TR_ACTUALIZAR_VENTA_CAJA() RETURNS TRIGGER
AS
$$
DECLARE
/* Variable que guarda el id_movimiento a actualizar */
id_movimiento_caja_para_actualizar BIGINT;

BEGIN

/* Seleccionamos el id_movimiento_caja a actualizar y la asignamos a la variable id_movimiento_caja_para_actualizar con el INTO
   la declaración new. trae los datos del registro insertado/actualizado new.id_venta seleccionamos cual campo necesitamos
*/
SELECT id_movimiento_caja INTO id_movimiento_caja_para_actualizar FROM venta_movimiento_caja WHERE id_venta=new.id_venta;
/* Actualizamos el registro en movimiento de caja new.total es el total actualizado de la venta */
UPDATE movimiento_caja SET total=new.total WHERE id_movimiento=id_movimiento_caja_para_actualizar;

RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_ACTUALIZAR_VENTA_CAJA AFTER UPDATE ON ventas
FOR EACH ROW
EXECUTE PROCEDURE SP_TR_ACTUALIZAR_VENTA_CAJA();
/* Aca termina el trigger que detecta si se actualizo el total de una venta lo actualiza en caja */


/* TRIGGER PARA DETECTAR UNA ACTUALIZACIÓN DEL TOTAL DE UN GASTO
   ACTUALIZAR EL TOTAL DE ESE GASTO EN CAJA
*/ 
CREATE FUNCTION SP_TR_ACTUALIZAR_GASTO_CAJA() RETURNS TRIGGER
AS
$$
DECLARE
/* Variable que guarda el id_movimiento a actualizar */
id_movimiento_caja_para_actualizar BIGINT;

BEGIN

/* Seleccionamos el id_movimiento_caja a actualizar y la asignamos a la variable id_movimiento_caja_para_actualizar con el INTO
   la declaración new. trae los datos del registro insertado/actualizado new.id_venta seleccionamos cual campo necesitamos
*/
SELECT id_movimiento_caja INTO id_movimiento_caja_para_actualizar FROM gastos_movimiento_caja WHERE id_gasto=new.id_gasto;
/* Actualizamos el registro en movimiento de caja new.total es el total actualizado de la venta */
UPDATE movimiento_caja SET total=new.total WHERE id_movimiento=id_movimiento_caja_para_actualizar;

RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_ACTUALIZAR_GASTO_CAJA AFTER UPDATE ON gastos
FOR EACH ROW
EXECUTE PROCEDURE SP_TR_ACTUALIZAR_GASTO_CAJA();
/* Aca termina el trigger que detecta si se actualizo el total de una venta lo actualiza en caja */


/* TRIGGER PARA DETECTAR SI UNA VENTA ES ELIMINADA, ESTA TAMBIEN SEA
   ELIMANDA DE SU TABLA INTERMEDIA Y SU REGISTRO EN CAJA
*/ 
CREATE FUNCTION SP_TR_ELIMINAR_VENTA_CAJA() RETURNS TRIGGER
AS
$$
DECLARE
/* Variable que guarda el id_movimiento a actualizar */
id_movimiento_caja_para_eliminar BIGINT;

BEGIN
/* Seleccionamos el id_movimiento que necesitamos eliminar y se lo asignamos a id_movimiento_caja_para_eliminar
   la declaración old. nos devuelve el registro que esta para eliminarse y con old.id_ventas traemos el id de la venta a eliminar
*/
SELECT id_movimiento_caja INTO id_movimiento_caja_para_eliminar FROM venta_movimiento_caja WHERE id_venta=old.id_venta;
/* Eliminamos la venta de la tabla intermedia entre movimiento caja y venta */
DELETE FROM venta_movimiento_caja WHERE id_venta=old.id_venta;
/* Eliminamos la venta de caja */
DELETE FROM movimiento_caja WHERE id_movimiento=id_movimiento_caja_para_eliminar;

RETURN OLD;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_ELIMINAR_VENTA_CAJA BEFORE DELETE ON ventas
FOR EACH ROW
EXECUTE PROCEDURE SP_TR_ELIMINAR_VENTA_CAJA();
/* Aca termina el trigger que detecta si una venta fue eliminada se quita de caja igual */


/* TRIGGER PARA DETECTAR SI UN GASTO ES ELIMINADO, ESTE TAMBIEN SEA
   ELIMANDO DE SU TABLA INTERMEDIA Y SU REGISTRO EN CAJA
*/ 
CREATE FUNCTION SP_TR_ELIMINAR_GASTO_CAJA() RETURNS TRIGGER
AS
$$
DECLARE
/* Variable que guarda el id_movimiento a actualizar */
id_movimiento_caja_para_eliminar BIGINT;

BEGIN
/* Seleccionamos el id_movimiento que necesitamos eliminar y se lo asignamos a id_movimiento_caja_para_eliminar
   la declaración old. nos devuelve el registro que esta para eliminarse y con old.id_gasto traemos el id del gasto a eliminar
*/
SELECT id_movimiento_caja INTO id_movimiento_caja_para_eliminar FROM gastos_movimiento_caja WHERE id_gasto=old.id_gasto;
/* Eliminamos la venta de la tabla intermedia entre movimiento caja y gasto */
DELETE FROM gastos_movimiento_caja WHERE id_gasto=old.id_gasto;
/* Eliminamos la venta de caja */
DELETE FROM movimiento_caja WHERE id_movimiento=id_movimiento_caja_para_eliminar;

RETURN OLD;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_ELIMINAR_GASTO_CAJA BEFORE DELETE ON gastos
FOR EACH ROW
EXECUTE PROCEDURE SP_TR_ELIMINAR_GASTO_CAJA();
/* Aca termina el trigger que detecta si una venta fue eliminada se quita de caja igual */