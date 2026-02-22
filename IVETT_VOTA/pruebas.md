# Reporte de pruebas unitarias - Vota & Opina

1. Introduccion
- Descripcion breve del caso de estudio: sistema web "Vota & Opina" para crear encuestas, administrar preguntas y registrar votos de participantes.
- Objetivo de las pruebas unitarias realizadas: validar reglas de negocio clave en autenticacion, creacion/publicacion de encuestas y registro de respuestas, usando particionamiento de equivalencias para cubrir entradas validas e invalidas.
- Justificacion del uso de la tecnica de particionamiento de equivalencias: reduce el numero de casos manteniendo cobertura al probar clases representativas (valida/invalida) sin evaluar cada valor posible.
- Alcance del analisis: `index.php` (inicio de sesion), `crear_encuesta.php` y `editar_encuesta.php` (creacion y preguntas), `publicar_encuesta.php` (publicacion), `votar.php` y `procesar_voto.php` (emision y registro de respuestas). Se considero el flujo de pruebas automatizadas base en `tests/auth.spec.js`.

2. Desarrollo
a) Diseno de casos de prueba

Tabla A. Inicio de sesion (equivalencias del Caso de Prueba 2 del PDF)

| ID | Modulo o funcionalidad | Clase de equivalencia | Datos de entrada | Resultado esperado | Resultado obtenido | Estatus |
| --- | --- | --- | --- | --- | --- | --- |
| CP-LOGIN-01 | Inicio de sesion | Valida (CV-1/CV-2) | usuario registrado `admin@vota.com`, password correcta | Redirige a `dashboard.php` | Redirige a `dashboard.php` | Aprobado |
| CP-LOGIN-02 | Inicio de sesion | Invalida (CNV-1) | usuario no registrado | Mensaje "Usuario o contrasena incorrectos." | Mensaje mostrado | Aprobado |
| CP-LOGIN-03 | Inicio de sesion | Invalida (CNV-2) | usuario vacio o password vacio | Mensaje "Por favor ingrese todos los campos." | Mensaje mostrado | Aprobado |
| CP-LOGIN-04 | Inicio de sesion | Invalida (CNV-3) | usuario con formato no valido (ej. "##") | Rechazo de inicio de sesion | Mensaje "Usuario o contrasena incorrectos." | Aprobado |

Tabla B. Creacion de encuesta (equivalencias del Caso de Prueba 3 del PDF)

| ID | Modulo o funcionalidad | Clase de equivalencia | Datos de entrada | Resultado esperado | Resultado obtenido | Estatus |
| --- | --- | --- | --- | --- | --- | --- |
| CP-ENC-01 | Crear encuesta | Valida (CV-1/CV-4) | titulo "Satisfaccion 2026", cliente valido, fecha_inicio <= fecha_fin | Guarda y redirige a `editar_encuesta.php` | Redirige a `editar_encuesta.php` | Aprobado |
| CP-ENC-02 | Crear encuesta | Invalida (CNV-1) | campos obligatorios vacios | Mensaje "Por favor complete los campos obligatorios." | Mensaje mostrado | Aprobado |
| CP-ENC-03 | Crear encuesta | Invalida (CNV-9) | fecha_inicio posterior a fecha_fin | Mensaje "La fecha de inicio no puede ser posterior a la fecha de fin." | Mensaje mostrado | Aprobado |
| CP-ENC-04 | Crear encuesta | Invalida (CNV-2) | titulo demasiado corto (ej. 2 caracteres) | Rechazo por longitud minima | Se guarda sin validar longitud | Fallido |

Tabla C. Preguntas y opciones (equivalencias del Caso de Prueba 3 del PDF)

| ID | Modulo o funcionalidad | Clase de equivalencia | Datos de entrada | Resultado esperado | Resultado obtenido | Estatus |
| --- | --- | --- | --- | --- | --- | --- |
| CP-PREG-01 | Agregar pregunta | Valida (CV-2/CV-3) | texto valido + tipo `opcion_unica` con 2 opciones | Pregunta y opciones guardadas | Pregunta y opciones guardadas | Aprobado |
| CP-PREG-02 | Agregar pregunta | Valida (CV-2) | texto valido + tipo `texto_libre` sin opciones | Pregunta guardada | Pregunta guardada | Aprobado |
| CP-PREG-03 | Agregar pregunta | Invalida (CNV-4) | texto vacio | Mensaje de validacion | No se guarda, sin mensaje de error | Fallido |
| CP-PREG-04 | Agregar pregunta | Invalida (CNV-6) | `opcion_unica` con 0-1 opciones | Rechazo por minimo de opciones | Se guarda sin validar minimo | Fallido |

