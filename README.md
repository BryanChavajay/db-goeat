# DOCUMENTACIÓN DE LA API

## Introducción
La API que sea ha desarrollado para el proyecto _GOEAT_ es una **REST API** por lo que se cuentan con diferentes rutas para cada modulo.

En la tabla siguiente se muestran cada uno de los modulos disponibles y su ruta de consulta.

**NOTA: ${} hace referencia a una variable de entorno que contiene el dominio** 

| Modulo      | Ruta                 |
| ----------- | -------------------- |
| Dashboard   | ```${}\dashboard\``` |
| Inventario  | ```${}\inventory\``` |
| Usuarios    | ```${}\users\```     |
| Login       | ```${}\login\```     |
| Menu        | ```${}\menu\```      |
| Proveedores | ```${}\providers\``` |
| Clientes    | ```${}\customers\``` |
| Caja        | ```${}\cash\```      |
| Reportes    | ```${}\reports\```   |

## Dashboard
### Dashboard schema
El modulo de Dashboard muestra 5 diferentes datos 
| Key              | Type  | Description                                                |
| ---------------- | ----- | ---------------------------------------------------------- |
| ingresos         | Money | Muestra el total de los ingresos del mes en curso          |
| egresos          | Money | Muestra el total de los egresos del mes en curso           |
| ganancias        | Money | Muestra el total de las ganancias del mes en curso         |
| saldo            | Money | Muestra el total del dinero disponible actualmente en caja |
| gananciasAnuales | Array | Muestra el total de las ganancias del año en curso         |

#### Obtener todo los datos
Se puede acceder a todos los datos del dashboard utilizando:

**GET** ```${}\dashboard\```
``` json
{
    "ingresos": 500,
    "egresos": 300,
    "ganancias": 200,
    "saldo": 200,
    "gananciasAnuales":
    [
        "enero": 100, 
        "febrero": 100, 
        // ...
    ]
}
```

## Inventario
### Esquema de inventario
