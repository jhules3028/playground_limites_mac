# Portada: mapa de archivos y responsabilidades

## Alcance

Este documento registra los archivos que componen la portada del objeto de aprendizaje sobre límites. La portada es la primera pantalla del Playground y actualmente incluye:

- Identidad visual de la FES Acatlán y la UNAM.
- Título “Explora los límites”.
- Descripción introductoria del recurso.
- Tarjetas “Observa”, “Comprende” y “Practica”.
- Una representación gráfica introductoria.
- Crédito a “Julián de Jesús Campos Brandt”.
- Botón “Comenzar”.
- Transición provisional hacia el módulo 1.

## Estructura relacionada

```text
MyPlayground.playground/
├── Contents.swift
├── Sources/
│   ├── StartPlayground.swift
│   ├── PlaygroundFactory.swift
│   ├── MainView.swift
│   ├── CoverView.swift
│   ├── AppTheme.swift
│   ├── AppState.swift
│   └── AppSection.swift
└── Resources/
    └── fes-acatlan-logo.png
```

## Archivos principales de la portada

### `Sources/CoverView.swift`

Es el archivo principal de la portada. Contiene la composición visual y los componentes que solamente utiliza esta pantalla.

Responsabilidades:

- Distribuir el contenido horizontalmente en ventanas amplias.
- Reorganizar el contenido verticalmente cuando el espacio es reducido.
- Mostrar el encabezado institucional.
- Mostrar el título, descripción y beneficios del recorrido.
- Mostrar la tarjeta con la gráfica introductoria.
- Mostrar el nombre del autor.
- Ejecutar la acción `onStart` al presionar “Comenzar”.
- Dibujar el fondo decorativo y el marco dorado.

Componentes internos:

- `FESLogoView`: carga el logotipo desde `Resources`. Si el archivo no está disponible, muestra un reemplazo textual.
- `FeaturePill`: construye las etiquetas “Observa”, “Comprende” y “Practica”.
- `LimitPreviewCard`: presenta la idea “Acercarse sin necesariamente llegar”.
- `ValueSummary`: muestra los valores resumidos `x → 2`, `f(x) → 4` y límite `4`.
- `LimitCurvePreview`: dibuja con SwiftUI la cuadrícula, los ejes, la curva, el punto móvil y el hueco.

### `Sources/AppTheme.swift`

Define la identidad visual compartida por la portada.

Contiene:

- Azul marino y azul profundo para el fondo.
- Azul claro para la gráfica.
- Dorado y dorado claro para acentos.
- Blanco cálido y texto secundario.
- Degradado principal del fondo.
- Degradado utilizado por la tarjeta matemática.

Centralizar estos valores evita repetir colores diferentes dentro de `CoverView.swift` y permitirá conservar el mismo estilo en los módulos futuros.

### `Resources/fes-acatlan-logo.png`

Es el logotipo institucional mostrado en el encabezado.

Características:

- Archivo PNG local.
- Fondo transparente.
- Dimensiones de 250 × 60 píxeles.
- No requiere conexión a internet durante la ejecución.
- Se carga mediante `Bundle.main` desde `FESLogoView`.

## Archivos de arranque y presentación

### `Contents.swift`

Es el punto de entrada obligatorio del archivo `.playground`.

Su único contenido es:

```swift
launchPlayground()
```

No contiene diseño ni lógica de la portada. Solo llama al arranque que está dentro de `Sources`.

### `Sources/StartPlayground.swift`

Contiene el arranque visible del Playground.

Responsabilidades:

- Mantener activa la ejecución para permitir interacciones.
- Solicitar la vista principal.
- Asignar la vista a `PlaygroundPage.current.liveView`.
- Realizar la creación de la interfaz en el actor principal de macOS.

Expone la función pública `launchPlayground()`, que es llamada desde `Contents.swift`.

### `Sources/PlaygroundFactory.swift`

Construye la vista compatible con el Live View de Xcode.

Responsabilidades:

- Crear una instancia de `AppState`.
- Crear `MainView` con ese estado.
- Envolver la interfaz SwiftUI en `NSHostingView`.
- Establecer un tamaño inicial de 1,100 × 720 puntos.

## Archivos de navegación relacionados

### `Sources/MainView.swift`

Es el contenedor que decide qué pantalla se presenta.

En el estado inicial muestra `CoverView`. Cuando el usuario presiona “Comenzar”, muestra temporalmente `ModulePlaceholderView`, que representa el futuro módulo 1.

También aplica:

- El fondo global.
- El tamaño mínimo de la experiencia.
- El esquema de color oscuro.
- Las transiciones entre la portada y el módulo.

`ModulePlaceholderView` no es todavía el contenido real del módulo 1. Solo permite comprobar que el botón y el cambio de pantalla funcionan.

### `Sources/AppState.swift`

Administra el estado de navegación usado por la portada.

Estado actual:

- Inicia en `.cover`.
- Registra las secciones visitadas.
- Cambia a `.intuitiveLimit` cuando se presiona “Comenzar”.
- Permite volver a la portada desde la pantalla provisional.

Funciones relacionadas:

- `startLearning()`.
- `goToCover()`.
- `go(to:)`.

### `Sources/AppSection.swift`

Enumera la portada y los siete módulos previstos:

1. Idea intuitiva.
2. Representación numérica.
3. Interpretación gráfica.
4. Límites laterales.
5. Cálculo algebraico.
6. Continuidad.
7. Evaluación final.

Aunque las demás pantallas todavía no están construidas, esta enumeración permite que la portada se conecte desde ahora con el recorrido completo planeado.

## Flujo de ejecución

```text
Contents.swift
    ↓ llama a launchPlayground()
StartPlayground.swift
    ↓ solicita la vista principal
PlaygroundFactory.swift
    ↓ crea AppState y MainView
MainView.swift
    ↓ muestra la sección inicial
CoverView.swift
    ↓ utiliza
AppTheme.swift + fes-acatlan-logo.png
```

## Flujo del botón “Comenzar”

```text
Botón en CoverView
    ↓ ejecuta onStart
MainView
    ↓ llama a AppState.startLearning()
AppState
    ↓ cambia de .cover a .intuitiveLimit
MainView
    ↓ muestra la pantalla provisional del módulo 1
```

## Dependencias utilizadas

La portada utiliza únicamente tecnologías incluidas en macOS y Xcode:

- `SwiftUI`: interfaz, distribución, colores y dibujos.
- `AppKit`: carga del PNG y `NSHostingView`.
- `Combine`: publicación de cambios de estado.
- `PlaygroundSupport`: presentación de la interfaz en el Live View.
- `Foundation`: tipos básicos y soporte del modelo.

No utiliza librerías externas ni servicios de red.

## Estado actual

La portada y su navegación inicial están implementadas. El módulo 1 todavía es una pantalla provisional. La siguiente etapa sustituirá esa pantalla por `IntuitiveLimitView.swift`, conservando el mismo estado, navegación y tema visual.