Tabla D. Publicacion de encuesta

| ID | Modulo o funcionalidad | Clase de equivalencia | Datos de entrada | Resultado esperado | Resultado obtenido | Estatus |
| --- | --- | --- | --- | --- | --- | --- |
| CP-PUB-01 | Publicar encuesta | Valida (CV-4) | encuesta con al menos 1 pregunta | Cambia estado a activa y redirige a `lista_encuestas.php` | Redirige a `lista_encuestas.php?msg=publicada` | Aprobado |
| CP-PUB-02 | Publicar encuesta | Invalida (CNV-7) | encuesta sin preguntas | Rechazo y redirige a `editar_encuesta.php` con error | Redirige con `error=nopreguntas` | Aprobado |

Tabla E. Emision de voto (equivalencias del Caso de Prueba 4 del PDF)

| ID | Modulo o funcionalidad | Clase de equivalencia | Datos de entrada | Resultado esperado | Resultado obtenido | Estatus |
| --- | --- | --- | --- | --- | --- | --- |
| CP-VOTO-01 | Enviar respuestas | Valida (CV-1/CV-2/CV-3/CV-4) | encuesta activa, edad 18, genero "masculino", respuestas completas | Mensaje de gracias y registro en BD | Pagina de agradecimiento | Aprobado |
| CP-VOTO-02 | Enviar respuestas | Invalida (CNV-9) | edad fuera de rango (ej. 3) | Rechazo por validacion | Se registra sin validacion servidor | Fallido |
| CP-VOTO-03 | Enviar respuestas | Invalida (CNV-5) | genero vacio (enviado manualmente) | Rechazo por validacion | Se registra sin validacion servidor | Fallido |
| CP-VOTO-04 | Votar | Invalida (CNV-4) | encuesta cerrada o inexistente | Mensaje "no existe o no esta activa" | Mensaje mostrado | Aprobado |

b) Evidencia de ejecucion
- Capturas pendientes: no se encontraron evidencias en `playwright-report/` ni en `test-results/`.
- Recomendacion: adjuntar capturas manuales del flujo de login, creacion de encuesta, publicacion y envio de voto (incluyendo mensajes de error) en una carpeta `evidencias/` y referenciarlas aqui.

c) Resultados del analisis
- Error 1: falta validacion de longitud del titulo de encuesta (tipo: validacion/logica). Impacto: encuestas con datos incompletos o poco descriptivos.
- Error 2: no se valida minimo de opciones para preguntas de opcion unica/multiple (tipo: funcional/validacion). Impacto: encuestas publicadas con preguntas sin opciones, lo que rompe el flujo de votacion.
- Error 3: no hay validacion en servidor para edad/genero (tipo: validacion). Impacto: datos demograficos inconsistentes y posible ingreso de valores fuera de rango al omitir validacion de cliente.
- Observacion: el alta de pregunta vacia no informa error al usuario (tipo: interfaz/validacion). Impacto: mala retroalimentacion y riesgo de confusion en el flujo de edicion.

d) Lineas de accion propuestas
- Acciones correctivas especificas:
  - Validar longitud minima/maxima del titulo y de las preguntas en servidor.
  - Verificar minimo de 2 opciones cuando el tipo sea `opcion_unica` o `opcion_multiple`.
  - Revalidar edad y genero en `procesar_voto.php` con rangos permitidos.
- Recomendaciones tecnicas:
  - Centralizar reglas de validacion (funcion reutilizable o capa de servicio) para evitar divergencias entre front y back.
  - Agregar pruebas unitarias de validacion (p. ej. PHPUnit) o ampliar pruebas de Playwright para entradas invalidas.
- Prioridad del ajuste:
  - Alta: validacion de opciones y edad/genero.
  - Media: longitud de titulo y mensaje de error en pregunta vacia.

3. Conclusiones
- La tecnica de particionamiento de equivalencias permitio definir casos representativos y detectar faltas de validacion sin cubrir cada valor individual.
- Las pruebas unitarias son clave para asegurar la calidad del desarrollo, especialmente en reglas de negocio y validaciones que no deben depender solo del cliente.
- Principales aprendizajes: alinear reglas de validacion con el disenio de casos de prueba evita discrepancias entre lo esperado y lo implementado.
- Areas de mejora: formalizar criterios de validacion en backend y documentar criterios de aceptacion antes de implementar.
