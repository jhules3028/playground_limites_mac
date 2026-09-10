
# Planeación técnica y ruta de desarrollo

## 1. Propósito del documento

Este documento establece la organización técnica y la ruta de desarrollo del Swift Playground dedicado al aprendizaje de límites de Cálculo I.

Su finalidad es mantener alineada la programación con los objetivos pedagógicos definidos en la planeación de contenidos.

La estructura propuesta permitirá desarrollar el proyecto por etapas, comenzando con una base funcional y agregando progresivamente cada módulo educativo.

El Playground deberá:

- Ejecutarse localmente en Xcode para macOS.
- Presentarse como una sola experiencia educativa.
- Permitir desarrollar y probar una pantalla a la vez.
- Separar la interfaz, el estado y los cálculos matemáticos.
- Reutilizar gráficas, botones, tarjetas y controles.
- Permitir la navegación entre todos los módulos.
- Conservar el progreso durante la sesión actual.
- Evitar dependencias de internet o servicios externos.
- Facilitar la traducción final de los textos al inglés.

El contenido podrá desarrollarse inicialmente en español.

Al concluir la implementación, los textos visibles se traducirán al inglés sin modificar innecesariamente los nombres internos del código.

## 2. Arquitectura general

El proyecto se desarrollará como un solo Swift Playground con una interfaz construida mediante SwiftUI.

Todos los módulos formarán parte de la misma experiencia.

No se utilizará un Playground independiente para cada tema.

Tampoco se utilizará el sistema de múltiples Pages de Xcode para dividir las lecciones.

Esta decisión permitirá:

- Compartir un mismo estado.
- Mantener el progreso del estudiante.
- Navegar entre los módulos.
- Reutilizar componentes.
- Mostrar una identidad visual uniforme.
- Administrar la evaluación desde el mismo proyecto.

Cada pantalla educativa tendrá un archivo Swift con un nombre descriptivo.

Por ejemplo:

- `CoverView.swift`
- `module_1/ModuleOneView.swift`
- `module_2/NumericalLimitView.swift`
- `module_3/GraphicalLimitView.swift`
- `AssessmentView.swift`

Los números de los módulos aparecerán en la interfaz, pero no definirán el nombre técnico de los archivos.

## 3. Organización de archivos

El Playground tendrá un punto de entrada llamado `Contents.swift`.

La mayor parte de la implementación se colocará en la carpeta `Sources`.

Los recursos visuales locales estarán dentro de la carpeta `Resources`.

La estructura general será:

