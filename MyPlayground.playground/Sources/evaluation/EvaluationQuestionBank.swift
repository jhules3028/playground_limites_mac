import Foundation

enum EvaluationQuestionBank {
    static let all: [EvaluationQuestion] = [
        question(
            id: "M1-P1", module: 1, title: "Idea intuitiva",
            prompt: "¿Qué describe principalmente la expresión  lim x→a f(x) = L?",
            choices: [
                ("A", "El valor que obligatoriamente toma la función exactamente en x = a.", "Confundiste el límite con f(a). El límite observa puntos cercanos; el valor exacto de la función es una pregunta diferente."),
                ("B", "El valor al que se aproxima f(x) cuando x se acerca a a.", nil),
                ("C", "El valor más grande que puede alcanzar la función.", "Un límite no representa un máximo. La función puede aproximarse a L aunque existan valores mayores o menores en otras regiones.")
            ], correct: "B",
            explanation: "Un límite estudia la tendencia de los valores de la función alrededor de a. No exige que x sea igual a a ni que f(a) exista.",
            route: "Pantallas de introducción y aproximación."
        ),
        question(
            id: "M1-P2", module: 1, title: "Idea intuitiva",
            prompt: "Cuando escribimos  x → 2, ¿qué debe entenderse?",
            choices: [
                ("A", "Que solamente podemos utilizar x = 2.", "Sustituir exactamente x = 2 estudia f(2), no necesariamente el límite. La aproximación utiliza valores vecinos."),
                ("B", "Que x debe permanecer lejos de 2.", "La idea es reducir la distancia respecto a 2, no conservarla grande."),
                ("C", "Que usamos valores cada vez más cercanos a 2, sin necesitar que sean exactamente 2.", nil)
            ], correct: "C",
            explanation: "La flecha representa un proceso de aproximación. Valores como 1.9, 1.99, 2.01 o 2.001 permiten estudiar qué sucede alrededor del punto objetivo.",
            route: "Playground del deslizador."
        ),
        question(
            id: "M1-P3", module: 1, title: "Idea intuitiva",
            prompt: "Al acercarse x a 5, los valores de f(x) se aproximan a −2, pero f(5) no está definida. ¿Cuál es la conclusión correcta?",
            choices: [
                ("A", "El límite puede ser −2 aunque f(5) no exista.", nil),
                ("B", "El límite no existe porque falta f(5).", "Estás imponiendo al límite una condición que no necesita. Un hueco puede coexistir con un límite perfectamente definido."),
                ("C", "Podemos afirmar que f(5) = −2.", "La aproximación permite determinar el límite, pero no autoriza inventar un valor para f(5).")
            ], correct: "A",
            explanation: "La existencia del límite depende del comportamiento cercano. El valor exacto de la función puede estar ausente sin destruir esa tendencia.",
            route: "Resumen sobre aproximarse sin alcanzar."
        ),

        question(
            id: "M2-P1", module: 2, title: "Representación numérica",
            prompt: "La tabla acerca x a 2 por ambos lados. ¿A qué valor se aproxima la función?",
            choices: [
                ("A", "A 2.", "2 es el valor al que se acerca x, no el valor al que se acerca f(x)."),
                ("B", "A 4.", nil),
                ("C", "A 0.", "Que la expresión original produzca 0/0 en x = 2 no significa que los valores de la tabla se aproximen a cero.")
            ], correct: "B",
            explanation: "Los valores de ambos lados se acercan a 4: desde abajo por la izquierda y desde arriba por la derecha.",
            route: "Pantalla de lectura de la tabla.", visual: .numericalTable
        ),
        question(
            id: "M2-P2", module: 2, title: "Representación numérica",
            prompt: "Al cambiar de x = 1.9 a x = 1.99, ¿qué ocurre con la distancia hasta 2?",
            choices: [
                ("A", "Pasa de 0.1 a 0.01; estamos diez veces más cerca.", nil),
                ("B", "La distancia permanece igual porque ambos números empiezan con 1.", "Debe compararse la diferencia respecto a 2, no solamente los primeros dígitos escritos."),
                ("C", "Cambiamos de aproximación por la izquierda a aproximación por la derecha.", "Tanto 1.9 como 1.99 son menores que 2, así que ambos pertenecen al lado izquierdo.")
            ], correct: "A",
            explanation: "2 − 1.9 = 0.1 y 2 − 1.99 = 0.01. Agregar precisión reduce la distancia por un factor de diez.",
            route: "Pantalla para cambiar la precisión."
        ),
        question(
            id: "M2-P3", module: 2, title: "Representación numérica",
            prompt: "Si una tabla de valores cercanos indica que f(x) se aproxima a 4 cuando x → 2, ¿qué podemos concluir con seguridad?",
            choices: [
                ("A", "El comportamiento cercano sugiere un límite igual a 4, pero la tabla no determina por sí sola f(2).", nil),
                ("B", "f(2) necesariamente vale 4.", "Extrapolaste una tendencia cercana al valor exacto sin contar con información suficiente."),
                ("C", "La función no está definida en ningún punto.", "La tabla muestra numerosos puntos donde la función sí tiene valores; no permite afirmar que esté indefinida en todas partes.")
            ], correct: "A",
            explanation: "La tabla analiza entradas próximas a 2. Si no incluye la definición exacta de la función en 2, no puede asegurar cuánto vale f(2).",
            route: "Pantalla de interpretación y conclusión."
        ),

        question(
            id: "M3-P1", module: 3, title: "Interpretación gráfica",
            prompt: "¿Qué información representa la gráfica en x = 2?",
            choices: [
                ("A", "lim x→2 f(x) = 4 y f(2) no existe.", nil),
                ("B", "El límite no existe porque hay un hueco.", "Interpretaste el hueco como ausencia de tendencia. El hueco afecta f(2), pero la curva de ambos lados sigue apuntando a 4."),
                ("C", "f(2) = 4, aunque no exista ningún punto lleno.", "Un círculo abierto no asigna un valor a la función. Para afirmar f(2) = 4 se necesitaría un punto lleno.")
            ], correct: "A",
            explanation: "La curva se aproxima a 4 desde ambos lados, por lo que el límite existe. El círculo abierto indica que falta el valor exacto de la función.",
            route: "Pantalla para leer la gráfica.", visual: .graphUndefined
        ),
        question(
            id: "M3-P2", module: 3, title: "Interpretación gráfica",
            prompt: "Observa el hueco en (2, 4) y el punto lleno en (2, 6). ¿Cuál es la lectura correcta?",
            choices: [
                ("A", "El límite y f(2) valen 6.", "Utilizaste el punto lleno para responder dos preguntas distintas. Ese punto determina f(2), pero no cambia la tendencia cercana."),
                ("B", "lim x→2 f(x) = 4 y f(2) = 6.", nil),
                ("C", "El límite no existe porque hay dos marcas en x = 2.", "Las dos marcas tienen funciones diferentes: una representa la tendencia y la otra el valor exacto. No generan ambigüedad en el límite.")
            ], correct: "B",
            explanation: "La curva cercana conduce al hueco situado en 4; ése es el límite. El punto lleno situado en 6 define el valor exacto f(2).",
            route: "Pantalla para comparar los tres casos de f(a).", visual: .graphDifferent
        ),
        question(
            id: "M3-P3", module: 3, title: "Interpretación gráfica",
            prompt: "La curva atraviesa un punto lleno en (2, 4), sin huecos ni saltos. ¿Qué afirmación es correcta?",
            choices: [
                ("A", "lim x→2 f(x) = 4 y f(2) = 4.", nil),
                ("B", "El límite vale 2 porque ése es el valor de x.", "Confundiste la coordenada horizontal con la altura de la función. x se aproxima a 2, mientras f(x) se aproxima a 4."),
                ("C", "f(2) existe, pero el límite no puede conocerse visualmente.", "La tendencia sí puede leerse en la curva cercana. Ambos lados conducen a la misma altura.")
            ], correct: "A",
            explanation: "La curva se aproxima a 4 desde ambos lados y el punto lleno confirma que la función también vale 4 en x = 2.",
            route: "Pantalla de diferenciación entre límite y valor exacto.", visual: .graphContinuous
        ),

        question(
            id: "M4-P1", module: 4, title: "Límites laterales",
            prompt: "¿Qué indica el signo menos en  lim x→a⁻ f(x)?",
            choices: [
                ("A", "Que el resultado del límite será negativo.", "Confundiste dirección con signo numérico. Un límite izquierdo puede producir un número positivo, negativo o cero."),
                ("B", "Que x se aproxima utilizando valores menores que a.", nil),
                ("C", "Que la función siempre está disminuyendo.", "Acercarse desde la izquierda no obliga a la función a disminuir; la curva podría crecer, disminuir o cambiar de otra manera.")
            ], correct: "B",
            explanation: "El signo − señala el lado de aproximación. No describe el signo del resultado ni el crecimiento de la función.",
            route: "Introducción y playground izquierdo."
        ),
        question(
            id: "M4-P2", module: 4, title: "Límites laterales",
            prompt: "Si lim x→2⁻ f(x) = 3 y lim x→2⁺ f(x) = 5, ¿qué ocurre con lim x→2 f(x)?",
            choices: [
                ("A", "Existe y vale 4, porque es el promedio.", "Los límites laterales no se combinan mediante un promedio. La igualdad entre ambos es una condición obligatoria."),
                ("B", "Existe y vale 5, porque se toma el lado derecho.", "El lado derecho no tiene prioridad sobre el izquierdo. Ambos deben conducir al mismo valor."),
                ("C", "No existe, porque los límites laterales son diferentes.", nil)
            ], correct: "C",
            explanation: "Un límite bilateral exige que ambos límites laterales coincidan. No se promedian ni se elige uno de ellos.",
            route: "Pantalla de condición de existencia."
        ),
        question(
            id: "M4-P3", module: 4, title: "Límites laterales",
            prompt: "Si lim x→a⁻ f(x) = −2 y lim x→a⁺ f(x) = −2, ¿qué podemos afirmar?",
            choices: [
                ("A", "El límite bilateral existe y vale −2.", nil),
                ("B", "No existe porque el resultado es negativo.", "Un límite puede ser negativo sin ningún problema. Lo importante es la coincidencia de ambos lados."),
                ("C", "Vale 0 porque los dos lados se cancelan.", "Los laterales no se suman ni se cancelan; se comparan para verificar que sean iguales.")
            ], correct: "A",
            explanation: "Los límites laterales existen y coinciden en −2; por tanto, el límite bilateral existe y tiene ese mismo valor.",
            route: "Comparación entre laterales coincidentes y diferentes."
        ),

        question(
            id: "M5-P1", module: 5, title: "Cálculo algebraico",
            prompt: "Calcula  lim x→2 (3x + 1).",
            choices: [
                ("A", "6", "Calculaste 3 × 2, pero olvidaste sumar el término +1."),
                ("B", "7", nil),
                ("C", "8", "Revisa la multiplicación y la suma: 3(2) es 6, no 7; después se suma 1.")
            ], correct: "B",
            explanation: "La función lineal está definida en x = 2. Sustituyendo directamente: 3(2) + 1 = 6 + 1 = 7.",
            route: "Pantalla de sustitución directa."
        ),
        question(
            id: "M5-P2", module: 5, title: "Cálculo algebraico",
            prompt: "Al sustituir el punto objetivo en un cociente aparece 0/0. ¿Qué significa?",
            choices: [
                ("A", "Que el límite siempre vale 0.", "Cero dividido entre cero no se evalúa como cero. Diferentes expresiones con forma 0/0 pueden tener límites diferentes."),
                ("B", "Que el límite automáticamente no existe.", "La indeterminación no demuestra inexistencia. En muchos ejemplos el límite aparece después de simplificar."),
                ("C", "Que la sustitución directa no basta y debemos transformar la expresión.", nil)
            ], correct: "C",
            explanation: "0/0 es una forma indeterminada. Puede esconder límites distintos, por lo que debemos factorizar, racionalizar u obtener otra expresión equivalente.",
            route: "Pantalla sobre la forma indeterminada 0/0."
        ),
        question(
            id: "M5-P3", module: 5, title: "Cálculo algebraico",
            prompt: "Calcula  lim x→2 (x² − 4)/(x − 2).",
            choices: [
                ("A", "0", "Interpretaste 0/0 como cero. Debes factorizar antes de decidir el valor del límite."),
                ("B", "2", "Probablemente conservaste sólo el punto objetivo. Después de simplificar queda x + 2, por lo que debes calcular 2 + 2."),
                ("C", "4", nil)
            ], correct: "C",
            explanation: "x² − 4 = (x − 2)(x + 2). Para x ≠ 2 se simplifica el factor x − 2, queda x + 2 y al sustituir se obtiene 4.",
            route: "Pantalla de factorización."
        ),

        question(
            id: "M6-P1", module: 6, title: "Continuidad",
            prompt: "¿Qué conjunto de condiciones garantiza que f sea continua en x = a?",
            choices: [
                ("A", "Únicamente que f(a) exista.", "Un punto lleno puede existir aun cuando la curva tenga un salto y el límite bilateral no exista."),
                ("B", "Que f(a) exista, que lim x→a f(x) exista y que ambos valores sean iguales.", nil),
                ("C", "Únicamente que los límites laterales sean números positivos.", "Los límites pueden ser negativos o cero. La condición relevante es que los laterales coincidan y que el resultado sea igual a f(a).")
            ], correct: "B",
            explanation: "La continuidad requiere simultáneamente valor exacto, límite bilateral y coincidencia entre ellos.",
            route: "Pantalla de las tres condiciones."
        ),
        question(
            id: "M6-P2", module: 6, title: "Continuidad",
            prompt: "En x = 2, el límite existe y vale 4, pero f(2) no está definida. ¿Qué comportamiento aparece?",
            choices: [
                ("A", "Función continua en x = 2.", "Falla la primera condición porque f(2) no existe y también falla la igualdad con el límite."),
                ("B", "Discontinuidad removible.", nil),
                ("C", "Discontinuidad de salto.", "En un salto los límites laterales son diferentes. Aquí ambos lados sí se aproximan a 4.")
            ], correct: "B",
            explanation: "Hay un hueco que puede repararse definiendo f(2) = 4. El límite ya existe; falta hacer coincidir el valor exacto.",
            route: "Caso de discontinuidad removible."
        ),
        question(
            id: "M6-P3", module: 6, title: "Continuidad",
            prompt: "Se sabe que f(2) = 5, lim x→2⁻ f(x) = 3 y lim x→2⁺ f(x) = 5. ¿Por qué la función no es continua?",
            choices: [
                ("A", "Porque f(2) no existe.", "El enunciado proporciona explícitamente f(2) = 5; la primera condición sí se cumple."),
                ("B", "Porque el límite bilateral no existe: los límites laterales son diferentes.", nil),
                ("C", "Porque una función continua debe tener valor cero en el punto.", "La continuidad no exige que el valor sea cero. Exige que el límite exista y sea igual a f(2).")
            ], correct: "B",
            explanation: "Aunque f(2) está definida, los laterales 3 y 5 no coinciden. Falla la existencia del límite bilateral y, por tanto, la continuidad.",
            route: "Caso de discontinuidad de salto."
        )
    ]

    private typealias Choice = (id: String, text: String, feedback: String?)

    private static func question(
        id: String,
        module: Int,
        title: String,
        prompt: String,
        choices: [Choice],
        correct: String,
        explanation: String,
        route: String,
        visual: EvaluationVisual? = nil
    ) -> EvaluationQuestion {
        EvaluationQuestion(
            id: id,
            moduleNumber: module,
            moduleTitle: title,
            prompt: prompt,
            options: choices.map {
                EvaluationOption(id: $0.id, text: $0.text, incorrectFeedback: $0.feedback)
            },
            correctOptionID: correct,
            explanation: explanation,
            studyRoute: route,
            visual: visual
        )
    }
}
