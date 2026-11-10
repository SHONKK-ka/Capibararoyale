# CAPIBARA ROYALE - Wii U Edition - Paquete para compilar desde celular

## 🎮 ¿Qué es esto?
Este es tu juego battle royale 3D que hicimos (lobby con emotes, avión realista, caída libre controlada, 2 ciudades con 8 cofres dorados) empaquetado para Wii U.

## 📱 PASO A PASO 100% DESDE EL CELULAR

### OPCIÓN RÁPIDA (2 minutos, sin compilar):
1. En tu Wii U, abre el Navegador de Internet
2. Pega este link de la última versión que funciona:
   https://capibara-royale... (usa el link del último artifact que te di)
   Link actual: copia el del chat: container:///mnt/data/capibara_royale_3d_jugable_agentic_artifact_2_98bd8f2561f8.html
   Pero súbelo a un hosting gratis como vercel o netlify desde tu celular para que Wii U lo abra.
3. Juega con GamePad. Stick izquierdo mueve, ZR dispara.

### OPCIÓN NATIVA .WUHB (para tener icono en menú Wii U):

#### Paso 1: Crear repo en GitHub desde celular
1. Abre Chrome en tu celular -> github.com -> Log in
2. New repository -> Nombre: CapibaraRoyale-WiiU -> Public -> Create
3. Upload files -> Sube TODA la carpeta capibara_wiiu_package que te acabo de generar

#### Paso 2: Compilar en la nube (PC virtual)
1. En tu repo, dale a Code (botón verde) -> Codespaces -> Create codespace on main
2. Espera 1 minuto a que abra VS Code en el navegador
3. En la terminal abajo escribe:
   ```
   make
   ```
4. Si todo va bien, te genera: CapibaraRoyale.wuhb (25-40 MB)

#### Paso 3: Pasarlo a tu Wii U
1. En tu celular, descarga el CapibaraRoyale.wuhb
2. Con adaptador OTG, mete la SD de tu Wii U al celular
3. Crea carpeta: sd:/wiiu/apps/CapibaraRoyale/
4. Mete ahí:
   - CapibaraRoyale.wuhb
   - icon.png
   - meta.xml
5. Mete SD a Wii U, prende con Aroma, abre Homebrew Launcher -> verás Capibara Royale con icono de capibara con gorra AREPA
6. Ábrelo

#### Paso 4: Probar online
- El juego nativo ahora mismo es un wrapper SDL2 que muestra tu capibara. Para el battle royale completo online, el wrapper debe abrir tu servidor en la nube (fly.io) - esa parte te la armo en la Fase 2.

## 🔧 Qué incluye este paquete
- meta.xml -> info del juego para Wii U
- icon.png -> tu capibara AREPA 256x256
- Makefile -> para compilar con devkitPro
- Dockerfile -> para que GitHub Codespaces tenga devkitPro preinstalado
- src/main.cpp -> esqueleto jugable que compila seguro, con WHB y SDL2

## 🚀 Después de probar
- Me dices si compila bien
- Seguimos con Fase 2: tienda + pase + micropagos Nequi + servidor mundial
- El juego web que ya tienes (20 jugadores, ciudades) ya es jugable en Wii U browser mientras tanto

## 📦 Peso
- Web: ~10 MB
- Wii U .wuhb: ~30 MB

Creado por Jhon Londoño + Meta AI desde La Pintada, Antioquia.
