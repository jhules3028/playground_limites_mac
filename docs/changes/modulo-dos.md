# Módulo 2: límites mediante tablas

## Objetivo

El estudiante observará numéricamente el comportamiento de una función cuando `x` se aproxima al punto objetivo desde valores menores y mayores.

El ejemplo central es:

```text
lim x→2 (x² - 4)/(x - 2) = 4
```

La expresión original no está definida en `x = 2`, pero los valores cercanos aportan evidencia de que el límite es `4`.

## Organización

El código específico está agrupado en:

```text
MyPlayground.playground/Sources/module_2/
├── ModuleTwoView.swift
├── ModuleTwoTableView.swift
├── ModuleTwoPrecisionView.swift
├── ModuleTwoSummaryView.swift
├── ModuleTwoComponents.swift
└── ModuleTwoExample.swift
```

## Pantallas

### Pantalla 1: leer la tabla

Archivo: `ModuleTwoTableView.swift`.

Incluye:

- Presentación del ejemplo y del punto objetivo `a = 2`.
- Diferenciación visual entre aproximación desde la izquierda y desde la derecha.
- Tabla con una, dos y tres cifras decimales.
- Resultados correspondientes de `f(x)`.
- Explicación del patrón observado.

Valores mostrados:

| x < 2 | f(x) | x > 2 | f(x) |
| ---: | ---: | ---: | ---: |
| 1.9 | 3.9 | 2.1 | 4.1 |
| 1.99 | 3.99 | 2.01 | 4.01 |
| 1.999 | 3.999 | 2.001 | 4.001 |

### Pantalla 2: cambiar la precisión

Archivo: `ModuleTwoPrecisionView.swift`.

Incluye:

- Selector de una, dos o tres cifras decimales.
- Actualización inmediata de los valores de ambos lados.
- Resaltado de la fila seleccionada.
- Visualización de la distancia respecto a `a = 2`.
- Explicación de que cada cifra adicional divide entre diez esa distancia.
- Conclusión dinámica de que ambos lados se aproximan a `4`.

### Pantalla 3: interpretar

Archivo: `ModuleTwoSummaryView.swift`.

Incluye:

- Comparación de las tendencias por izquierda y derecha.
- Conclusión numérica del límite.
- Pregunta de opción múltiple.
- Distractores que distinguen límite, valor de la función y uso del punto objetivo.
- Retroalimentación específica para respuestas correctas e incorrectas.
- Recordatorio de que una tabla aporta evidencia de aproximación, pero no define por sí sola `f(2)`.

## Responsabilidad de los demás archivos

### `ModuleTwoView.swift`

- Contiene las tres pantallas.
- Administra la pantalla interna seleccionada.
- Permite volver al módulo 1 desde la primera pantalla.
- Permite volver a la portada.
- Al terminar, registra el módulo 2 como completado y continúa hacia el módulo 3 provisional.

### `ModuleTwoComponents.swift`

Contiene:

- Encabezado del módulo.
- Indicador de progreso de tres pantallas.
- Navegación inferior.
- Tabla numérica reutilizable.
- Selector de precisión.
- Celdas y encabezados visuales de la tabla.

### `ModuleTwoExample.swift`

Contiene la lógica matemática separada de la interfaz:

- Punto objetivo `a = 2`.
- Valor límite esperado `L = 4`.
- Evaluación de `(x² - 4)/(x - 2)`.
- Protección del punto no definido `x = 2`.
- Generación de filas para cada precisión.
- Formato decimal consistente.
- Cálculo de la distancia respecto al objetivo.

## Cambios en archivos compartidos

### `AppState.swift`

Se agregó `completeModuleTwo()`, que:

- Marca `.numericalLimit` como completado.
- Abre `.graphicalLimit`, correspondiente al módulo 3.

### `MainView.swift`

Se agregó el caso `.numericalLimit` para mostrar `ModuleTwoView` y conectar las acciones de salida, regreso y finalización.

### `LessonComponents.swift`

Se creó como archivo compartido en la raíz de `Sources`. Ahora contiene:

- `ModuleCard`.
- `LessonEyebrow`.

Estos componentes antes estaban dentro del módulo 1. Se movieron sin cambiar su comportamiento para que los módulos 1 y 2 puedan utilizarlos sin depender entre sí.

## Flujo

```text
Módulo 1
   ↓ Terminar módulo
Pantalla 1: leer la tabla
   ↓ Siguiente
Pantalla 2: cambiar la precisión
   ↓ Siguiente
Pantalla 3: interpretar y responder
   ↓ Terminar módulo
Módulo 3 provisional
```

## Validaciones realizadas

- Compilación recursiva de todos los archivos Swift.
- Compilación del módulo auxiliar y del punto de entrada del Playground.
- Comprobación de los resultados numéricos de las tres filas.
- Renderizado local de las tres pantallas a 1,100 × 720 puntos.
- Revisión visual de legibilidad, distribución y ausencia de recortes.

## Estado

El módulo 2 está implementado en español. El módulo 3 continúa como pantalla provisional hasta la siguiente etapa.
