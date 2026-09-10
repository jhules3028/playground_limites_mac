# Despliegue del Playground en las Macs del laboratorio

## 1. Objetivo

Este documento explica cómo llevar el objeto de aprendizaje de límites a otra Mac y ejecutarlo en Xcode.

Existen dos métodos:

1. Clonar el repositorio con Git desde Terminal.
2. Descargar el repositorio como archivo ZIP desde GitHub.

Los dos métodos obtienen el mismo Playground. Para una computadora donde solamente se utilizará el material, descargar el ZIP es la opción más sencilla. Clonar el repositorio es más conveniente cuando se desea recibir actualizaciones posteriores mediante `git pull`.

## 2. Requisitos del laboratorio

Cada Mac debe contar con:

- macOS.
- Xcode instalado y abierto al menos una vez.
- Los componentes iniciales de Xcode ya instalados.
- Conexión a internet durante la descarga o clonación.

El proyecto es un Playground para macOS configurado con Swift 6. Se recomienda utilizar Xcode 16.2 o una versión posterior. La versión actual se validó con Xcode 26.6.

Después de descargarlo, el Playground funciona localmente y no necesita internet, cuentas externas ni librerías adicionales.

Antes de realizar el despliegue, se debe confirmar que la versión definitiva ya se encuentre en la rama `main` del repositorio:

`https://github.com/jhules3028/playground_limites_mac`

## 3. Método A: clonar el repositorio con Git

Este método crea una copia completa del repositorio en la Mac.

### 3.1 Abrir Terminal

Abrir **Terminal** desde:

`Aplicaciones > Utilidades > Terminal`

También se puede encontrar escribiendo `Terminal` en Spotlight.

### 3.2 Elegir dónde guardar el proyecto

Para guardarlo en el Escritorio, ejecutar:

```bash
cd ~/Desktop
```

### 3.3 Clonar la rama principal

Ejecutar:

```bash
git clone --branch main --single-branch https://github.com/jhules3028/playground_limites_mac.git
```

El repositorio es público, por lo que no es necesario iniciar sesión en GitHub.

Al terminar, se creará la carpeta:

```text
playground_limites_mac/
```

### 3.4 Entrar en la carpeta

```bash
cd playground_limites_mac
```

### 3.5 Abrir el Playground en Xcode

```bash
open -a Xcode MyPlayground.playground
```

También se puede abrir desde Finder:

1. Entrar en `Desktop/playground_limites_mac/`.
2. Localizar `MyPlayground.playground`.
3. Hacer doble clic sobre el archivo.
4. Si macOS pregunta con qué programa abrirlo, seleccionar Xcode.

Es importante abrir `MyPlayground.playground` completo. No se debe abrir únicamente `Contents.swift` como un archivo Swift independiente.

### 3.6 Actualizar una copia clonada anteriormente

Si el repositorio ya fue clonado en esa Mac y sólo se desea descargar la versión más reciente de `main`, ejecutar:

```bash
cd ~/Desktop/playground_limites_mac
git pull origin main
```

Después se puede abrir nuevamente:

```bash
open -a Xcode MyPlayground.playground
```

No se debe ejecutar `git clone` otra vez dentro de una carpeta que ya contiene el repositorio.

## 4. Método B: descargar el ZIP desde GitHub

Este método no requiere utilizar Terminal ni conocer Git.

### 4.1 Descargar el archivo

1. Abrir un navegador web.
2. Entrar a `https://github.com/jhules3028/playground_limites_mac`.
3. Confirmar que la rama seleccionada sea `main`.
4. Pulsar el botón verde **Code**.
5. Seleccionar **Download ZIP**.
6. Esperar a que finalice la descarga.

### 4.2 Descomprimir el proyecto

1. Abrir la carpeta **Descargas** en Finder.
2. Localizar el archivo descargado, normalmente llamado `playground_limites_mac-main.zip`.
3. Hacer doble clic para descomprimirlo.
4. Abrir la carpeta resultante `playground_limites_mac-main`.

La carpeta puede moverse al Escritorio si se desea, pero no es obligatorio.

### 4.3 Abrir el Playground

Dentro de la carpeta descomprimida:

1. Localizar `MyPlayground.playground`.
2. Hacer doble clic sobre él.
3. Seleccionar Xcode si macOS solicita una aplicación.

