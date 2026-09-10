# Módulo 6: continuidad y discontinuidades

## Objetivo

El estudiante relacionará la existencia de un límite con la continuidad de una función y comprobará cada caso mediante tres condiciones:

1. `f(a)` existe.
2. `lim x→a f(x)` existe.
3. `lim x→a f(x) = f(a)`.

Si falla cualquiera de ellas, la función no es continua en el punto estudiado.

## Organización

```text
MyPlayground.playground/Sources/module_6/
├── ModuleSixView.swift
├── ModuleSixIntroductionView.swift
├── ModuleSixCaseStudyView.swift
├── ModuleSixAssessmentView.swift
├── ModuleSixComponents.swift
├── ModuleSixGraph.swift
└── ModuleSixExample.swift
```

## Pantallas

### Pantalla 1: las tres condiciones

Archivo: `ModuleSixIntroductionView.swift`.

Incluye:

- Interpretación intuitiva de continuidad.
- Explicación de que la apariencia de una curva no sustituye la comprobación matemática.
- Las tres condiciones de continuidad presentadas individualmente.
- Relación entre límites laterales y existencia del límite bilateral.
- Presentación de los tres casos visuales del módulo.

### Pantalla 2: función continua

Archivo: `ModuleSixCaseStudyView.swift`, configurado con `.continuous`.

Utiliza `f(x) = x + 2` alrededor de `a = 2`.

Se comprueba que:

- `f(2) = 4`.
- `lim x→2 f(x) = 4`.
- El límite coincide con el valor de la función.

Las tres condiciones se muestran como satisfechas.

### Pantalla 3: discontinuidad removible

Archivo: `ModuleSixCaseStudyView.swift`, configurado con `.removable`.

Utiliza `f(x) = x + 2` para `x ≠ 2`.

Se comprueba que:

- `f(2)` no existe.
- `lim x→2 f(x) = 4` sí existe.
- No puede cumplirse la igualdad con `f(2)`.

La pantalla explica que definir `f(2) = 4` repararía el hueco y por eso la discontinuidad es removible.

### Pantalla 4: discontinuidad de salto

Archivo: `ModuleSixCaseStudyView.swift`, configurado con `.jump`.

Utiliza:

```text
f(x) = x + 1, si x < 2
f(x) = x + 3, si x ≥ 2
```

Se comprueba que:

- `f(2) = 5` sí existe.
- El límite izquierdo vale `3`.
- El límite derecho vale `5`.
- El límite bilateral no existe.

Este caso demuestra que cumplir solamente la primera condición no garantiza continuidad.

### Interacción de las pantallas 2, 3 y 4

Las tres pantallas comparten:

- Gráfica interactiva.
- Deslizador para mover `x` alrededor de `a = 2`.
- Botones para colocarse a la izquierda, exactamente en `a` o a la derecha.
- Lecturas en tiempo real de `x`, `f(x)`, límite y `f(2)`.
- Lista visual de las tres condiciones.
- Retroalimentación específica para el caso seleccionado.

### Pantalla 5: actividad de identificación

Archivo: `ModuleSixAssessmentView.swift`.

Incluye dos casos:

1. Identificar una discontinuidad removible a partir de una gráfica con hueco.
2. Explicar por qué una función con `f(2) = 5`, límite izquierdo `3` y límite derecho `5` no es continua.

Cada pregunta incluye retroalimentación inmediata y contador de aciertos.

## Responsabilidad de los demás archivos

### `ModuleSixView.swift`

- Administra las cinco pantallas.
- Permite regresar al módulo 5.
- Permite volver a la portada.
- Registra el módulo 6 como completado y continúa hacia la evaluación final.

### `ModuleSixGraph.swift`

Dibuja con SwiftUI:

- Ejes y cuadrícula.
- Punto objetivo `a = 2`.
- Curva continua.
- Curva con hueco.
- Función por partes con salto.
- Puntos llenos y huecos.
- Límites bilaterales y laterales.
- Punto móvil controlado por el deslizador.

### `ModuleSixComponents.swift`

Contiene:

- Encabezado, progreso y navegación.
- Lista reutilizable de condiciones de continuidad.
- Indicadores de cumplimiento o incumplimiento.
- Tarjetas para valores numéricos en tiempo real.

### `ModuleSixExample.swift`

Separa de la interfaz:

- Las funciones de los tres casos.
- El valor de `f(2)`.
- Los límites izquierdo y derecho.
- La existencia del límite bilateral.
- Los resultados de las tres condiciones.

## Integración

Se agregó `completeModuleSix()` en `AppState.swift` y el caso `.continuity` en `MainView.swift`.

El flujo queda así:

```text
Módulo 5
   ↓
Tres condiciones
   ↓
Caso continuo
   ↓
Discontinuidad removible
   ↓
Discontinuidad de salto
   ↓
Actividad de identificación
   ↓
Evaluación final
```

## Validaciones realizadas

- Compilación recursiva de todos los archivos Swift.
- Compilación del módulo auxiliar y de `Contents.swift`.
- Verificación de los valores de función y límites de los tres casos.
- Comprobación de los patrones `[sí, sí, sí]`, `[no, sí, no]` y `[sí, no, no]`.
- Renderizado y revisión visual de las cinco pantallas a 1,100 × 720 puntos.
- Confirmación de la conexión entre los módulos 5, 6 y la evaluación final.

## Estado

El módulo 6 está implementado en español y conectado con la evaluación final.
