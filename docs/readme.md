# Mapa general del Playground de límites

## 1. ¿Qué es este proyecto?

Este proyecto es un objeto de aprendizaje interactivo sobre límites de Cálculo I.

Está construido como un Swift Playground para macOS. El estudiante puede recorrer explicaciones, gráficas, tablas, ejercicios y una evaluación final sin necesitar internet ni servicios externos.

Todo el contenido forma parte de una sola experiencia. La portada, los seis módulos y la evaluación no son Playgrounds independientes: se conectan mediante una navegación común.

## 2. Ubicación principal

El Playground que debe abrirse en Xcode es:

```text
MyPlayground.playground/
```

En su interior se encuentran tres partes principales:

```text
MyPlayground.playground/
├── Contents.swift
├── Sources/
└── Resources/
```

- `Contents.swift` inicia la experiencia.
- `Sources` contiene el código de la portada, los módulos y la evaluación.
- `Resources` contiene imágenes utilizadas por el Playground.

## 3. ¿Cómo comienza el programa?

El recorrido de inicio es el siguiente:

```text
Contents.swift
      ↓
StartPlayground.swift
      ↓
PlaygroundFactory.swift
      ↓
MainView.swift
      ↓
Portada
```

### `Contents.swift`

Es el punto de entrada. Su única responsabilidad es solicitar que comience el Playground.

Debe permanecer pequeño porque el contenido real se encuentra dentro de `Sources`.

### `StartPlayground.swift`

Activa la ejecución continua y coloca la interfaz dentro del área de resultados de Xcode.

### `PlaygroundFactory.swift`

Crea la ventana visual del Playground, prepara el estado de la sesión y establece el tamaño inicial de la experiencia.

### `MainView.swift`

Funciona como distribuidor de pantallas. Revisa cuál sección está seleccionada y muestra la portada, alguno de los módulos o la evaluación.

No contiene el contenido educativo completo; solamente conecta las secciones.

## 4. Archivos generales compartidos

Estos archivos están directamente dentro de `MyPlayground.playground/Sources/` porque son utilizados por varias secciones.

### `AppSection.swift`

Contiene la lista de secciones disponibles:

- Portada.
- Módulo 1.
- Módulo 2.
- Módulo 3.
- Módulo 4.
- Módulo 5.
- Módulo 6.
- Evaluación final.

También relaciona cada sección con su nombre y número.

### `AppState.swift`

Recuerda en qué sección se encuentra el estudiante y permite avanzar, retroceder o volver a la portada.

También registra los módulos terminados durante la ejecución actual.

### `AppTheme.swift`

Define la apariencia general del proyecto:

- Colores azules.
- Acentos dorados.
- Colores de éxito y error.
- Fondos y degradados.
- Apariencia de las tarjetas.

Cambiar un color en este archivo puede afectar varias pantallas.

### `LessonComponents.swift`

Contiene elementos visuales sencillos que se reutilizan, como las tarjetas transparentes y los pequeños encabezados dorados.

## 5. Portada

La portada se encuentra principalmente en:

```text
Sources/CoverView.swift
```

Este archivo contiene:

- Encabezado institucional.
- Logotipo de la FES Acatlán.
- Nombre de la universidad.
- Título del objeto de aprendizaje.
- Descripción del recorrido.
- Etiquetas `Observa`, `Comprende` y `Practica`.
- Botón `Comenzar`.
- Nombre del autor.
- Tarjeta matemática y gráfica decorativa.

El botón `Comenzar` se comunica con `AppState.swift` para abrir el módulo 1.

## 6. Organización de los módulos

Cada módulo tiene su propia carpeta dentro de `Sources`:

```text
Sources/
├── module_1/
├── module_2/
├── module_3/
├── module_4/
├── module_5/
└── module_6/
```

Aunque la cantidad de archivos cambia ligeramente, todos siguen una organización parecida:

- `Module...View.swift`: coordina las páginas del módulo.
- Archivos con nombres de las actividades: contienen cada pantalla educativa.
- `Module...Components.swift`: contiene encabezados, botones y elementos reutilizados dentro del módulo.
- `Module...Example.swift`: guarda las funciones, valores y resultados matemáticos del ejemplo.
- `Module...Graph.swift`: dibuja la gráfica cuando el módulo la necesita.