Otra posibilidad es abrir Xcode primero y utilizar:

`File > Open`

Después se selecciona `MyPlayground.playground` dentro de la carpeta descargada.

El ZIP debe descomprimirse antes de ejecutar el proyecto. No se debe intentar abrir el Playground directamente desde el archivo comprimido.

## 5. Cómo ejecutar el Playground en Xcode

Los siguientes pasos son iguales sin importar si el proyecto fue clonado o descargado como ZIP.

1. Esperar a que Xcode termine de abrir y preparar el Playground.
2. Mostrar el navegador del proyecto en el lado izquierdo si está oculto.
3. Seleccionar `Contents.swift`.
4. Confirmar que el contenido visible sea:

   ```swift
   launchPlayground()
   ```

5. Pulsar el botón triangular **Run** para ejecutar el Playground.
6. Esperar mientras Xcode compila los archivos ubicados en `Sources`.
7. La portada debe aparecer en el área de resultados o **Live View**.
8. Cuando aparezca la portada, se puede pulsar **Start** y recorrer los módulos normalmente.

La primera compilación puede tardar más que las siguientes. No es necesario seleccionar un simulador de iPhone, configurar una cuenta de desarrollador ni firmar el proyecto.

## 6. Archivos que deben permanecer juntos

El paquete debe conservarse completo porque contiene:

```text
MyPlayground.playground/
├── Contents.swift
├── contents.xcplayground
├── Sources/
└── Resources/
```

- `Contents.swift` inicia la experiencia.
- `Sources` contiene la portada, los seis módulos y la evaluación.
- `Resources` contiene el logotipo utilizado en la portada.
- `contents.xcplayground` indica a Xcode que se trata de un Playground para macOS.

Si se copia solamente `Contents.swift`, el proyecto no podrá encontrar el resto del código. Si falta `Resources`, el logotipo institucional puede no mostrarse.

## 7. Solución de problemas comunes

### Xcode muestra el código, pero no aparece la interfaz

1. Seleccionar `Contents.swift`.
2. Volver a pulsar **Run**.
3. Esperar a que desaparezca el indicador de compilación.
4. Mostrar el área de resultados o Live View desde las opciones del editor de Xcode si estuviera oculta.

### Xcode muestra errores relacionados con Swift 6

La versión de Xcode probablemente es demasiado antigua. Se debe actualizar Xcode o probar el Playground con una versión compatible con Swift 6.

### Aparece un error relacionado con `PlaygroundSupport`

Comprobar que se abrió el paquete `MyPlayground.playground` y no `Contents.swift` como archivo independiente.

### No aparece el logotipo

Comprobar que existe el archivo:

```text
MyPlayground.playground/Resources/fes-acatlan-logo.png
```

Si no existe, volver a descargar o clonar el repositorio completo.

### Terminal indica que `git` no está disponible

Se puede utilizar el método de descarga mediante ZIP. Como alternativa, macOS puede solicitar la instalación de las herramientas de línea de comandos al intentar usar Git.

### Ya existe una carpeta llamada `playground_limites_mac`

No volver a clonar encima de ella. Se puede actualizar con `git pull origin main`, cambiarle el nombre o elegir otra ubicación para obtener una copia nueva.

## 8. Recomendación para el laboratorio

Para preparar varias Macs rápidamente:

- Utilizar **Download ZIP** cuando los alumnos únicamente necesiten abrir y recorrer el material.
- Utilizar **Git clone** en la computadora del profesor o en equipos donde sea útil descargar futuras actualizaciones.
- Probar el Playground al menos una vez en una Mac del laboratorio antes de la clase.
- Confirmar que la portada, el logotipo, los seis módulos y la evaluación final se abran correctamente.

## 9. Lista final de comprobación

Antes de comenzar la sesión, verificar lo siguiente:

- La versión definitiva está publicada en `main`.
- Xcode abre `MyPlayground.playground` sin solicitar un simulador.
- `Contents.swift` contiene `launchPlayground()`.
- El botón **Run** inicia la compilación.
- La portada aparece en el Live View.
- El botón **Start** abre el módulo 1.
- El logotipo de la FES Acatlán aparece correctamente.
- Los módulos y la evaluación pueden recorrerse sin conexión a internet.
