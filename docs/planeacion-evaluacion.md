# Planeación de la evaluación final

## 1. Propósito

La evaluación final comprobará que el estudiante pueda interpretar y calcular límites utilizando los recursos estudiados en los seis módulos.

La evaluación no debe limitarse a indicar si una respuesta es correcta o incorrecta. Al finalizar, debe explicar el error, recuperar la idea matemática necesaria y señalar el módulo que conviene volver a estudiar.

## 2. Estructura general

- El banco contiene `18` preguntas.
- Cada uno de los seis módulos aporta `3` preguntas.
- Cada intento presenta exactamente `10` preguntas.
- Una pregunta no puede repetirse dentro del mismo intento.
- Las respuestas no se califican visualmente mientras el estudiante contesta.
- El estudiante puede cambiar cualquier respuesta antes de entregar.
- La calificación, las respuestas correctas y la retroalimentación aparecen solamente al presionar `Entregar evaluación`.
- La interfaz final mostrará el resultado como aciertos sobre diez y como porcentaje, por ejemplo: `8/10 — 80 %`.

### Selección aleatoria recomendada

Para evitar que un intento omita por completo algún tema, la selección será aleatoria pero equilibrada:

1. Elegir al azar una pregunta de cada módulo. Esto genera seis preguntas.
2. Mezclar las doce preguntas restantes.
3. Tomar las primeras cuatro para completar las diez preguntas.
4. Mezclar el orden final de las diez preguntas.
5. Mezclar también las opciones de cada pregunta, conservando identificadores internos estables para reconocer la respuesta correcta.

Este procedimiento garantiza representación de los seis módulos y mantiene la variación entre intentos.

## 3. Comportamiento durante el examen

Mientras el estudiante responde:

- Una opción seleccionada sólo cambia su apariencia para indicar selección.
- No se utilizarán colores verde o rojo para calificar.
- No aparecerán mensajes como `Correcto`, `Incorrecto` o explicaciones anticipadas.
- No se mostrará la respuesta correcta.
- Se mostrará el progreso, por ejemplo `Pregunta 4 de 10` y `7 respondidas`.
- El botón de entrega se activará cuando las diez preguntas tengan respuesta.
- Si se permite entregar con preguntas vacías, el programa deberá pedir confirmación y contarlas como incorrectas. Para la primera versión se recomienda exigir las diez respuestas.

## 4. Pantalla de resultados

Después de entregar se mostrará:

- Calificación sobre diez.
- Porcentaje.
- Cantidad de respuestas correctas e incorrectas.
- Mensaje general según el resultado.
- Revisión de cada pregunta.
- Respuesta elegida por el estudiante.
- Respuesta correcta.
- Explicación matemática.
- Retroalimentación específica cuando se eligió un distractor.
- Nombre y número del módulo relacionado.
- Botón `Volver a estudiar este módulo`.
- Botón `Intentar otra evaluación`, que generará una nueva selección aleatoria.

### Mensajes generales sugeridos

| Resultado | Mensaje |
| --- | --- |
| 9–10 aciertos | Excelente dominio. Puedes justificar límites desde varias representaciones. |
| 7–8 aciertos | Buen trabajo. Revisa los errores señalados para consolidar los detalles. |
| 5–6 aciertos | Tienes una base funcional, pero conviene repasar los módulos recomendados. |
| 0–4 aciertos | Repasa los conceptos fundamentales y vuelve a intentarlo. Cada error incluye una ruta de estudio. |

## 5. Banco de preguntas

Las letras identifican las opciones únicamente dentro de este documento. En el programa las opciones podrán mostrarse en otro orden.

---

## Módulo 1: idea intuitiva del límite

### M1-P1 — Significado de un límite

**Tipo:** conceptual.

**Enunciado:** ¿Qué describe principalmente la expresión `lim x→a f(x) = L`?

**Opciones:**

