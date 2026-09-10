# Módulo 3: interpretación gráfica

## Objetivo

El estudiante distinguirá visualmente el comportamiento de una función cerca de un punto y el valor que la función toma exactamente en ese punto.

El ejemplo central utiliza:

```text
a = 2
L = 4
f(x) = x + 2, para los valores cercanos a 2
```

La misma curva se presenta con tres posibilidades en el punto objetivo:

- `f(2) = 4`: el valor de la función coincide con el límite.
- `f(2)` no existe: la gráfica tiene un hueco en `(2, 4)`.
- `f(2) = 6`: el valor exacto es diferente del límite.

En los tres casos, los valores cercanos de la curva se aproximan a `4`.

## Organización

El código específico está agrupado en:

```text
MyPlayground.playground/Sources/module_3/
├── ModuleThreeView.swift
├── ModuleThreeReadingView.swift
├── ModuleThreeExploreView.swift
├── ModuleThreeSummaryView.swift
├── ModuleThreeComponents.swift
├── ModuleThreeGraph.swift
└── ModuleThreeExample.swift
```

## Pantallas

### Pantalla 1: leer la gráfica

Archivo: `ModuleThreeReadingView.swift`.

Incluye:

- Presentación de los ejes `x` y `y`.
- Curva de la función.
- Punto móvil que representa un valor cercano.
- Guías doradas para `a = 2` y `L = 4`.
- Hueco que indica que `f(2)` no está definida.
- Comparación inicial entre `lim x→2 f(x)` y `f(2)`.
- Explicación de que el límite puede existir aunque haya un hueco.

### Pantalla 2: explorar los tres casos

Archivo: `ModuleThreeExploreView.swift`.

Incluye:

- Selector de tres casos: `f(a) = L`, `f(a)` no existe y `f(a) ≠ L`.
- Deslizador para mover `x` a ambos lados de `a = 2`.
- Botones para colocar rápidamente `x` a la izquierda, exactamente en `a` o a la derecha.
- Actualización en tiempo real de `x` y `f(x)`.
- Lectura permanente del límite `L = 4`.
- Lectura del valor exacto `f(a)` según el caso seleccionado.
- Retroalimentación dinámica que identifica desde qué lado se aproxima el estudiante.

Cambiar el punto exacto no modifica la curva cercana. Esto permite observar que el límite depende de la tendencia y no de un único punto.

### Pantalla 3: diferenciar y comprobar

Archivo: `ModuleThreeSummaryView.swift`.

Incluye:

- Comparación directa entre `lim x→2 f(x) = 4` y `f(2) = 6`.
- Gráfica con un hueco en `(2, 4)` y un punto lleno en `(2, 6)`.
- Pregunta de opción múltiple.
- Retroalimentación para respuestas correctas e incorrectas.
- Síntesis de la diferencia entre comportamiento cercano y valor exacto.

## Responsabilidad de los demás archivos

### `ModuleThreeView.swift`

- Contiene las tres pantallas del módulo.
- Administra la pantalla interna seleccionada.
- Permite volver al módulo 2 desde la primera pantalla.
- Permite volver a la portada.
- Al terminar, registra el módulo 3 como completado y continúa hacia el módulo 4.

### `ModuleThreeGraph.swift`

Dibuja la gráfica completamente con SwiftUI, sin imágenes externas:

- Cuadrícula y ejes coordenados.
- Curva lineal de referencia.
- Guías del punto objetivo y del límite.
- Punto móvil y su guía vertical.
- Hueco del límite.
- Punto exacto de `f(a)` cuando existe.
- Etiquetas de `a`, `L`, `x`, `y` y `f(a)`.

### `ModuleThreeComponents.swift`

Contiene:

- Encabezado del módulo.
- Indicador de progreso de tres pantallas.
- Navegación inferior.
- Leyenda de la gráfica.
- Selector de casos.
- Tarjetas para valores numéricos en tiempo real.

### `ModuleThreeExample.swift`

Contiene la lógica matemática separada de la interfaz:

- Punto objetivo `a = 2`.
- Límite esperado `L = 4`.
- Valor alternativo `f(2) = 6`.
- Cálculo de la curva cercana `f(x) = x + 2`.
- Representación opcional de un valor no definido.
- Formato de valores con dos cifras decimales.

## Cambios en archivos compartidos

### `AppState.swift`

Se agregó `completeModuleThree()`, que:

- Marca `.graphicalLimit` como completado.
- Abre `.oneSidedLimits`, correspondiente al módulo 4.

### `MainView.swift`

Se agregó el caso `.graphicalLimit` para mostrar `ModuleThreeView` y conectar las acciones de salida, regreso y finalización.

## Flujo

```text
Módulo 2
   ↓ Terminar módulo
Pantalla 1: leer la gráfica
   ↓ Siguiente
Pantalla 2: mover x y comparar los tres casos
   ↓ Siguiente
Pantalla 3: diferenciar y responder
   ↓ Terminar módulo
Módulo 4: límites laterales
```

## Validaciones realizadas

- Compilación recursiva de todos los archivos Swift.
- Compilación del módulo auxiliar y del punto de entrada del Playground.
- Renderizado local de las tres pantallas a 1,100 × 720 puntos.
- Revisión visual de legibilidad, distribución y ausencia de recortes.
- Revisión de los tres estados posibles de `f(a)`.
- Confirmación de que el módulo 2 abre el módulo 3 y que el módulo 3 continúa hacia el módulo 4.

## Estado

El módulo 3 está implementado en español y conectado con el módulo 4.
