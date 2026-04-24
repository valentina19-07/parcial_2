# 📱 Parcial Flutter — Accidentes Tuluá + CRUD Establecimientos

## 🎯 Descripción
Aplicación móvil desarrollada en Flutter que integra dos módulos principales:

- 📊 Estadísticas de accidentes en Tuluá usando datos abiertos y procesamiento con Isolate.
- 🏢 CRUD de establecimientos consumiendo una API REST con carga de imágenes.

---

## 🌐 APIs utilizadas

### 🚗 API 1 — Accidentes de Tránsito Tuluá
- **Fuente:** Datos Abiertos Colombia  
- **Endpoint:**  
https://www.datos.gov.co/resource/ezt8-5wyj.json?$limit=100000  
- **Autenticación:** No requiere  

#### 📦 Campos relevantes
```json
{
  "clase_de_accidente": "Choque",
  "gravedad_del_accidente": "Con heridos",
  "barrio_hecho": "Centro",
  "dia": "Lunes",
  "hora": "08:30",
  "area": "Urbana",
  "clase_de_vehiculo": "Automóvil"
}
```

---

### 🏢 API 2 — Establecimientos (Parqueadero)
- **Base URL:**  
https://parking.visiontic.com.co/api  

#### 📍 Endpoints utilizados

| Método | Endpoint                     | Descripción          |
|--------|----------------------------|----------------------|
| GET    | /establecimientos          | Listar todos         |
| GET    | /establecimientos/{id}     | Obtener uno          |
| POST   | /establecimientos          | Crear                |
| POST   | /establecimiento-update/{id} | Editar (_method=PUT) |
| DELETE | /establecimientos/{id}     | Eliminar             |

#### 📦 Campos
```json
{
  "nombre": "San Pedro",
  "nit": "123456789",
  "direccion": "Cra 10",
  "telefono": "3001234567",
  "logo": "archivo_imagen"
}
```

---

## ⚙️ Future vs Isolate

### 🧵 Future / async / await
Se usa para:
- Consumo de APIs  
- Operaciones rápidas  

✔️ No bloquea la UI  
✔️ Ideal para tareas ligeras  

---

### 🚀 Isolate
Se usa para:
- Procesamiento de grandes volúmenes de datos  
- Evitar congelamiento de la aplicación  

👉 En este proyecto se utilizó para:
- Procesar más de 100,000 registros de accidentes  
- Generar estadísticas  

📌 Logs en consola:
```
[Isolate] Iniciado — N registros recibidos
[Isolate] Completado en X ms
```

---

## 🧱 Arquitectura del Proyecto

```
lib/
│
├── config/         → Configuración (Dio, dotenv)
├── models/         → Modelos de datos
├── services/       → Consumo de APIs
├── isolates/       → Procesamiento de estadísticas
├── views/          → Pantallas UI
│   ├── home/
│   ├── accidentes/
│   ├── establecimientos/
├── routes/         → Navegación (go_router)
```

---

## 🔄 Navegación con go_router

### 📍 Rutas
```
/ → Dashboard
/accidentes → Estadísticas
/establecimientos → Listado
/establecimientos/crear → Crear
/establecimientos/editar/:id → Editar
/establecimientos/detalle/:id → Detalle
```

### 📦 Paso de datos
```dart
context.push(
  '/establecimientos/editar/1',
  extra: establecimientoData,
);
```

---

## 📊 Funcionalidades

### 🏠 Dashboard
- Acceso a módulos  
- Total de accidentes  
- Total de establecimientos  
- Skeleton loading  

---

### 📈 Estadísticas
- Distribución por tipo de accidente → PieChart  
- Distribución por gravedad → PieChart / BarChart  
- Top 5 barrios → BarChart  
- Accidentes por día → Gráfica  

✔️ Uso de fl_chart  
✔️ Manejo de estados  

---

### 🏢 CRUD Establecimientos

#### 📋 Listado
- ListView.builder  
- Skeleton loading  

#### ➕ Crear
- Formulario + imagen  
- Envío multipart/form-data  

#### ✏️ Editar
- Datos precargados  
- `_method=PUT`  

#### ❌ Eliminar
- Confirmación  
- DELETE  

---

## 🧪 Ejemplo de JSON

### 🚗 Accidentes
```json
[
  {
    "clase_de_accidente": "Choque",
    "gravedad_del_accidente": "Con heridos",
    "barrio_hecho": "Centro"
  }
]
```

### 🏢 Establecimientos
```json
{
  "data": [
    {
      "id": 1,
      "nombre": "San Pedro",
      "nit": "123456789",
      "direccion": "Cra 10",
      "telefono": "3001234567"
    }
  ]
}
```

---

## 📦 Paquetes utilizados
- dio  
- go_router  
- flutter_dotenv  
- fl_chart  
- skeletonizer  
- image_picker  

---

## 🖼️ Capturas de la Aplicación

### 🏠 Dashboard
![Dashboard](assets/images/dashboard.jpeg)

### 📊 Estadísticas
![Graficas](assets/images/graficas.jpeg)

### 📋 Listado de Establecimientos
![Listado](assets/images/listado.jpeg)

### ➕ Crear Establecimiento
![Crear](assets/images/crear.jpeg)

### ✏️ Editar Establecimiento
![Editar](assets/images/editar.jpeg)

### ❌ Eliminación
![Eliminar](assets/images/eliminar.jpeg)

---

## 📁 Repositorio

- main → versión estable  
- dev → integración  
- feature/parcial_flutter_final → desarrollo  

