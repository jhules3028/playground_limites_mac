# Planeación de contenidos: límites

## Propósito del Playground

Crear un objeto de aprendizaje interactivo para estudiantes de Cálculo I que permita comprender el concepto de límite mediante explicaciones, tablas, gráficas, procedimientos algebraicos y ejercicios con retroalimentación.

El producto final es un Swift | Playground para macOS. Funcionará localmente y podrá abrirse y ejecutarse en Xcode sin servicios ni librerías externas.

Durante el desarrollo, el contenido se revisará primero en español. Cuando la estructura, las matemáticas y las actividades estén aprobadas, los textos visibles de la interfaz se traducirán al inglés.

## Objetivo general

Que el estudiante comprenda qué representa un límite y pueda analizarlo mediante:

- Una aproximación intuitiva.
- Una tabla de valores.
- Una representación gráfica.
- Límites laterales.
- Procedimientos algebraicos.
- Continuidad y discontinuidades.

## Módulos

### 1. Idea intuitiva del límite

**Aprendizaje esperado:** comprender que un límite describe el valor al que se aproxima una función, aunque la función no necesariamente llegue a tomar ese valor.

Conceptos:

- Variable independiente `x`.
- Punto objetivo `a`.
- Aproximación.
- Notación `lim x→a f(x) = L`.

Interacción propuesta:

- Deslizador que acerque `x` hacia un punto determinado.
- Visualización simultánea de `x` y `f(x)`.
- Mensaje que explique cómo cambia la distancia respecto al valor objetivo.

### 2. Representación numérica mediante tablas

**Aprendizaje esperado:** observar cómo los valores de una función se aproximan a un resultado desde ambos lados.

Ejemplo principal:

`lim x→2 (x² - 4)/(x - 2) = 4`

Valores sugeridos:

| Desde la izquierda | Resultado | Desde la derecha | Resultado |
| ---: | ---: | ---: | ---: |
| 1.9 | 3.9 | 2.1 | 4.1 |
| 1.99 | 3.99 | 2.01 | 4.01 |
| 1.999 | 3.999 | 2.001 | 4.001 |

Interacción propuesta:

- Selector de precisión de una, dos o tres cifras decimales.
- Resaltado de las filas conforme los valores se acercan a `2`.
- Conclusión guiada: aunque `x` no sea exactamente `2`, los resultados se aproximan a `4`.

### 3. Interpretación gráfica

**Aprendizaje esperado:** distinguir entre el límite de una función y el valor de la función en un punto.

Elementos visuales:

- Ejes `x` y `y`.
- Curva de la función.
- Punto móvil sobre la curva.
- Hueco en el punto donde la expresión original no está definida.
- Valor de `x` y `f(x)` en tiempo real.
- Marcadores separados para el límite y para `f(a)`.

Idea fundamental:

- `lim x→a f(x)` y `f(a)` no significan lo mismo.
- El límite puede existir aunque `f(a)` no exista.
- El límite puede existir aunque `f(a)` sea diferente del límite.

### 4. Límites laterales

**Aprendizaje esperado:** comprender la aproximación por la izquierda y por la derecha, y reconocer cuándo existe un límite bilateral.

Conceptos:

- Límite por la izquierda: `lim x→a⁻ f(x)`.
- Límite por la derecha: `lim x→a⁺ f(x)`.
- El límite bilateral existe solamente cuando ambos límites laterales coinciden.

Interacción propuesta:

- Botón “Acercarse desde la izquierda”.
- Botón “Acercarse desde la derecha”.
- Animación de puntos con colores distintos para cada lado.
- Comparación final de los dos resultados.

### 5. Cálculo algebraico

**Aprendizaje esperado:** aplicar procedimientos básicos para calcular límites.

Contenidos:

1. Sustitución directa.
2. Reconocimiento de la indeterminación `0/0`.
3. Factorización y simplificación.
4. Racionalización como sección secundaria.

Ejemplos principales:

- Sustitución directa: `lim x→2 (3x + 1) = 7`.
- Factorización: `lim x→2 (x² - 4)/(x - 2) = 4`.

Interacción propuesta:

- Elegir el siguiente paso correcto.
- Mostrar el procedimiento una etapa a la vez.
- Explicar que `0/0` no es una respuesta, sino una señal para transformar la expresión.

### 6. Continuidad y discontinuidades

**Aprendizaje esperado:** relacionar la existencia de un límite con la continuidad de una función.

Una función es continua en `x = a` cuando:

1. `f(a)` existe.
2. `lim x→a f(x)` existe.
3. `lim x→a f(x) = f(a)`.

Casos visuales:

- Función continua.
- Discontinuidad removible o hueco.
- Discontinuidad de salto.

Interacción propuesta:

- Seleccionar el tipo de comportamiento mostrado en una gráfica.
- Revisar las tres condiciones de continuidad.
- Recibir retroalimentación inmediata.

### 7. Evaluación final

**Aprendizaje esperado:** comprobar la comprensión de los conceptos y procedimientos estudiados.

La evaluación tendrá entre 8 y 10 preguntas:

- Dos preguntas conceptuales.
- Dos interpretaciones de tablas.
- Dos interpretaciones de gráficas.
- Dos límites algebraicos.
- Una pregunta sobre límites laterales.
- Una pregunta sobre continuidad.

Al finalizar se mostrará:

- Calificación.
- Número de respuestas correctas.
- Explicación de las respuestas incorrectas.
- Botón para repetir la evaluación.
- Enlace para volver al módulo correspondiente.

## Alcance de la primera versión

La primera versión incluirá los siete apartados anteriores. Quedan fuera inicialmente:

- Límites infinitos.
- Límites cuando `x→∞`.
- Asíntotas horizontales y verticales.
- Teorema del sándwich.
- Definición formal épsilon-delta.
- Relación entre límite y derivada.

## Criterios pedagógicos

- Introducir primero la intuición y después el procedimiento algebraico.
- Relacionar cada explicación con una interacción visible.
- Diferenciar claramente límite, valor de la función y punto no definido.
- Evitar que una animación sustituya la explicación matemática.
- Proporcionar retroalimentación específica, no solamente “correcto” o “incorrecto”.
- Permitir que el estudiante vuelva a cualquier módulo sin perder su orientación.
