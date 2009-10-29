Use i18n_single_table_for_all_trans;

--
-- Data for table locale
--

INSERT INTO locale (name, code) VALUES
('Spanish', 'es'),
('English', 'en'),
('Euskera', 'eu');

--
-- Data for table translation
--

INSERT INTO translation (field, id_locale, text) VALUES
(1, 1, 'Estudiar'),
(1, 2, 'Study'),
(2, 1, 'Alumno'),
(2, 2, 'Student'),
(3, 1, 'Educar'),
(3, 2, 'Educate'),
(4, 1, 'Profesor'),
(4, 2, 'Teacher');

--
-- Data for table person
--

INSERT INTO person (age, action, role) VALUES
(10, 1, 2),
(35, 3, 4),
(11, 1, 2);
