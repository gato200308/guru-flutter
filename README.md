
# Guru App

Aplicación Flutter multiplataforma para la venta de artesanías, con backend PHP desplegado en la nube.

## Descripción

Guru App permite a los usuarios registrarse, iniciar sesión, editar perfil, explorar productos artesanales, gestionar favoritos, realizar compras y más. El backend está desarrollado en PHP y se comunica mediante peticiones HTTP a un servidor remoto seguro.

## Características principales

- Autenticación de usuarios (login, registro, recuperación de contraseña)
- Edición de perfil y foto de usuario
- Listado y detalle de productos artesanales
- Carrito de compras y gestión de pedidos
- Favoritos y reseñas de productos
- Métodos de pago y historial de compras
- Backend PHP en la nube (no requiere XAMPP)
- Diseño responsivo y moderno
- Soporte multiplataforma: Windows, Android, Web, Linux, macOS
- Flujo de trabajo colaborativo con ramas

## Estructura del proyecto

```text
guru_app/
├── assets/                # Imágenes y recursos
├── lib/
│   ├── main.dart          # Punto de entrada de la app
│   ├── config/            # Configuración y constantes
│   ├── models/            # Modelos de datos
│   ├── screens/           # Pantallas principales (login, registro, perfil, productos, carrito, favoritos, pedidos)
│   ├── services/          # Servicios (API, sesión, etc.)
│   ├── utils/             # Utilidades y helpers
│   └── widgets/           # Componentes reutilizables
├── pubspec.yaml           # Configuración de dependencias y assets
├── README.md              # Este archivo
```

## Instalación y ejecución

1. Clona el repositorio:

	```bash
	git clone https://github.com/gato200308/guru-flutter.git
	cd guru-flutter/guru_app
	```

2. Instala las dependencias:

	```bash
	flutter pub get
	```

3. Agrega tu logo en la carpeta `assets` y verifica que esté declarado en `pubspec.yaml`.

4. Ejecuta la app:

	```bash
	flutter run
	```

## Configuración del backend

- El backend está desplegado en la nube y configurado en `lib/config/api_config.dart`.
- No es necesario instalar ni configurar XAMPP ni servidores locales.
- Los endpoints se encuentran en la URL pública definida en la configuración.

## Flujo de trabajo con ramas

- `master`: rama principal y estable
- `develop`: integración de nuevas funcionalidades
- `login`, `registro`, `carrito`, etc.: desarrollo de características específicas

## Recomendaciones para desarrollo

- Si tienes problemas con imágenes o assets, revisa la ruta y la declaración en `pubspec.yaml`.
- Si desarrollas en Windows y ves errores de CMake, ejecuta:

	```powershell
	flutter clean
	flutter pub get
	flutter build windows
	```

## Documentación

Para más información sobre Flutter, consulta la [documentación oficial](https://docs.flutter.dev/).
