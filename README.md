# guru_app

A new Flutter project app.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:


## Guru App

Aplicación Flutter para la venta de artesanías.

## Descripción

Guru App es una aplicación multiplataforma desarrollada en Flutter. Permite a los usuarios registrarse, iniciar sesión y acceder a una pantalla principal de productos artesanales. El backend está desarrollado en PHP y se comunica mediante peticiones HTTP.

## Características

- Login y registro de usuarios
- Pantalla principal con productos artesanales
- Carrito de compras (en desarrollo)
- Conexión a backend PHP (XAMPP)
- Diseño responsivo y moderno
- Soporte multiplataforma (Windows, Android, Web, etc.)
- Trabajo colaborativo con ramas (login, registro, develop, master)

## Estructura del Proyecto

```
guru_app/
│
├── assets/                # Imágenes y recursos
│   └── logosinfondo.png
├── lib/
│   ├── main.dart          # Punto de entrada de la app
│   └── screens/
│       └── login.dart     # Pantalla de login
├── pubspec.yaml           # Configuración de dependencias y assets
├── README.md              # Este archivo
│
└── backend_php/           # (En XAMPP) Código PHP para login y registro
```

## Instalación y Ejecución

1. **Clona el repositorio:**
	```bash
	git clone https://github.com/gato200308/guru-flutter.git
	cd guru-flutter/guru_app
	```

2. **Instala las dependencias:**
	```bash
	flutter pub get
	```

3. **Agrega tu logo en la carpeta `assets` y verifica que esté declarado en `pubspec.yaml`.**

4. **Ejecuta la app:**
	```bash
	flutter run
	```

5. **(Opcional) Ejecuta el backend en XAMPP:**
	- Coloca los archivos PHP en `C:\xampp\htdocs\backend_php`
	- Asegúrate de tener la base de datos y la tabla `usuarios` configuradas.

## Configuración del Backend

- El backend está en PHP y se encuentra en la carpeta `backend_php`.
- El archivo `login.php` recibe peticiones POST con JSON y responde con el estado de autenticación.

## Flujo de trabajo con ramas

- `master`: rama principal y estable
- `develop`: rama de integración de nuevas funcionalidades
- `login`, `registro`, etc.: ramas de desarrollo de características específicas

## Colaboradores

- santi (Frontend Flutter)
- [Nombre de tu amigo] (Backend y lógica de navegación)

## Notas

- Si tienes problemas con imágenes o assets, revisa la ruta y la declaración en `pubspec.yaml`.
- Si desarrollas en Windows y ves errores de CMake, ejecuta:
  ```powershell
  flutter clean
  flutter pub get
  flutter build windows
  ```
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
