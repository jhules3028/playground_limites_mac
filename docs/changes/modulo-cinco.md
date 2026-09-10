# Módulo 5: cálculo algebraico

## Objetivo

El estudiante pasará de la interpretación visual y numérica de los límites a un procedimiento algebraico organizado.

La ruta de trabajo presentada es:

1. Sustituir directamente el punto objetivo.
2. Terminar si se obtiene un número real y la expresión está definida.
3. Interpretar `0/0` como una señal de transformación, no como una respuesta.
4. Factorizar cuando hay estructuras polinomiales adecuadas.
5. Racionalizar cuando una raíz produce la forma `0/0`.
6. Simplificar y volver a sustituir.

## Organización

```text
MyPlayground.playground/Sources/module_5/
├── ModuleFiveView.swift
├── ModuleFiveDirectView.swift
├── ModuleFiveIndeterminateView.swift
├── ModuleFiveFactoringView.swift
├── ModuleFiveRationalizationView.swift
├── ModuleFiveAssessmentView.swift
├── ModuleFiveComponents.swift
└── ModuleFiveExample.swift
```

## Pantallas

### Pantalla 1: sustitución directa

Archivo: `ModuleFiveDirectView.swift`.

Utiliza el ejemplo:

```text
lim x→2 (3x + 1) = 7
```

Incluye:

- Explicación de cuándo se puede sustituir directamente.
- Diferencia entre obtener un número real y obtener una forma problemática.
- Procedimiento de tres pasos que el estudiante revela progresivamente.
- Explicación de que una función lineal es continua en el punto estudiado.

### Pantalla 2: forma indeterminada 0/0

Archivo: `ModuleFiveIndeterminateView.swift`.

Incluye:

- Sustitución inicial en `(x² − 4)/(x − 2)`.
- Explicación de por qué aparece `0/0`.
- Aclaración de que `0/0` no es cero, infinito ni inexistencia automática.
- Pregunta conceptual con retroalimentación.
- Orientación para elegir entre factorización y racionalización.

### Pantalla 3: factorización

Archivo: `ModuleFiveFactoringView.swift`.

Desarrolla:

```text
x² − 4 = (x − 2)(x + 2)
[(x − 2)(x + 2)]/(x − 2) = x + 2, para x ≠ 2
lim x→2 (x + 2) = 4
```

Incluye una interacción para seleccionar el siguiente paso correcto y una explicación de que simplificar produce una expresión equivalente cerca del punto, pero no redefine la función original en el hueco.

### Pantalla 4: racionalización

Archivo: `ModuleFiveRationalizationView.swift`.

Utiliza el ejemplo secundario:

```text
lim x→4 (√x − 2)/(x − 4) = 1/4
```

Incluye:

- Definición del conjugado.
- Pregunta para seleccionar la fracción correcta.
- Multiplicación por `(√x + 2)/(√x + 2)`.
- Uso de la diferencia de cuadrados.
- Simplificación y sustitución final.

### Pantalla 5: evaluación

Archivo: `ModuleFiveAssessmentView.swift`.

Contiene dos ejercicios:

1. Sustitución directa en `lim x→3 (2x² − x + 1)`, cuyo resultado es `16`.
2. Factorización en `lim x→3 (x² − 9)/(x − 3)`, cuyo resultado es `6`.

Cada ejercicio incluye opciones de respuesta, retroalimentación inmediata y un contador de aciertos.

## Responsabilidad de los demás archivos

### `ModuleFiveView.swift`

- Administra las cinco pantallas.
- Permite regresar al módulo 4.
- Permite volver a la portada.
- Registra el módulo 5 como completado y continúa hacia el módulo 6.

### `ModuleFiveComponents.swift`

Contiene:

- Encabezado y progreso del módulo.
- Navegación inferior.
- Tarjetas de fórmulas.
- Filas de procedimientos numerados.
- Opciones de respuesta.
- Paneles de retroalimentación.

### `ModuleFiveExample.swift`

Separa de la interfaz los cálculos de:

- Sustitución directa.
- Expresión original y simplificada por factorización.
- Expresión original y simplificada por racionalización.
- Resultados de los dos ejercicios finales.
- Formato numérico.

## Integración

Se agregó `completeModuleFive()` en `AppState.swift` y el caso `.algebraicLimit` en `MainView.swift`.

El flujo queda así:

```text
Módulo 4
   ↓
Sustitución directa
   ↓
Significado de 0/0
   ↓
Factorización
   ↓
Racionalización
   ↓
Evaluación de dos ejercicios
   ↓
Módulo 6 provisional
```

## Validaciones realizadas

- Compilación recursiva de todos los archivos Swift.
- Compilación del módulo auxiliar y de `Contents.swift`.
- Verificación matemática de todos los ejemplos y ejercicios.
- Renderizado de las cinco pantallas a 1,100 × 720 puntos.
- Revisión visual de textos, fórmulas, tarjetas y navegación.
- Confirmación de la conexión entre los módulos 4, 5 y 6.

## Estado

El módulo 5 está implementado en español. El módulo 6 permanece como pantalla provisional.
