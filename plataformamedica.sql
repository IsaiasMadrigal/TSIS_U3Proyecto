--
-- Base de datos: `plataformamedica`
--
CREATE DATABASE IF NOT EXISTS `plataformamedica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `plataformamedica`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`id`, `nombre_usuario`, `contrasena`, `correo_electronico`, `fecha_registro`) VALUES
(1, 'usuario1', '123', 'usuario1@ejemplo.com', '2024-12-03 18:56:30'),
(2, 'usuario2', 'abc', 'usuario2@ejemplo.com', '2024-12-03 18:56:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compatibilidadmedicamentos`
--

CREATE TABLE `compatibilidadmedicamentos` (
  `id` int(11) NOT NULL,
  `medicamento_principal` varchar(100) NOT NULL,
  `medicamento_compatible` varchar(100) NOT NULL,
  `tipo_compatibilidad` varchar(100) DEFAULT NULL,
  `comentarios` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compatibilidadmedicamentos`
--

INSERT INTO `compatibilidadmedicamentos` (`id`, `medicamento_principal`, `medicamento_compatible`, `tipo_compatibilidad`, `comentarios`) VALUES
(1, 'Tamoxifeno', 'Letrozol', 'Complementario', 'Ambos medicamentos son útiles en el tratamiento hormonal del cáncer de mama.'),
(2, 'Cisplatino', 'Erlotinib', 'Secuencial', 'Erlotinib puede ser administrado después de Cisplatino en ciertos tratamientos.'),
(3, 'Fluorouracilo', 'Oxaliplatino', 'Sinérgico', 'Combinación común para el tratamiento de cáncer colorrectal.'),
(4, 'Paclitaxel', 'Bevacizumab', 'Sinérgico', 'Paclitaxel mejora los efectos de Bevacizumab en terapias avanzadas.'),
(5, 'Gemcitabina', 'Doxorrubicina', 'Secuencial', 'La administración secuencial puede ser efectiva en terapias paliativas.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_medicamento` varchar(100) DEFAULT NULL,
  `ingrediente_activo` varchar(150) DEFAULT NULL,
  `tipo_cancer_nombre` varchar(100) DEFAULT NULL,
  `laboratorio` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`id`, `nombre`, `tipo_medicamento`, `ingrediente_activo`, `tipo_cancer_nombre`, `laboratorio`, `imagen`, `precio`) VALUES
