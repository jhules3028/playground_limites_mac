# Módulo 4: límites laterales

## Objetivo

El estudiante distinguirá la aproximación por la izquierda y por la derecha, calculará cada límite lateral y decidirá si existe el límite bilateral.

El ejemplo interactivo principal utiliza la función por partes:

```text
f(x) = x + 1, si x < 2
f(x) = x + 3, si x > 2
```

Por lo tanto:

```text
lim x→2⁻ f(x) = 3
lim x→2⁺ f(x) = 5
```

Como los límites laterales son diferentes, el límite bilateral no existe.

## Organización

```text
MyPlayground.playground/Sources/module_4/
├── ModuleFourView.swift
├── ModuleFourIntroductionView.swift
├── ModuleFourSidePlayground.swift
├── ModuleFourExistenceView.swift
├── ModuleFourPracticeView.swift
├── ModuleFourComponents.swift
├── ModuleFourGraph.swift
└── ModuleFourExample.swift
```

## Pantallas

### Pantalla 1: comprender las dos direcciones

Archivo: `ModuleFourIntroductionView.swift`.

Incluye:

- Definición del límite por la izquierda.
- Definición del límite por la derecha.
- Explicación de los signos `a⁻` y `a⁺`.
- Función por partes utilizada durante los playgrounds.
- Gráfica con un salto en `a = 2`.
- Colores diferentes para cada dirección.

### Pantalla 2: playground izquierdo

Archivo: `ModuleFourSidePlayground.swift`, configurado con `.left`.

Incluye:

- Regla `f(x) = x + 1` para `x < 2`.
- Deslizador de acercamiento.
- Punto móvil sobre la rama izquierda.
- Lecturas en tiempo real de `x`, `f(x)` y distancia hasta `a`.
- Resultado `lim x→2⁻ f(x) = 3`.
- Botón de máximo acercamiento que produce `x = 1.999`.

### Pantalla 3: playground derecho

Archivo: `ModuleFourSidePlayground.swift`, configurado con `.right`.

Incluye:

- Regla `f(x) = x + 3` para `x > 2`.
- El mismo control de acercamiento utilizado en la pantalla anterior.
- Punto móvil sobre la rama derecha.
- Lecturas en tiempo real de `x`, `f(x)` y distancia hasta `a`.
- Resultado `lim x→2⁺ f(x) = 5`.
- Botón de máximo acercamiento que produce `x = 2.001`.

En ambos playgrounds, mover el control hacia la derecha aumenta la aproximación. El valor `x = 2` nunca está disponible.

### Pantalla 4: condición de existencia

Archivo: `ModuleFourExistenceView.swift`.

Incluye un selector entre:

- Límites laterales que coinciden en `4`.
- Límites laterales diferentes, con valores `3` y `5`.

La gráfica, los valores y la conclusión cambian inmediatamente. La pantalla enseña que:

```text
lim x→a f(x) existe si y sólo si
lim x→a⁻ f(x) = lim x→a⁺ f(x)
```

### Pantalla 5: comprobación

Archivo: `ModuleFourPracticeView.swift`.

Incluye dos preguntas:

1. Interpretación del signo menos en `x → a⁻`.
2. Decisión sobre la existencia del límite cuando los laterales son diferentes.

Cada pregunta proporciona retroalimentación inmediata para respuestas correctas e incorrectas y muestra el número de aciertos.

## Responsabilidad de los demás archivos

### `ModuleFourView.swift`

- Administra las cinco pantallas.
- Permite regresar al módulo 3.
- Permite volver a la portada.
- Al terminar, registra el módulo 4 como completado y continúa al módulo 5.

### `ModuleFourGraph.swift`

Dibuja mediante SwiftUI:

- Cuadrícula y ejes.
- Línea vertical del punto objetivo.
- Ramas izquierda y derecha.
- Huecos correspondientes a los límites laterales.
- Guías para `L⁻` y `L⁺`.
- Punto móvil y su guía vertical.
- Atenuación de la rama que no se está estudiando.

### `ModuleFourComponents.swift`

Contiene el encabezado, progreso, navegación, definiciones laterales, tarjetas numéricas y selector de comparación.

### `ModuleFourExample.swift`

Contiene la lógica matemática:

- Punto objetivo `a = 2`.
- Conversión del nivel de acercamiento en un valor de `x`.
- Distancia mínima de `0.001`.
- Evaluación de las ramas izquierda y derecha.
- Límites laterales para los casos coincidente y diferente.
- Formato numérico con tres cifras decimales.

## Integración

Se agregó `completeModuleFour()` en `AppState.swift` y el caso `.oneSidedLimits` en `MainView.swift`.

El flujo queda así:

```text
Módulo 3
   ↓
Introducción
   ↓
Playground izquierdo
   ↓
Playground derecho
   ↓
Condición de existencia
   ↓
Dos preguntas
   ↓
Módulo 5 provisional
```

## Validaciones realizadas

- Compilación recursiva de todos los archivos Swift.
- Compilación del módulo auxiliar y de `Contents.swift`.
- Confirmación matemática de `x = 1.999` y `x = 2.001` como aproximaciones máximas.
- Confirmación de que los controles nunca producen `x = 2`.
- Verificación de los casos laterales coincidente y diferente.
- Renderizado y revisión visual de las cinco pantallas a 1,100 × 720 puntos.

## Estado

El módulo 4 está implementado en español. El módulo 5 permanece como pantalla provisional.
