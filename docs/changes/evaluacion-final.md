# Evaluación final

## Objetivo

Comprobar los aprendizajes de los seis módulos mediante un intento de diez preguntas aleatorias, sin mostrar aciertos ni errores hasta que el estudiante entregue todas sus respuestas.

## Organización

```text
MyPlayground.playground/Sources/evaluation/
├── EvaluationView.swift
├── EvaluationQuestionView.swift
├── EvaluationResultsView.swift
├── EvaluationComponents.swift
├── EvaluationModels.swift
└── EvaluationQuestionBank.swift
```

## Responsabilidad de los archivos

### `EvaluationView.swift`

- Coordina el intento actual.
- Conserva las respuestas mientras el estudiante navega.
- Permite regresar a preguntas anteriores y cambiar respuestas.
- Exige responder las diez preguntas antes de entregar.
- Cambia de la vista de examen a la vista de resultados.
- Genera un intento nuevo al repetir la evaluación.

### `EvaluationQuestionView.swift`

- Presenta el enunciado y las tres opciones de la pregunta actual.
- Integra una tabla o gráfica cuando la pregunta requiere interpretación visual.
- Marca únicamente cuál opción eligió el estudiante.
- No muestra la respuesta correcta ni retroalimentación anticipada.

### `EvaluationResultsView.swift`

- Calcula y muestra aciertos sobre diez y porcentaje.
- Presenta un mensaje general según la calificación.
- Revisa las diez preguntas del intento.
- Muestra la respuesta elegida y la correcta.
- Explica el concepto matemático de cada pregunta.
- En respuestas incorrectas, utiliza retroalimentación específica para el distractor seleccionado.
- Permite volver directamente al módulo relacionado o comenzar otro intento.

### `EvaluationComponents.swift`

Contiene componentes reutilizables de la evaluación:

- Encabezado y selector de preguntas.
- Botones de respuesta con estado neutral.
- Tabla numérica del módulo 2.
- Contenedor para los recursos gráficos del módulo 3.

Las gráficas reutilizan `ModuleThreeGraph` para conservar la misma representación visual y matemática que el estudiante estudió.

### `EvaluationModels.swift`

Define:

- Preguntas y opciones con identificadores estables.
- Respuesta correcta.
- Explicación general.
- Retroalimentación para cada distractor.
- Ruta y módulo de estudio.
- Tipo de recurso visual opcional.
- Generación equilibrada de intentos.

Cada intento toma una pregunta al azar de cada módulo, agrega cuatro preguntas aleatorias del resto del banco, mezcla las diez preguntas y también mezcla sus opciones.

### `EvaluationQuestionBank.swift`

Contiene las 18 preguntas aprobadas en `docs/planeacion-evaluacion.md`: tres de cada módulo. Ninguna respuesta correcta se deduce por su posición porque las opciones se presentan en un orden nuevo.

## Integración

Se actualizaron:

- `AppState.swift`, para registrar la evaluación completada y navegar al módulo recomendado.
- `MainView.swift`, para sustituir la pantalla provisional por `EvaluationView`.

El flujo final queda así:

```text
Módulo 6
   ↓
Evaluación de 10 preguntas
   ↓
Entrega
   ↓
Calificación y revisión
   ├── Intentar otra evaluación
   ├── Volver al módulo recomendado
   └── Volver a la portada
```

## Validaciones realizadas

- Compilación recursiva de todos los archivos Swift.
- Compilación del módulo auxiliar y de `Contents.swift` como Playground.
- Verificación de las 18 preguntas y sus tres opciones.
- Generación automática de 500 intentos de prueba.
- Confirmación de diez preguntas únicas y presencia de los seis módulos en cada intento.
- Confirmación de que cada respuesta correcta permanece identificable después de mezclar las opciones.
- Confirmación de que cada distractor conserva su retroalimentación específica.
- Renderizado y revisión visual de la pantalla de preguntas y la pantalla de resultados a 1,100 × 720 puntos.

## Estado

La evaluación final está implementada en español y funciona localmente sin dependencias externas.