- A. El valor que obligatoriamente toma la función exactamente en `x = a`.
- B. El valor al que se aproxima `f(x)` cuando `x` se acerca a `a`.
- C. El valor más grande que puede alcanzar la función.

**Respuesta correcta:** B.

**Explicación del resultado:** Un límite estudia la tendencia de los valores de la función alrededor de `a`. No exige que `x` sea igual a `a` ni que `f(a)` exista.

**Retroalimentación si responde mal:**

- Si elige A: confundió el límite con `f(a)`. El límite observa puntos cercanos; el valor exacto de la función es una pregunta diferente.
- Si elige C: un límite no representa un máximo. La función puede aproximarse a `L` aunque existan valores mayores o menores en otras regiones.

**Ruta de estudio:** Módulo 1, pantallas de introducción y aproximación.

### M1-P2 — Acercarse no es llegar

**Tipo:** conceptual.

**Enunciado:** Cuando escribimos `x → 2`, ¿qué debe entenderse?

**Opciones:**

- A. Que solamente podemos utilizar `x = 2`.
- B. Que `x` debe permanecer lejos de `2`.
- C. Que usamos valores cada vez más cercanos a `2`, sin necesitar que sean exactamente `2`.

**Respuesta correcta:** C.

**Explicación del resultado:** La flecha representa un proceso de aproximación. Valores como `1.9`, `1.99`, `2.01` o `2.001` permiten estudiar qué sucede alrededor del punto objetivo.

**Retroalimentación si responde mal:**

- Si elige A: sustituir exactamente `x = 2` estudia `f(2)`, no necesariamente el límite. La aproximación utiliza valores vecinos.
- Si elige B: la idea es reducir la distancia respecto a `2`, no conservarla grande.

**Ruta de estudio:** Módulo 1, playground del deslizador.

### M1-P3 — Límite con punto no definido

**Tipo:** aplicación conceptual.

**Enunciado:** Al acercarse `x` a `5`, los valores de `f(x)` se aproximan a `−2`, pero `f(5)` no está definida. ¿Cuál es la conclusión correcta?

**Opciones:**

- A. El límite puede ser `−2` aunque `f(5)` no exista.
- B. El límite no existe porque falta `f(5)`.
- C. Podemos afirmar que `f(5) = −2`.

**Respuesta correcta:** A.

**Explicación del resultado:** La existencia del límite depende del comportamiento cercano. El valor exacto de la función puede estar ausente sin destruir esa tendencia.

**Retroalimentación si responde mal:**

- Si elige B: está imponiendo al límite una condición que no necesita. Un hueco puede coexistir con un límite perfectamente definido.
- Si elige C: la aproximación permite determinar el límite, pero no autoriza inventar un valor para `f(5)`.

**Ruta de estudio:** Módulo 1, resumen sobre aproximarse sin alcanzar.

---

## Módulo 2: representación numérica mediante tablas

### M2-P1 — Interpretar una tabla

**Tipo:** interpretación numérica.

**Enunciado:** Una tabla muestra que, al acercarse `x` a `2`, por la izquierda `f(x)` toma `3.9`, `3.99`, `3.999`, y por la derecha toma `4.1`, `4.01`, `4.001`. ¿A qué valor se aproxima la función?

**Opciones:**

- A. A `2`.
- B. A `4`.
- C. A `0`.

**Respuesta correcta:** B.

**Explicación del resultado:** Los valores de ambos lados se acercan a `4`: desde abajo por la izquierda y desde arriba por la derecha.

**Retroalimentación si responde mal:**

- Si elige A: `2` es el valor al que se acerca `x`, no el valor al que se acerca `f(x)`.
- Si elige C: que la expresión original produzca `0/0` en `x = 2` no significa que los valores de la tabla se aproximen a cero.

**Ruta de estudio:** Módulo 2, pantalla de lectura de la tabla.

### M2-P2 — Aumentar la precisión

**Tipo:** interpretación numérica.

**Enunciado:** Al cambiar de `x = 1.9` a `x = 1.99`, ¿qué ocurre con la distancia hasta `2`?