(1, 'Tamoxifeno', 'Antiestrógeno', 'Tamoxifeno', 'Cáncer de Mama', 'PharmaCorp', 'imagenes/tamoxifeno.jpg', 50.00),
(2, 'Cisplatino', 'Quimioterapia', 'Cisplatino', 'Cáncer de Pulmón', 'MedLife', 'imagenes/cisplatino.jpg', 120.00),
(3, 'Erlotinib', 'Inhibidor de Tirosina Quinasa', 'Erlotinib', 'Cáncer de Pulmón', 'GenPharma', 'imagenes/erlotinib.jpg', 180.00),
(4, 'Trastuzumab', 'Anticuerpo Monoclonal', 'Trastuzumab', 'Cáncer de Mama', 'OncoBiotech', 'imagenes/trastuzumab.jpg', 250.00),
(5, 'Fluorouracilo', 'Antimetabolito', '5-FU', 'Cáncer de Colon', 'ChemoCare', 'imagenes/fluorouracilo.jpg', 80.00),
(6, 'Doxorrubicina', 'Antraciclina', 'Doxorrubicina', 'Cáncer de Hígado', 'OncoGen', 'imagenes/doxorrubicina.jpg', 200.00),
(7, 'Paclitaxel', 'Taxano', 'Paclitaxel', 'Cáncer de Ovario', 'PharmaCorp', 'imagenes/paclitaxel.jpg', 220.00),
(8, 'Bevacizumab', 'Anticuerpo Monoclonal', 'Bevacizumab', 'Cáncer de Colon', 'BioTechLab', 'imagenes/bevacizumab.jpg', 300.00),
(9, 'Gemcitabina', 'Antimetabolito', 'Gemcitabina', 'Cáncer de Páncreas', 'MedLife', 'imagenes/gemcitabina.jpg', 150.00),
(10, 'Imatinib', 'Inhibidor de Tirosina Quinasa', 'Imatinib', 'Cáncer de Sangre (Leucemia)', 'GenPharma', 'imagenes/imatinib.jpg', 500.00),
(11, 'Letrozol', 'Inhibidor de Aromatasa', 'Letrozol', 'Cáncer de Mama', 'OncoBiotech', 'imagenes/letrozol.jpg', 60.00),
(12, 'Sorafenib', 'Multiquinasa', 'Sorafenib', 'Cáncer de Hígado', 'ChemoCare', 'imagenes/sorafenib.jpg', 220.00),
(13, 'Irinotecán', 'Inhibidor de Topoisomerasa', 'Irinotecán', 'Cáncer de Colon', 'PharmaCorp', 'imagenes/irinotecan.jpg', 130.00),
(14, 'Pembrolizumab', 'Inmunoterapia', 'Pembrolizumab', 'Cáncer de Piel', 'OncoGen', 'imagenes/pembrolizumab.jpg', 400.00),
(15, 'Capecitabina', 'Antimetabolito', 'Capecitabina', 'Cáncer de Colon', 'BioTechLab', 'imagenes/capecitabina.jpg', 100.00),
(16, 'Oxaliplatino', 'Quimioterapia', 'Oxaliplatino', 'Cáncer de Colon', 'GenPharma', 'imagenes/oxaliplatino.jpg', 140.00),
(17, 'Abiraterona', 'Antiandrógeno', 'Abiraterona', 'Cáncer de Próstata', 'OncoBiotech', 'imagenes/abiraterona.jpg', 280.00),
(18, 'Vemurafenib', 'Inhibidor de BRAF', 'Vemurafenib', 'Cáncer de Piel', 'MedLife', 'imagenes/vemurafenib.jpg', 350.00),
(19, 'Rituximab', 'Anticuerpo Monoclonal', 'Rituximab', 'Cáncer de Sangre (Leucemia)', 'ChemoCare', 'imagenes/rituximab.jpg', 450.00),
(20, 'Enzalutamida', 'Antiandrógeno', 'Enzalutamida', 'Cáncer de Próstata', 'PharmaCorp', 'imagenes/enzalutamida.jpg', 300.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposcancer`
--

CREATE TABLE `tiposcancer` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `sintomas` text DEFAULT NULL,
  `imagen` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tiposcancer`
--

INSERT INTO `tiposcancer` (`id`, `nombre`, `descripcion`, `sintomas`, `imagen`) VALUES
(1, 'Cáncer de Mama', 'Cáncer que se forma en las células de los senos.', 'Bultos en el seno, cambios en el tamaño o forma, secreción inusual.', 'cmama'),
(2, 'Cáncer de Pulmón', 'Cáncer que afecta los pulmones, asociado con el tabaquismo.', 'Tos persistente, dificultad para respirar, dolor en el pecho.', 'cpulmon'),
(3, 'Cáncer de Piel', 'Cáncer que comienza en las células de la piel.', 'Lunares irregulares, cambios en la piel, llagas que no sanan.', 'cpiel'),
(4, 'Cáncer de Próstata', 'Cáncer que afecta la glándula prostática en hombres.', 'Dificultad para orinar, sangre en la orina, dolor óseo.', 'cprostata'),
(5, 'Cáncer de Colon', 'Cáncer que afecta el colon o el recto.', 'Cambio en los hábitos intestinales, sangrado rectal, pérdida de peso inexplicada.', 'ccolon'),
(6, 'Cáncer de Hígado', 'Cáncer que se origina en el hígado.', 'Dolor abdominal, ictericia, fatiga.', 'chigado'),
(7, 'Cáncer de Estómago', 'Cáncer que afecta el estómago.', 'Indigestión persistente, pérdida de apetito, vómitos.', 'cestomago'),
(8, 'Cáncer de Ovario', 'Cáncer que afecta los ovarios.', 'Dolor abdominal, hinchazón, fatiga.', 'covario'),
(9, 'Cáncer de Páncreas', 'Cáncer que comienza en el páncreas.', 'Dolor abdominal, pérdida de peso, piel amarilla.', 'cpancreas'),
(10, 'Cáncer de Sangre (Leucemia)', 'Cáncer que afecta la sangre y la médula ósea.', 'Fatiga, infecciones frecuentes, sangrado o hematomas.', 'leucemia');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compatibilidadmedicamentos`
--
ALTER TABLE `compatibilidadmedicamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medicamento_principal` (`medicamento_principal`),
  ADD KEY `medicamento_compatible` (`medicamento_compatible`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `tipo_cancer_nombre` (`tipo_cancer_nombre`);

--
-- Indices de la tabla `tiposcancer`
--
ALTER TABLE `tiposcancer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administradores`
--
ALTER TABLE `administradores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `compatibilidadmedicamentos`
--
ALTER TABLE `compatibilidadmedicamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `tiposcancer`
--
ALTER TABLE `tiposcancer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compatibilidadmedicamentos`
--
ALTER TABLE `compatibilidadmedicamentos`
  ADD CONSTRAINT `compatibilidadmedicamentos_ibfk_1` FOREIGN KEY (`medicamento_principal`) REFERENCES `medicamentos` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `compatibilidadmedicamentos_ibfk_2` FOREIGN KEY (`medicamento_compatible`) REFERENCES `medicamentos` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD CONSTRAINT `medicamentos_ibfk_1` FOREIGN KEY (`tipo_cancer_nombre`) REFERENCES `tiposcancer` (`nombre`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;