Esta separación permite modificar una actividad sin convertir todo el módulo en un solo archivo enorme.

## 7. Módulo 1: idea intuitiva del límite

Ubicación:

```text
Sources/module_1/
```

Su archivo coordinador es `ModuleOneView.swift`.

Las pantallas se distribuyen así:

- `ModuleOneConceptView.swift`: explica qué es un límite y presenta la notación.
- `ModuleOneExploreView.swift`: contiene el deslizador para aproximar `x` al punto objetivo.
- `ModuleOneSummaryView.swift`: resume la idea clave y comprueba la comprensión.
- `ModuleOneExample.swift`: contiene la función y los valores utilizados.
- `ModuleOneComponents.swift`: contiene la navegación y los componentes propios del módulo.

## 8. Módulo 2: representación numérica

Ubicación:

```text
Sources/module_2/
```

Su archivo coordinador es `ModuleTwoView.swift`.

- `ModuleTwoTableView.swift`: presenta la función y la tabla de aproximaciones.
- `ModuleTwoPrecisionView.swift`: permite observar qué sucede al utilizar más cifras decimales.
- `ModuleTwoSummaryView.swift`: explica cómo interpretar la tendencia numérica.
- `ModuleTwoExample.swift`: genera y formatea los valores de la tabla.
- `ModuleTwoComponents.swift`: contiene la tabla visual, navegación y elementos compartidos del módulo.

## 9. Módulo 3: interpretación gráfica

Ubicación:

```text
Sources/module_3/
```

Su archivo coordinador es `ModuleThreeView.swift`.

- `ModuleThreeReadingView.swift`: enseña a leer ejes, curva, punto objetivo y hueco.
- `ModuleThreeExploreView.swift`: permite comparar diferentes valores de la función en el punto objetivo.
- `ModuleThreeSummaryView.swift`: diferencia el límite de `f(a)` e incluye una comprobación rápida.
- `ModuleThreeGraph.swift`: dibuja la gráfica interactiva.
- `ModuleThreeExample.swift`: define la función y sus diferentes casos.
- `ModuleThreeComponents.swift`: contiene navegación, leyendas y controles reutilizados.

## 10. Módulo 4: límites laterales

Ubicación:

```text
Sources/module_4/
```

Su archivo coordinador es `ModuleFourView.swift`.

- `ModuleFourIntroductionView.swift`: presenta el límite izquierdo y el límite derecho.
- `ModuleFourSidePlayground.swift`: permite aproximarse por cada lado mediante controles interactivos.
- `ModuleFourExistenceView.swift`: explica cuándo existe el límite bilateral.
- `ModuleFourPracticeView.swift`: contiene preguntas para comprobar el aprendizaje.
- `ModuleFourGraph.swift`: dibuja los ejemplos laterales.
- `ModuleFourExample.swift`: guarda las funciones y valores matemáticos.
- `ModuleFourComponents.swift`: contiene la navegación y elementos visuales propios del módulo.

## 11. Módulo 5: cálculo algebraico

Ubicación:

```text
Sources/module_5/
```

Su archivo coordinador es `ModuleFiveView.swift`.

- `ModuleFiveDirectView.swift`: explica la sustitución directa.
- `ModuleFiveIndeterminateView.swift`: explica por qué `0/0` es una indeterminación y no una respuesta.
- `ModuleFiveFactoringView.swift`: desarrolla la factorización y simplificación.
- `ModuleFiveRationalizationView.swift`: presenta un ejemplo con raíces.
- `ModuleFiveAssessmentView.swift`: contiene dos ejercicios de comprobación.
- `ModuleFiveExample.swift`: guarda los ejemplos y procedimientos algebraicos.
- `ModuleFiveComponents.swift`: contiene navegación, tarjetas y controles del módulo.

## 12. Módulo 6: continuidad

Ubicación:

```text
Sources/module_6/
```

Su archivo coordinador es `ModuleSixView.swift`.

- `ModuleSixIntroductionView.swift`: presenta las tres condiciones de continuidad.
- `ModuleSixCaseStudyView.swift`: muestra los casos continuo, removible y de salto.
- `ModuleSixAssessmentView.swift`: contiene ejercicios para identificar discontinuidades.
- `ModuleSixGraph.swift`: dibuja las gráficas de los tres casos.
- `ModuleSixExample.swift`: determina valores, límites y cumplimiento de las condiciones.
- `ModuleSixComponents.swift`: contiene navegación, indicadores y tarjetas numéricas.

