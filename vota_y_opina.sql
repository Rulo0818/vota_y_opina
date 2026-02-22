-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 22-02-2026 a las 20:42:15
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vota_y_opina`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` int(11) NOT NULL,
  `nombre_organizacion` varchar(150) NOT NULL,
  `contacto_correo` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cliente_id`, `nombre_organizacion`, `contacto_correo`, `telefono`, `direccion`) VALUES
(1, 'Ayuntamiento de Tlaxcala', 'contacto@ayto-tlaxcala.gob.mx', '2460000001', 'Centro, Tlaxcala'),
(2, 'Universidad Local', 'encuestas@uni.mx', '2220000002', 'Puebla, Pue.'),
(3, 'ONG Participación Ciudadana', 'hola@ongpc.org', '5500000003', 'CDMX'),
(4, 'Empresa Demo S.A. de C.V.', 'soporte@empresademo.com', '7710000004', 'Hidalgo'),
(5, 'Ayuntamiento de Tlaxcala', 'contacto@ayto-tlaxcala.gob.mx', '2460000001', 'Centro, Tlaxcala'),
(6, 'Universidad Local', 'encuestas@uni.mx', '2220000002', 'Puebla, Pue.'),
(7, 'ONG Participación Ciudadana', 'hola@ongpc.org', '5500000003', 'CDMX'),
(8, 'Empresa Demo S.A. de C.V.', 'soporte@empresademo.com', '7710000004', 'Hidalgo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuestas`
--

