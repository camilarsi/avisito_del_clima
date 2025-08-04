# Tiempito

App del clima desarrollada en Flutter que permite consultar el estado del tiempo de tu ubicación
actual o una ciudad seleccionada manualmente.

## Requisitos

- Flutter 3.x
- Dart SDK
- Android Studio o Xcode (según plataforma)
- Dispositivo físico o emulador

## Instalación

1. **Clonar el repositorio**

```bash
git clone https://github.com/camilarsi/avisito_del_clima
cd avisito_del_clima
```

El nombre del proyecto cambió durante el desarrollo y por eso el repositorio tiene un nombre
diferente al de la app: 'Clima' es rigurosamente el promedio del 'Tiempo' de determinado periodo
de años...

2. **Instalar dependencias**

```bash
   flutter pub get
```

3. **Configurar claves**
   Crear un archivo .env en la raíz del proyecto con tu API Key:

```.env
WEATHER_API_KEY=tu_api_key
```  

4. **Revisar permisos**
   Asegurarte de tener los permisos de ubicación en:
    - android/app/src/main/AndroidManifest.xml
    - ios/Runner/Info.plist

5. **Ejecutar la app en dispositivo mobile Android, iOS, emulador o simulador**

```bash
flutter devices 
flutter run -d <device-id>
```