**Opciones:**

- A. Pasa de `0.1` a `0.01`; estamos diez veces más cerca.
- B. La distancia permanece igual porque ambos números empiezan con `1`.
- C. Cambiamos de aproximación por la izquierda a aproximación por la derecha.

**Respuesta correcta:** A.

**Explicación del resultado:** `2 − 1.9 = 0.1` y `2 − 1.99 = 0.01`. Agregar precisión reduce la distancia por un factor de diez.

**Retroalimentación si responde mal:**

- Si elige B: debe compararse la diferencia respecto a `2`, no solamente los primeros dígitos escritos.
- Si elige C: tanto `1.9` como `1.99` son menores que `2`, así que ambos pertenecen al lado izquierdo.

**Ruta de estudio:** Módulo 2, pantalla para cambiar la precisión.

### M2-P3 — Lo que una tabla no demuestra

**Tipo:** interpretación crítica.

**Enunciado:** Si una tabla de valores cercanos indica que `f(x)` se aproxima a `4` cuando `x → 2`, ¿qué podemos concluir con seguridad a partir de esa tabla?

**Opciones:**

- A. Que el comportamiento cercano sugiere un límite igual a `4`, pero la tabla no determina por sí sola `f(2)`.
- B. Que `f(2)` necesariamente vale `4`.
- C. Que la función no está definida en ningún punto.

**Respuesta correcta:** A.

**Explicación del resultado:** La tabla analiza entradas próximas a `2`. Si no incluye la definición exacta de la función en `2`, no puede asegurar cuánto vale `f(2)`.

**Retroalimentación si responde mal:**

- Si elige B: extrapoló una tendencia cercana al valor exacto sin contar con información suficiente.
- Si elige C: la tabla muestra numerosos puntos donde la función sí tiene valores; no permite afirmar que esté indefinida en todas partes.

**Ruta de estudio:** Módulo 2, pantalla de interpretación y conclusión.

---

## Módulo 3: interpretación gráfica

### M3-P1 — Gráfica con hueco

**Tipo:** interpretación gráfica.

**Recurso visual:** curva `y = x + 2` con un hueco en `(2, 4)` y sin punto lleno en `x = 2`.

**Enunciado:** ¿Qué información representa la gráfica en `x = 2`?

**Opciones:**

- A. `lim x→2 f(x) = 4` y `f(2)` no existe.
- B. El límite no existe porque hay un hueco.
- C. `f(2) = 4`, aunque no exista ningún punto lleno.

**Respuesta correcta:** A.

**Explicación del resultado:** La curva se aproxima a `4` desde ambos lados, por lo que el límite existe. El círculo abierto indica que falta el valor exacto de la función.

**Retroalimentación si responde mal:**

- Si elige B: interpretó el hueco como ausencia de tendencia. El hueco afecta `f(2)`, pero la curva de ambos lados sigue apuntando a `4`.
- Si elige C: un círculo abierto no asigna un valor a la función. Para afirmar `f(2) = 4` se necesitaría un punto lleno.

**Ruta de estudio:** Módulo 3, pantalla para leer la gráfica.

### M3-P2 — Límite y valor diferentes

**Tipo:** interpretación gráfica.

**Recurso visual:** hueco en `(2, 4)` y punto lleno en `(2, 6)`.

**Enunciado:** ¿Cuál es la lectura correcta de la gráfica?

**Opciones:**

- A. El límite y `f(2)` valen `6`.
- B. `lim x→2 f(x) = 4` y `f(2) = 6`.
- C. El límite no existe porque hay dos marcas en `x = 2`.

**Respuesta correcta:** B.

**Explicación del resultado:** La curva cercana conduce al hueco situado en `4`; ése es el límite. El punto lleno situado en `6` define el valor exacto `f(2)`.

**Retroalimentación si responde mal:**