```text
playground/
├── MyPlayground.playground/
│   ├── Contents.swift
│   ├── contents.xcplayground
│   ├── Sources/
│   │   ├── PlaygroundFactory.swift
│   │   ├── AppSection.swift
│   │   ├── AppState.swift
│   │   ├── AppTheme.swift
│   │   ├── Models.swift
│   │   ├── LimitMath.swift
│   │   ├── MainView.swift
│   │   ├── CoverView.swift
│   │   ├── LimitGraphView.swift
│   │   ├── LessonComponents.swift
│   │   ├── NavigationComponents.swift
│   │   ├── module_1/
│   │   │   ├── ModuleOneView.swift
│   │   │   ├── ModuleOneConceptView.swift
│   │   │   ├── ModuleOneExploreView.swift
│   │   │   ├── ModuleOneSummaryView.swift
│   │   │   ├── ModuleOneComponents.swift
│   │   │   └── ModuleOneExample.swift
│   │   ├── module_2/
│   │   │   ├── ModuleTwoView.swift
│   │   │   ├── ModuleTwoTableView.swift
│   │   │   ├── ModuleTwoPrecisionView.swift
│   │   │   ├── ModuleTwoSummaryView.swift
│   │   │   ├── ModuleTwoComponents.swift
│   │   │   └── ModuleTwoExample.swift
│   │   ├── module_3/
│   │   │   ├── ModuleThreeView.swift
│   │   │   ├── ModuleThreeReadingView.swift
│   │   │   ├── ModuleThreeExploreView.swift
│   │   │   ├── ModuleThreeSummaryView.swift
│   │   │   ├── ModuleThreeComponents.swift
│   │   │   ├── ModuleThreeGraph.swift
│   │   │   └── ModuleThreeExample.swift
│   │   ├── module_4/
│   │   │   ├── ModuleFourView.swift
│   │   │   ├── ModuleFourIntroductionView.swift
│   │   │   ├── ModuleFourSidePlayground.swift
│   │   │   ├── ModuleFourExistenceView.swift
│   │   │   ├── ModuleFourPracticeView.swift
│   │   │   ├── ModuleFourComponents.swift
│   │   │   ├── ModuleFourGraph.swift
│   │   │   └── ModuleFourExample.swift
│   │   ├── module_5/
│   │   │   ├── ModuleFiveView.swift
│   │   │   ├── ModuleFiveDirectView.swift
│   │   │   ├── ModuleFiveIndeterminateView.swift
│   │   │   ├── ModuleFiveFactoringView.swift
│   │   │   ├── ModuleFiveRationalizationView.swift
│   │   │   ├── ModuleFiveAssessmentView.swift
│   │   │   ├── ModuleFiveComponents.swift
│   │   │   └── ModuleFiveExample.swift
│   │   ├── module_6/
│   │   └── module_7/
│   ├── Resources/
│   │   └── fes-acatlan-logo.png
│   └── playground.xcworkspace/
├── docs/
│   ├── planeacion-contenidos.md
│   ├── planeacion-portada.md
│   └── planeacion-code.md
├── README.md
└── .gitignore
````

La infraestructura compartida y la portada permanecerán directamente en `Sources`.

Cada módulo educativo se organizará en su propia subcarpeta (`module_1`, `module_2`, etc.). Los archivos seguirán usando nombres descriptivos para que su función pueda identificarse sin depender solamente del número de módulo.

Los archivos se crearán conforme sean necesarios.

No será obligatorio construir toda la estructura desde el inicio.

## 4. Archivos fundamentales

### `Contents.swift`

Será el punto de entrada del Playground.

Sus responsabilidades serán:

* Importar `PlaygroundSupport`.
* Solicitar la vista principal mediante `PlaygroundFactory`.
* Asignar la vista a `PlaygroundPage.current.liveView`.
* Mantener activa la ejecución cuando existan animaciones.

Este archivo deberá ser pequeño.

No contendrá pantallas completas, ejercicios ni operaciones matemáticas.

### `PlaygroundFactory.swift`

Se encargará de conectar `Contents.swift` con la implementación interna.

Sus funciones principales serán:

* Crear el estado compartido.
* Inicializar `MainView`.
* Adaptar SwiftUI al Live View de macOS.
* Establecer el tamaño inicial de la experiencia.

Será el único acceso público que necesite utilizar `Contents.swift`.

### `AppSection.swift`

Definirá las pantallas disponibles mediante una enumeración.

Las secciones previstas son:

* Portada.
* Idea intuitiva.
* Representación numérica.
* Interpretación gráfica.
* Límites laterales.
* Cálculo algebraico.
* Continuidad.
* Evaluación.

También proporcionará el título, número y orden de navegación de cada módulo.

### `AppState.swift`

Administrará el estado compartido de la sesión.

Guardará información como:

* La pantalla seleccionada.
* Los módulos visitados.
* Los módulos completados.
* Las respuestas temporales.
* El resultado de la evaluación.
* La cantidad de respuestas correctas.
* El progreso general.

También contendrá acciones para:

* Avanzar.
* Retroceder.
* Volver a la portada.
* Ir a un módulo específico.
* Reiniciar el recorrido.
* Repetir la evaluación.

En la primera versión, el progreso solo se conservará durante la ejecución actual.

No se almacenarán datos personales.

### `AppTheme.swift`

Centralizará la identidad visual del Playground.

Incluirá:

* Azul institucional.
* Dorado de acento.
* Colores para aproximaciones laterales.
* Color de éxito.
* Color de advertencia.
* Color de error.
* Espaciados.
* Tamaños de texto.
* Esquinas redondeadas.
* Estilos de tarjetas.
* Estilos de botones.

Esto evitará repetir valores visuales arbitrarios en cada pantalla.

### `Models.swift`

Contendrá los modelos de datos compartidos.

Podrá incluir estructuras para:

* Información de los módulos.
* Ejemplos matemáticos.
* Pasos de soluciones algebraicas.
* Preguntas de evaluación.
* Opciones de respuesta.
* Retroalimentación.
* Resultados del estudiante.

Si algún modelo aumenta demasiado, podrá trasladarse posteriormente a un archivo propio.

### `LimitMath.swift`

Concentrará los cálculos matemáticos puros.

No contendrá elementos visuales.

Sus responsabilidades serán:

* Evaluar las funciones utilizadas.
* Crear datos para las tablas.
* Generar puntos para las gráficas.
* Evitar divisiones entre cero.
* Representar puntos no definidos.
* Formatear valores numéricos.
* Mantener resultados consistentes.

No será un sistema general de álgebra simbólica.

Solamente resolverá los ejemplos aprobados para el temario.

### `MainView.swift`

Será el contenedor principal de la experiencia.

Leerá la pantalla seleccionada desde `AppState`.

Después mostrará la vista correspondiente.

También integrará:

* Navegación.
* Indicador de progreso.
* Adaptación al tamaño de la ventana.
* Transiciones entre módulos.
* Acceso al índice de contenidos.

## 5. Pantallas educativas

### `CoverView.swift`

Será la portada institucional.

Mostrará:

* Logotipo de la FES Acatlán.
* Identificación de Cálculo I.
* Título del recurso.
* Descripción breve.
* Imagen o gráfica relacionada con límites.
* Frase “Observa, comprende y practica”.
* Botón para comenzar.

La portada utilizará fondo azul oscuro, detalles dorados y texto blanco.

El logotipo conservará sus proporciones originales.

### `IntuitiveLimitView.swift`

Corresponderá al módulo 1.

Explicará intuitivamente qué significa aproximarse a un límite.

Presentará:

* Punto objetivo.
* Valor límite.
* Notación matemática.
* Diferencia entre acercarse y alcanzar.
* Deslizador para modificar `x`.
* Valor actual de `x`.
* Valor actual de `f(x)`.
* Distancia respecto al objetivo.
* Conclusión guiada.

El estudiante observará que `f(x)` puede acercarse a un valor aunque `x` no alcance exactamente el punto indicado.

### `NumericalLimitView.swift`

Corresponderá al módulo 2.

Utilizará el ejemplo:

$$
\frac{x^2-4}{x-2}, \qquad x\to2
$$

La pantalla mostrará valores de `x` cercanos a `2`.

Se incluirán aproximaciones:

* Por la izquierda.
* Por la derecha.

El estudiante podrá seleccionar una precisión de una, dos o tres cifras.

Los valores más cercanos al punto objetivo se resaltarán.

La explicación indicará por qué la función se aproxima a `4`.

También mostrará por qué la expresión original no puede evaluarse directamente en `x = 2`.

### `GraphicalLimitView.swift`

Corresponderá al módulo 3.

Presentará una interpretación visual del límite.

La pantalla tendrá:

* Ejes coordenados.
* Cuadrícula.
* Curva de la función.
* Punto móvil.
* Hueco en un punto no definido.
* Lectura actual de `x`.
* Lectura actual de `f(x)`.
* Valor del límite.
* Valor de `f(a)` cuando exista.

El objetivo será distinguir entre:

$$
\lim_{x\to a}f(x)
$$

y

$$
f(a)
$$

Se mostrarán casos donde:

* El límite existe y `f(a)` no existe.
* El límite existe y `f(a)` tiene otro valor.
* El límite coincide con `f(a)`.

### `OneSidedLimitsView.swift`

Corresponderá al módulo 4.

Explicará los límites laterales.

El estudiante podrá aproximarse:

* Desde la izquierda.
* Desde la derecha.

Cada dirección tendrá controles separados.

Los colores se mantendrán consistentes en toda la aplicación.

La pantalla comparará:

$$
\lim_{x\to a^-}f(x)
$$

y

$$
\lim_{x\to a^+}f(x)
$$

Se mostrará un caso donde ambos límites laterales coinciden.

También se mostrará un caso donde son diferentes.

El estudiante deberá concluir si el límite bilateral existe.

### `AlgebraicLimitView.swift`

Corresponderá al módulo 5.

Explicará procedimientos algebraicos para calcular límites.

Comenzará con la sustitución directa.

Después explicará la indeterminación `0/0`.

Se aclarará que `0/0` no es el resultado del límite.

Es una señal de que la expresión necesita transformarse.

El módulo incluirá:

* Sustitución directa.
* Factorización.
* Simplificación.
* Cancelación de factores.
* Evaluación final.
* Racionalización, si se conserva.

El estudiante elegirá el siguiente paso correcto.

Cada decisión tendrá retroalimentación explicativa.

### `ContinuityView.swift`

Corresponderá al módulo 6.

Presentará las tres condiciones de continuidad en un punto:

1. La función está definida.
2. El límite existe.
3. El límite coincide con el valor de la función.

Se mostrarán ejemplos de:

* Función continua.
* Discontinuidad removible.
* Discontinuidad de salto.

El estudiante observará la gráfica y clasificará el caso.

Después recibirá retroalimentación inmediata.

### `AssessmentView.swift`

Corresponderá al módulo 7.

Contendrá entre 8 y 10 preguntas.

La evaluación incluirá ejercicios:

* Conceptuales.
* Numéricos.
* Gráficos.
* Algebraicos.
* De límites laterales.
* De continuidad.

El sistema permitirá:

* Seleccionar respuestas.
* Avanzar entre preguntas.
* Calcular la puntuación.
* Mostrar la cantidad de aciertos.
* Explicar los errores.
* Repetir la evaluación.
* Volver al módulo relacionado con cada error.

## 6. Componentes reutilizables

### `LimitGraphView.swift`

Será el componente gráfico compartido.

Permitirá configurar:

* Ejes.
* Cuadrícula.
* Curva.
* Punto móvil.
* Huecos.
* Puntos definidos.
* Aproximaciones laterales.
* Colores.
* Etiquetas.

Se utilizará principalmente en los módulos 1, 3, 4 y 6.

Su construcción será progresiva.

La primera versión únicamente tendrá las funciones necesarias para el módulo intuitivo.

### `LessonComponents.swift`

Reunirá componentes educativos reutilizables.

Podrá contener:

* Tarjeta de explicación.
* Bloque de idea clave.
* Expresión matemática.
* Panel de valores.
* Mensaje de retroalimentación.
* Botones de respuesta.
* Indicadores de acierto y error.

### `NavigationComponents.swift`

Contendrá los elementos comunes de navegación.

Incluirá:

* Botón “Anterior”.
* Botón “Siguiente”.
* Indicador del módulo.
* Barra de progreso.
* Acceso al índice.

El estudiante podrá regresar sin perder la orientación.

## 7. Flujo de navegación

El recorrido principal será:

```text
Portada
↓
Idea intuitiva
↓
Tabla de valores
↓
Interpretación gráfica
↓
Límites laterales
↓
Cálculo algebraico
↓
Continuidad
↓
Evaluación final
```

El recorrido será principalmente lineal.

También se permitirá regresar a módulos anteriores.

Posteriormente podrá incorporarse un índice lateral o un menú adaptable.

La evaluación podrá dirigir al estudiante al módulo relacionado con una respuesta incorrecta.

## 8. Recursos visuales

Los recursos utilizados durante la ejecución se guardarán en:

`MyPlayground.playground/Resources/`

Los archivos deberán:

* Utilizar nombres en minúsculas.
* Separar las palabras mediante guiones.
* Conservar las proporciones de los logotipos.
* Tener registrada su fuente.
* Estar disponibles localmente.
* No requerir descargas durante la ejecución.

El recurso inicial será:

`fes-acatlan-logo.png`

Las gráficas y elementos matemáticos se dibujarán preferentemente con SwiftUI.

Se evitarán imágenes decorativas que no aporten al aprendizaje.

## 9. Ruta de implementación

### Etapa 1. Base técnica y portada

Se crearán:

* `Contents.swift`
* `PlaygroundFactory.swift`
* `AppSection.swift`
* `AppState.swift`
* `AppTheme.swift`
* `MainView.swift`
* `CoverView.swift`

Al terminar esta etapa:

* El Playground abrirá correctamente.
* La portada aparecerá en el Live View.
* El logotipo se cargará localmente.
* La interfaz responderá a distintos tamaños.
* El botón “Comenzar” cambiará la pantalla.

### Etapa 2. Navegación y componentes

Se crearán:

* `LessonComponents.swift`
* `NavigationComponents.swift`
* Pantallas provisionales.

Al terminar esta etapa:

* Se podrá avanzar.
* Se podrá retroceder.
* Se mostrará el módulo actual.
* Los estilos comunes estarán centralizados.
* Será posible recorrer toda la estructura.

### Etapa 3. Idea intuitiva

Se desarrollarán:

* `IntuitiveLimitView.swift`
* Primera versión de `LimitGraphView.swift`
* Primera versión de `LimitMath.swift`

El deslizador modificará `x`.

La gráfica y los valores se actualizarán en tiempo real.

La explicación conectará el movimiento con la idea de aproximación.

### Etapa 4. Representación numérica

Se desarrollará `NumericalLimitView.swift`.

La tabla mostrará valores correctos a ambos lados de `2`.

El selector permitirá cambiar la precisión.

La aplicación evitará evaluar la expresión exactamente en el punto donde el denominador es cero.

### Etapa 5. Interpretación gráfica

Se desarrollará `GraphicalLimitView.swift`.

La gráfica mostrará:

* Curva.
* Hueco.
* Punto móvil.
* Punto definido cuando corresponda.

La interfaz diferenciará claramente el límite y `f(a)`.

### Etapa 6. Límites laterales

Se desarrollará `OneSidedLimitsView.swift`.

El estudiante controlará cada dirección de aproximación.

Los resultados de ambos lados se compararán.

La actividad permitirá decidir si el límite bilateral existe.

### Etapa 7. Cálculo algebraico

Se desarrollará `AlgebraicLimitView.swift`.

Los procedimientos aparecerán en orden lógico:

1. Sustitución.
2. Identificación de la indeterminación.
3. Factorización o transformación.
4. Simplificación.
5. Evaluación.

La selección de pasos generará retroalimentación específica.

### Etapa 8. Continuidad

Se desarrollará `ContinuityView.swift`.

Se mostrarán los tres casos acordados.

El estudiante verificará las condiciones de continuidad.

También clasificará diferentes discontinuidades.

### Etapa 9. Evaluación final

Se desarrollará `AssessmentView.swift`.

La evaluación cubrirá todos los módulos.

Mostrará:

* Calificación.
* Número de aciertos.
* Explicación de errores.
* Temas que deben repasarse.

El estudiante podrá repetirla o volver a estudiar.

### Etapa 10. Revisión final

Se comprobarán:

* Conceptos matemáticos.
* Resultados numéricos.
* Navegación.
* Controles.
* Reinicio.
* Legibilidad.
* Contraste.
* Compatibilidad con Xcode.
* Funcionamiento sin internet.

Después se traducirán al inglés los textos visibles.

Finalmente se actualizará el `README.md` con las instrucciones de ejecución.

## 10. Criterios de terminación

Un módulo se considerará terminado cuando:

1. La explicación matemática sea correcta.
2. Los ejemplos hayan sido revisados.
3. La interacción tenga una finalidad pedagógica.
4. Exista retroalimentación.
5. La navegación funcione.
6. La vista pueda abrirse y cerrarse correctamente.
7. No dependa de internet.
8. Sea legible en el tamaño acordado.
9. Funcione con los demás módulos.
10. Haya sido ejecutado y probado en Xcode.

## 11. Validación técnica

Durante cada etapa se realizará:

* Revisión de sintaxis Swift.
* Revisión de compatibilidad con SwiftUI.
* Revisión de compatibilidad con AppKit.
* Revisión del uso de `PlaygroundSupport`.
* Ejecución en Xcode.
* Prueba manual de los controles.
* Prueba de navegación.
* Comprobación de resultados matemáticos.
* Revisión de los archivos modificados.
* Revisión de `git status`.

No se agregarán:

* Librerías externas.
* Servicios de red.
* Firmas de aplicaciones.
* Simuladores de iOS.
* Proyectos `.xcodeproj`.

## 12. Decisiones pendientes

Antes de finalizar el proyecto deberán definirse:

* Versión mínima de macOS.
* Versión mínima de Xcode.
* Tamaño inicial del Live View.
* Datos institucionales de la portada.
* Datos personales que aparecerán.
* Título definitivo en inglés.
* Diseño exacto del índice.
* Número final de preguntas.
* Redacción de la evaluación.
* Inclusión o eliminación de racionalización.

Estas decisiones no impiden comenzar la portada ni la base técnica. Se resolverán antes de implementar el apartado correspondiente.