## 13. Evaluación final

La evaluación está separada de los módulos en:

```text
Sources/evaluation/
```

Sus archivos son:

- `EvaluationView.swift`: coordina el intento, las respuestas y la entrega.
- `EvaluationQuestionView.swift`: muestra una pregunta y sus opciones.
- `EvaluationResultsView.swift`: presenta calificación y retroalimentación.
- `EvaluationQuestionBank.swift`: contiene el banco completo de 18 preguntas.
- `EvaluationModels.swift`: define la información que necesita cada pregunta.
- `EvaluationComponents.swift`: contiene botones, indicadores y recursos visuales de la evaluación.

Cada intento selecciona diez preguntas sin repetir. Los seis módulos aparecen al menos una vez y las opciones se mezclan.

Las respuestas no se califican mientras el estudiante contesta. Después de entregar se muestran:

- Aciertos sobre diez.
- Porcentaje.
- Respuesta seleccionada.
- Respuesta correcta.
- Explicación del error.
- Módulo que conviene repasar.

## 14. Recursos

Las imágenes locales están en:

```text
MyPlayground.playground/Resources/
```

Actualmente contiene:

```text
fes-acatlan-logo.png
```

El archivo `CoverView.swift` busca ese nombre para mostrar el logotipo en la portada.

Las gráficas matemáticas no son imágenes. Se dibujan mediante código SwiftUI dentro de los archivos `Graph.swift`.

## 15. Documentación

La carpeta general de documentación es:

```text
docs/
```

Contiene:

- `planeacion-contenidos.md`: planeación pedagógica de los módulos.
- `planeacion-evaluacion.md`: banco y comportamiento esperado de la evaluación.
- `palenacion-code.md`: arquitectura y ruta técnica del proyecto.
- `readme.md`: este mapa general.
- `changes/`: explicación más detallada de cada módulo implementado.

## 16. Recorrido del estudiante

El flujo normal es:

```text
Portada
   ↓
Módulo 1: idea intuitiva
   ↓
Módulo 2: tablas
   ↓
Módulo 3: gráficas
   ↓
Módulo 4: límites laterales
   ↓
Módulo 5: cálculo algebraico
   ↓
Módulo 6: continuidad
   ↓
Evaluación final
```

Cada archivo coordinador controla las páginas internas de su módulo. Cuando se termina un módulo, `AppState.swift` registra el avance y `MainView.swift` muestra la siguiente sección.

## 17. ¿Dónde debe hacerse cada cambio?

Como guía rápida:

| Cambio deseado | Ubicación principal |
| --- | --- |
| Textos y elementos de la portada | `Sources/CoverView.swift` |
| Colores generales | `Sources/AppTheme.swift` |
| Orden y conexión de las secciones | `Sources/MainView.swift` y `Sources/AppState.swift` |
| Contenido de una pantalla | Archivo de esa pantalla dentro de `module_n/` |
| Botones y encabezado de un módulo | `Module...Components.swift` |
| Funciones y valores matemáticos | `Module...Example.swift` |
| Aspecto de una gráfica | `Module...Graph.swift` |
| Preguntas de la evaluación | `evaluation/EvaluationQuestionBank.swift` |
| Presentación de resultados | `evaluation/EvaluationResultsView.swift` |
| Logotipo institucional | `Resources/fes-acatlan-logo.png` |

## 18. Ejecución en Xcode

Para utilizar el proyecto:

1. Abrir `MyPlayground.playground` en Xcode.
2. Confirmar que `Contents.swift` contiene la llamada `launchPlayground()`.
3. Ejecutar el Playground con el botón triangular.
4. Esperar a que la interfaz aparezca en el área de resultados.

El Playground funciona localmente y no requiere instalar librerías externas.

## 19. Resumen

La estructura separa el proyecto en cuatro grupos fáciles de reconocer:

1. Archivos generales que arrancan y conectan la experiencia.
2. `CoverView.swift`, que construye la portada.
3. Carpetas `module_1` a `module_6`, que contienen las lecciones.
4. La carpeta `evaluation`, que contiene el examen final.

Gracias a esta organización es posible localizar una pantalla, cambiar sus textos o ajustar un ejemplo sin recorrer todo el proyecto.
