# Módulo 1: idea intuitiva del límite

## Objetivo

El estudiante comprenderá que un límite describe el valor al que se aproxima una función cuando `x` se acerca a un valor objetivo `a`, aunque la función no necesariamente tome ese valor en el punto.

## Organización

El código específico está agrupado en:

```text
MyPlayground.playground/Sources/module_1/
├── ModuleOneView.swift
├── ModuleOneConceptView.swift
├── ModuleOneExploreView.swift
├── ModuleOneSummaryView.swift
├── ModuleOneComponents.swift
└── ModuleOneExample.swift
```

Los archivos compartidos por todo el Playground permanecen directamente dentro de `Sources`.

## Pantallas

### Pantalla 1: concepto

Archivo principal: `ModuleOneConceptView.swift`.

Incluye:

- Definición intuitiva de límite.
- Notación `limₓ→ₐ f(x) = L`.
- Variable independiente `x`.
- Valor objetivo `a`.
- Aproximación.
- Valor límite `L`.
- Analogía de una persona que reduce progresivamente su distancia respecto a una puerta.
- Idea de observar el comportamiento alrededor del punto.

### Pantalla 2: exploración

Archivo principal: `ModuleOneExploreView.swift`.

Utiliza el ejemplo:

```text
f(x) = x + 2, excepto en x = 2
a = 2
L = 4
```

Incluye:

- Gráfica interactiva con un hueco en `(2, 4)`.
- Deslizador para mover `x` entre `0.2` y `3.8`.
- Lectura de `x` y `f(x)`.
- Distancia entre `x` y el objetivo `a`.
- Mensajes que cambian conforme el estudiante se aproxima.
- Botones para observar posiciones lejanas, cercanas y muy cercanas.
- Explicación especial cuando `x = 2` y la función no está definida.

### Pantalla 3: conclusión

Archivo principal: `ModuleOneSummaryView.swift`.

Incluye:

- Resumen de la relación `x → a` y `f(x) → L`.
- Tres ideas esenciales del módulo.
- Pregunta de comprobación inmediata.
- Retroalimentación específica para ambas respuestas.
- Idea clave final del módulo.

## Responsabilidad de los demás archivos

### `ModuleOneView.swift`

- Contiene las tres pantallas.
- Administra la pantalla interna seleccionada.
- Conecta los controles “Anterior” y “Siguiente”.
- Permite regresar a la portada.
- Al terminar, marca el módulo como completado y continúa hacia el módulo 2.

### `ModuleOneComponents.swift`

Contiene elementos reutilizados dentro del módulo:

- Encabezado y progreso de tres pantallas.
- Navegación inferior.
- Tarjetas de conceptos.
- Representación visual de la analogía.

Las tarjetas generales y las etiquetas de sección se encuentran ahora en `Sources/LessonComponents.swift` para poder compartirlas con otros módulos.

### `ModuleOneExample.swift`

Contiene la lógica pura del ejemplo:

- Valores `a = 2` y `L = 4`.
- Dominio utilizado por el deslizador.
- Evaluación de `f(x)`.
- Representación del punto no definido.
- Cálculo de distancias.
- Formato de valores decimales.

## Integración con archivos compartidos

- `MainView.swift` muestra `ModuleOneView` cuando la sección actual es `.intuitiveLimit`.
- `AppState.swift` abre el módulo desde la portada y registra su finalización.
- `AppTheme.swift` proporciona colores institucionales y colores de retroalimentación.
- `AppSection.swift` identifica esta lección como el módulo 1.

## Flujo

```text
Portada
   ↓ Comenzar
Pantalla 1: concepto y analogía
   ↓ Siguiente
Pantalla 2: deslizador y gráfica
   ↓ Siguiente
Pantalla 3: resumen y comprobación
   ↓ Terminar módulo
Módulo 2: límites mediante tablas
```

## Estado

Las tres pantallas del módulo 1 están implementadas en español. La traducción al inglés queda pendiente hasta que el contenido, las instrucciones y la retroalimentación sean aprobados.