- Si elige A: utilizó el punto lleno para responder dos preguntas distintas. Ese punto determina `f(2)`, pero no cambia la tendencia cercana.
- Si elige C: las dos marcas tienen funciones diferentes: una representa la tendencia y la otra el valor exacto. No generan ambigüedad en el límite.

**Ruta de estudio:** Módulo 3, pantalla para comparar los tres casos de `f(a)`.

### M3-P3 — Cuando límite y función coinciden

**Tipo:** interpretación gráfica.

**Recurso visual:** curva `y = x + 2` que atraviesa un punto lleno en `(2, 4)` sin huecos ni saltos.

**Enunciado:** ¿Qué afirmación describe correctamente la gráfica?

**Opciones:**

- A. `lim x→2 f(x) = 4` y `f(2) = 4`.
- B. El límite vale `2` porque ése es el valor de `x`.
- C. `f(2)` existe, pero el límite no puede conocerse visualmente.

**Respuesta correcta:** A.

**Explicación del resultado:** La curva se aproxima a `4` desde ambos lados y el punto lleno confirma que la función también vale `4` en `x = 2`.

**Retroalimentación si responde mal:**

- Si elige B: confundió la coordenada horizontal con la altura de la función. `x` se aproxima a `2`, mientras `f(x)` se aproxima a `4`.
- Si elige C: la tendencia sí puede leerse en la curva cercana. Ambos lados conducen a la misma altura.

**Ruta de estudio:** Módulo 3, pantalla de diferenciación entre límite y valor exacto.

---

## Módulo 4: límites laterales

### M4-P1 — Significado del signo menos

**Tipo:** conceptual.

**Enunciado:** ¿Qué indica el signo menos en `lim x→a⁻ f(x)`?

**Opciones:**

- A. Que el resultado del límite será negativo.
- B. Que `x` se aproxima utilizando valores menores que `a`.
- C. Que la función siempre está disminuyendo.

**Respuesta correcta:** B.

**Explicación del resultado:** El signo `−` señala el lado de aproximación. No describe el signo del resultado ni el crecimiento de la función.

**Retroalimentación si responde mal:**

- Si elige A: confundió dirección con signo numérico. Un límite izquierdo puede producir un número positivo, negativo o cero.
- Si elige C: acercarse desde la izquierda no obliga a la función a disminuir; la curva podría crecer, disminuir o cambiar de otra manera.

**Ruta de estudio:** Módulo 4, introducción y playground izquierdo.

### M4-P2 — Laterales diferentes

**Tipo:** aplicación.

**Enunciado:** Si `lim x→2⁻ f(x) = 3` y `lim x→2⁺ f(x) = 5`, ¿qué ocurre con `lim x→2 f(x)`?

**Opciones:**

- A. Existe y vale `4`, porque es el promedio.
- B. Existe y vale `5`, porque se toma el lado derecho.
- C. No existe, porque los límites laterales son diferentes.

**Respuesta correcta:** C.

**Explicación del resultado:** Un límite bilateral exige que ambos límites laterales coincidan. No se promedian ni se elige uno de ellos.

**Retroalimentación si responde mal:**

- Si elige A: los límites laterales no se combinan mediante un promedio. La igualdad entre ambos es una condición obligatoria.
- Si elige B: el lado derecho no tiene prioridad sobre el izquierdo. Ambos deben conducir al mismo valor.

**Ruta de estudio:** Módulo 4, pantalla de condición de existencia.

### M4-P3 — Laterales coincidentes

**Tipo:** aplicación.

**Enunciado:** Si `lim x→a⁻ f(x) = −2` y `lim x→a⁺ f(x) = −2`, ¿qué podemos afirmar sobre el límite bilateral?

**Opciones:**

- A. Existe y vale `−2`.
- B. No existe porque el resultado es negativo.
- C. Vale `0` porque los dos lados se cancelan.

**Respuesta correcta:** A.

**Explicación del resultado:** Los límites laterales existen y coinciden en `−2`; por tanto, el límite bilateral existe y tiene ese mismo valor.

**Retroalimentación si responde mal:**

