# DOCUMENTACIÓN DE LA API

## Introducción
La API que sea ha desarrollado para el proyecto _GOEAT_ es una **REST API** por lo que se cuentan con diferentes rutas para cada modulo.

## 1. Dashboard
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

**GET** ```${}/api/dashboard/```
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

## 2. Ventas
### Esquema de una venta
Para la venta y los datos que esta implica se cuentan con los siguientes campos
| Key           | Type   | Description                                                                                          |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------- |
| NumeroComanda | String | Este es el numero de la comanda que se esta registrando, que puede soportar caracteres alfanumericos |
| Fecha         | String | Fecha a la que pertenece la venta                                                                    |
| Total         | Money  | Total de la venta                                                                                    |
| IdMesero      | Entero | Este recibe el id del mesero que despacho la comanda                                                 |
| IdCliente     | Entero | Este recibe el id del cliente que consumio, por defecto para que sea CF se envia 1                   |
| DetalleVenta  | Array  | Arreglo con los detalles de la venta                                                                 |
| Mesero        | String | Nombre del mesero que despacho la comanda                                                            |

### Esquema del detalle de venta
El detalle de la venta es un array que recopila varios detalles de venta que pertenecen a una
| Key           | Type   | Description                                                          |
| ------------- | ------ | -------------------------------------------------------------------- |
| IdPlatillo    | Entero | Id del platillo que forma parte de la venta                          |
| Cantidad      | Entero | La cantidad del platillo seleccionadao que fueron despachados        |
| Subtotal      | Money  | El resultado de multiplicar la cantidad por el precio de la venta    |
| Observaciones | String | Cadena de texto con observaciones que se quieran dejar de un detalle |

#### Obtener todas las ventas
Se puede obtener un json de todas las ventas realizando una consulta **GET** a la ruta ```${}/api/Venta```

```json
[
    {
        "idVenta": 1,
        "numeroComanda": "12",
        "fecha": "2023-03-01",
        "total": 200.00,
        "mesero": "Roberto",
        "cliente": "CF",
        "detalleVenta": [
            {
                "id": 1,
                "platillo": "Carne asada",
                "idVenta": 1,
                "cantidad": 5,
                "subtotal": 200.00,
                "observaciones": " "
            }
        ]
    },
    {
        "idVenta": 2,
        "numeroComanda": "13",
        "fecha": "2023-03-01",
        "total": 80.00,
        "mesero": "Carlos",
        "cliente": "CF",
        "detalleVenta": [
            {
                "id": 2,
                "platillo": "Menu del dia",
                "idVenta": 2,
                "cantidad": 2,
                "subtotal": 50.00,
                "observaciones": " "
            },
            {
                "id": 3,
                "platillo": "Fresco de piña",
                "idVenta": 2,
                "cantidad": 2,
                "subtotal": 30.00,
                "observaciones": " "
            }
        ]
    },
    // ...
}
```

#### Obtener los datos de una unica venta
Se puede obtener un json con los datos que conforman una venta en especifico realizando una consulta **GET** a la ruta ```${}/api/Venta/{idVenta}```

```json
{
    "idVenta": 10,
    "numeroComanda": "003",
    "fecha": "2023-04-21",
    "total": 100.00,
    "mesero": "Carlos",
    "cliente": "Juana Perez",
    "detalleVenta": [
        {
            "id": 11,
            "platillo": "Menu del dia",
            "idVenta": 10,
            "cantidad": 1,
            "subtotal": 50.00,
            "observaciones": ""
        },
        {
            "id": 12,
            "platillo": "Arroz frito",
            "idVenta": 10,
            "cantidad": 1,
            "subtotal": 45.00,
            "observaciones": ""
        },
        {
            "id": 13,
            "platillo": "Fresco de piña",
            "idVenta": 10,
            "cantidad": 20,
            "subtotal": 120.00,
            "observaciones": "updateHOY"
        }
    ]
}
```

#### Registrar una venta
Para registrar una venta se debe tener en cuenta el esquema de ventas y el esquema de detalle de venta, para realizar la petición se debe utilizar **POST** a la ruta ```${}/api/Venta```, el Json que debe enviarse debe seguir la siguiente estructura

```json
{
  "NumeroComanda": "004",
  "Fecha": "2023-04-21",
  "Total": 1000,
  "IdMesero": 1,
  "IdCliente": 2,
  "DetalleVenta": [
    {
      "IdPlatillo": 7,
      "Cantidad": 2,
      "Subtotal": 70.00,
      "Observaciones": "Creado"
    },
    {
      "IdPlatillo": 2,
      "Cantidad": 1,
      "Subtotal": 45,
      "Observaciones": "Siiuuuu"
    },
    {
      "IdPlatillo": 5,
      "Cantidad": 2,
      "Subtotal": 200,
      "Observaciones": "xD"
    }
  ]
}
```