CREATE TABLE `encuestas` (
  `encuesta_id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `creador_usuario_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado_encuesta` enum('borrador','activa','cerrada') DEFAULT 'borrador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `encuestas`
--

INSERT INTO `encuestas` (`encuesta_id`, `cliente_id`, `creador_usuario_id`, `titulo`, `descripcion`, `fecha_creacion`, `fecha_inicio`, `fecha_fin`, `estado_encuesta`) VALUES
(9, 2, 2, 'Mantenimiento Programado', 'test', '2026-02-22 00:21:28', '2025-02-22', '2025-02-23', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id_estado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`id_estado`, `nombre`) VALUES
(1, 'Tlaxcala'),
(2, 'Puebla'),
(3, 'Ciudad de México'),
(4, 'Hidalgo'),
(5, 'Tlaxcala'),
(6, 'Puebla'),
(7, 'Ciudad de México'),
(8, 'Hidalgo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes`
--

CREATE TABLE `informes` (
  `informe_id` int(11) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `fecha_generacion` datetime DEFAULT current_timestamp(),
  `tipo_reporte` varchar(100) DEFAULT NULL,
  `datos_json` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `id_municipio` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `id_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id_municipio`, `nombre`, `id_estado`) VALUES
(1, 'Tlaxcala de Xicohténcatl', 1),
(2, 'Apizaco', 1),
(3, 'Puebla', 2),
(4, 'Benito Juárez', 3),
(5, 'Tlaxcala de Xicohténcatl', 1),
(6, 'Apizaco', 1),
(7, 'Puebla', 2),
(8, 'Benito Juárez', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones_respuesta`
--

CREATE TABLE `opciones_respuesta` (
  `opcion_id` int(11) NOT NULL,
  `pregunta_id` int(11) NOT NULL,
  `texto_opcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opciones_respuesta`
--

INSERT INTO `opciones_respuesta` (`opcion_id`, `pregunta_id`, `texto_opcion`) VALUES
(5, 6, 'si'),
(6, 6, 'no');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participantes`
--

CREATE TABLE `participantes` (
  `participante_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `genero` enum('masculino','femenino','otro') DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `participantes`
--

INSERT INTO `participantes` (`participante_id`, `usuario_id`, `edad`, `genero`, `fecha_registro`) VALUES
(1, 2, 23, 'masculino', '2026-02-21 23:23:01'),
(2, NULL, 31, 'femenino', '2026-02-21 23:23:01'),
(3, NULL, 19, 'otro', '2026-02-21 23:23:01'),
(4, NULL, 45, 'masculino', '2026-02-21 23:23:01'),
(5, 2, 23, 'masculino', '2026-02-22 00:10:28'),
(6, NULL, 31, 'femenino', '2026-02-22 00:10:28'),
(7, NULL, 19, 'otro', '2026-02-22 00:10:28'),
(8, NULL, 45, 'masculino', '2026-02-22 00:10:28'),
(9, NULL, 19, 'masculino', '2026-02-22 00:22:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `pregunta_id` int(11) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `texto_pregunta` text NOT NULL,
  `tipo_pregunta` enum('opcion_unica','opcion_multiple','texto_libre','escala') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`pregunta_id`, `encuesta_id`, `texto_pregunta`, `tipo_pregunta`) VALUES
(5, 9, 'Es un buen equipo', 'escala'),
(6, 9, 'los ves jugar', 'opcion_multiple');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `respuesta_id` int(11) NOT NULL,
  `participante_id` int(11) NOT NULL,
  `pregunta_id` int(11) NOT NULL,
  `opcion_id` int(11) DEFAULT NULL,
  `respuesta_texto` text DEFAULT NULL,
  `fecha_respuesta` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`respuesta_id`, `participante_id`, `pregunta_id`, `opcion_id`, `respuesta_texto`, `fecha_respuesta`) VALUES
(5, 9, 5, NULL, '5', '2026-02-22 00:22:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `id_seccion` int(11) NOT NULL,
  `nombre_seccion` varchar(100) NOT NULL,
  `id_municipio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`id_seccion`, `nombre_seccion`, `id_municipio`) VALUES
(1, 'Sección 001', 1),
(2, 'Sección 002', 1),
(3, 'Sección 101', 2),
(4, 'Sección 501', 4),
(5, 'Sección 001', 1),
(6, 'Sección 002', 1),
(7, 'Sección 101', 2),
(8, 'Sección 501', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo_electronico` varchar(150) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('admin','encuestador','participante','cliente') NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `estado_usuario` enum('activo','inactivo') DEFAULT 'activo',
  `id_estado` int(11) DEFAULT NULL,
  `id_municipio` int(11) DEFAULT NULL,
  `id_seccion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `nombre_usuario`, `nombre`, `apellido`, `correo_electronico`, `telefono`, `fecha_nacimiento`, `contrasena`, `rol`, `fecha_registro`, `estado_usuario`, `id_estado`, `id_municipio`, `id_seccion`) VALUES
(2, 'admin', 'Admin', 'System', 'admin@vota.com', NULL, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', '2026-02-21 23:22:36', 'activo', 1, 1, 1),
(3, 'sitko', 'Raúl', 'Polvo', 'sitko@vota.com', '2461234567', '2002-08-23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'participante', '2026-02-21 23:22:36', 'activo', 1, 2, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`);

--
-- Indices de la tabla `encuestas`
--
ALTER TABLE `encuestas`
  ADD PRIMARY KEY (`encuesta_id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `creador_usuario_id` (`creador_usuario_id`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `informes`
--
ALTER TABLE `informes`
  ADD PRIMARY KEY (`informe_id`),
  ADD KEY `encuesta_id` (`encuesta_id`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id_municipio`),
  ADD KEY `id_estado` (`id_estado`);

--
-- Indices de la tabla `opciones_respuesta`
--
ALTER TABLE `opciones_respuesta`
  ADD PRIMARY KEY (`opcion_id`),
  ADD KEY `pregunta_id` (`pregunta_id`);

--
-- Indices de la tabla `participantes`
--
ALTER TABLE `participantes`
  ADD PRIMARY KEY (`participante_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`pregunta_id`),
  ADD KEY `encuesta_id` (`encuesta_id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`respuesta_id`),
  ADD KEY `participante_id` (`participante_id`),
  ADD KEY `pregunta_id` (`pregunta_id`),
  ADD KEY `opcion_id` (`opcion_id`);

--
-- Indices de la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD PRIMARY KEY (`id_seccion`),
  ADD KEY `id_municipio` (`id_municipio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `correo_electronico` (`correo_electronico`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_municipio` (`id_municipio`),
  ADD KEY `id_seccion` (`id_seccion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `encuestas`
--
ALTER TABLE `encuestas`
  MODIFY `encuesta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `informes`
--
ALTER TABLE `informes`
  MODIFY `informe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id_municipio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `opciones_respuesta`
--
ALTER TABLE `opciones_respuesta`
  MODIFY `opcion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `participantes`
--
ALTER TABLE `participantes`
  MODIFY `participante_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `pregunta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `respuesta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `id_seccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `encuestas`
--
ALTER TABLE `encuestas`
  ADD CONSTRAINT `encuestas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`),
  ADD CONSTRAINT `encuestas_ibfk_2` FOREIGN KEY (`creador_usuario_id`) REFERENCES `usuarios` (`usuario_id`);

--
-- Filtros para la tabla `informes`
--
ALTER TABLE `informes`
  ADD CONSTRAINT `informes_ibfk_1` FOREIGN KEY (`encuesta_id`) REFERENCES `encuestas` (`encuesta_id`);

--
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`);

--
-- Filtros para la tabla `opciones_respuesta`
--
ALTER TABLE `opciones_respuesta`
  ADD CONSTRAINT `opciones_respuesta_ibfk_1` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas` (`pregunta_id`);

--
-- Filtros para la tabla `participantes`
--
ALTER TABLE `participantes`
  ADD CONSTRAINT `participantes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`);

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`encuesta_id`) REFERENCES `encuestas` (`encuesta_id`);

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`participante_id`) REFERENCES `participantes` (`participante_id`),
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas` (`pregunta_id`),
  ADD CONSTRAINT `respuestas_ibfk_3` FOREIGN KEY (`opcion_id`) REFERENCES `opciones_respuesta` (`opcion_id`);

--
-- Filtros para la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD CONSTRAINT `secciones_ibfk_1` FOREIGN KEY (`id_municipio`) REFERENCES `municipios` (`id_municipio`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_municipio`) REFERENCES `municipios` (`id_municipio`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_seccion`) REFERENCES `secciones` (`id_seccion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