- Si elige B: un límite puede ser negativo sin ningún problema. Lo importante es la coincidencia de ambos lados.
- Si elige C: los laterales no se suman ni se cancelan; se comparan para verificar que sean iguales.

**Ruta de estudio:** Módulo 4, comparación entre laterales coincidentes y diferentes.

---

## Módulo 5: cálculo algebraico

### M5-P1 — Sustitución directa

**Tipo:** cálculo.

**Enunciado:** Calcula `lim x→2 (3x + 1)`.

**Opciones:**

- A. `6`.
- B. `7`.
- C. `8`.

**Respuesta correcta:** B.

**Explicación del resultado:** La función lineal está definida en `x = 2`. Sustituyendo directamente: `3(2) + 1 = 6 + 1 = 7`.

**Retroalimentación si responde mal:**

- Si elige A: calculó `3 × 2`, pero olvidó sumar el término `+1`.
- Si elige C: debe revisar la multiplicación y la suma: `3(2)` es `6`, no `7`; después se suma `1`.

**Ruta de estudio:** Módulo 5, pantalla de sustitución directa.

### M5-P2 — Interpretación de 0/0

**Tipo:** conceptual algebraico.

**Enunciado:** Al sustituir el punto objetivo en un cociente aparece `0/0`. ¿Qué significa?

**Opciones:**

- A. Que el límite siempre vale `0`.
- B. Que el límite automáticamente no existe.
- C. Que la sustitución directa no basta y debemos transformar la expresión.

**Respuesta correcta:** C.

**Explicación del resultado:** `0/0` es una forma indeterminada. Puede esconder límites distintos, por lo que debemos factorizar, racionalizar u obtener otra expresión equivalente.

**Retroalimentación si responde mal:**

- Si elige A: cero dividido entre cero no se evalúa como cero. Diferentes expresiones con forma `0/0` pueden tener límites diferentes.
- Si elige B: la indeterminación no demuestra inexistencia. En muchos ejemplos el límite aparece después de simplificar.

**Ruta de estudio:** Módulo 5, pantalla sobre la forma indeterminada `0/0`.

### M5-P3 — Factorización y simplificación

**Tipo:** cálculo.

**Enunciado:** Calcula `lim x→2 (x² − 4)/(x − 2)`.

**Opciones:**

- A. `0`.
- B. `2`.
- C. `4`.

**Respuesta correcta:** C.

**Explicación del resultado:** `x² − 4 = (x − 2)(x + 2)`. Para `x ≠ 2` se simplifica el factor `x − 2`, queda `x + 2` y al sustituir se obtiene `4`.

**Retroalimentación si responde mal:**

- Si elige A: interpretó `0/0` como cero. Debe factorizar antes de decidir el valor del límite.
- Si elige B: probablemente conservó sólo el punto objetivo. Después de simplificar queda `x + 2`, por lo que debe calcular `2 + 2`.

**Ruta de estudio:** Módulo 5, pantalla de factorización.

---

## Módulo 6: continuidad y discontinuidades

### M6-P1 — Condiciones de continuidad

**Tipo:** conceptual.

**Enunciado:** ¿Qué conjunto de condiciones garantiza que `f` sea continua en `x = a`?

**Opciones:**

- A. Únicamente que `f(a)` exista.
- B. Que `f(a)` exista, que `lim x→a f(x)` exista y que ambos valores sean iguales.
- C. Únicamente que los límites laterales sean números positivos.

**Respuesta correcta:** B.

**Explicación del resultado:** La continuidad requiere simultáneamente valor exacto, límite bilateral y coincidencia entre ellos.

**Retroalimentación si responde mal:**

- Si elige A: un punto lleno puede existir aun cuando la curva tenga un salto y el límite bilateral no exista.
- Si elige C: los límites pueden ser negativos o cero. La condición relevante es que los laterales coincidan y que el resultado sea igual a `f(a)`.

**Ruta de estudio:** Módulo 6, pantalla de las tres condiciones.

### M6-P2 — Discontinuidad removible

**Tipo:** clasificación.

**Enunciado:** En `x = 2`, el límite existe y vale `4`, pero `f(2)` no está definida. ¿Qué tipo de comportamiento aparece?

**Opciones:**

- A. Función continua en `x = 2`.
- B. Discontinuidad removible.
- C. Discontinuidad de salto.

**Respuesta correcta:** B.

**Explicación del resultado:** Hay un hueco que puede repararse definiendo `f(2) = 4`. El límite ya existe; falta hacer coincidir el valor exacto.

**Retroalimentación si responde mal:**

- Si elige A: falla la primera condición porque `f(2)` no existe y también falla la igualdad con el límite.
- Si elige C: en un salto los límites laterales son diferentes. Aquí ambos lados sí se aproximan a `4`.

**Ruta de estudio:** Módulo 6, caso de discontinuidad removible.

### M6-P3 — Valor existente con salto

**Tipo:** clasificación y justificación.

**Enunciado:** Se sabe que `f(2) = 5`, `lim x→2⁻ f(x) = 3` y `lim x→2⁺ f(x) = 5`. ¿Por qué la función no es continua en `x = 2`?

**Opciones:**

- A. Porque `f(2)` no existe.
- B. Porque el límite bilateral no existe: los límites laterales son diferentes.
- C. Porque una función continua debe tener valor cero en el punto.

**Respuesta correcta:** B.

**Explicación del resultado:** Aunque `f(2)` está definida, los laterales `3` y `5` no coinciden. Falla la existencia del límite bilateral y, por tanto, la continuidad.

**Retroalimentación si responde mal:**

- Si elige A: el enunciado proporciona explícitamente `f(2) = 5`; la primera condición sí se cumple.
- Si elige C: la continuidad no exige que el valor sea cero. Exige que el límite exista y sea igual a `f(2)`.

**Ruta de estudio:** Módulo 6, caso de discontinuidad de salto.

## 6. Distribución del banco

| Módulo | Preguntas | Contenido principal |
| --- | --- | --- |
| 1. Idea intuitiva | M1-P1 a M1-P3 | Significado, aproximación y punto no definido |
| 2. Tablas | M2-P1 a M2-P3 | Tendencia, precisión y límites de la evidencia numérica |
| 3. Gráficas | M3-P1 a M3-P3 | Huecos, puntos llenos y diferencia entre límite y `f(a)` |
| 4. Laterales | M4-P1 a M4-P3 | Direcciones y condición de existencia |
| 5. Álgebra | M5-P1 a M5-P3 | Sustitución, `0/0` y factorización |
| 6. Continuidad | M6-P1 a M6-P3 | Tres condiciones, hueco y salto |

## 7. Modelo de revisión de una respuesta incorrecta

Cada error deberá mostrarse aproximadamente así:

```text
Pregunta: Si L⁻ = 3 y L⁺ = 5, ¿existe el límite bilateral?

Tu respuesta: Existe y vale 4.
Respuesta correcta: No existe.

¿Qué ocurrió?
Los límites laterales no se promedian. Para que exista el límite bilateral,
ambos lados deben aproximarse exactamente al mismo número. Como 3 ≠ 5,
la condición de existencia falla.

Tema relacionado: Módulo 4 — Límites laterales
[Volver a estudiar este módulo]
```

La explicación debe referirse al distractor elegido siempre que sea posible. Se evitarán mensajes genéricos como `Respuesta incorrecta, intenta de nuevo`.

## 8. Decisiones pendientes antes de programar

- Confirmar si la calificación utilizará únicamente porcentaje o también escala de `0` a `10`.
- Confirmar si el profesor quiere establecer una calificación mínima aprobatoria.
- Definir si la evaluación podrá abandonarse y retomarse durante la misma ejecución.
- Decidir si al repetir se permite recibir inmediatamente alguna pregunta del intento anterior.
- Aprobar los textos en español antes de traducir la interfaz visible al inglés.
