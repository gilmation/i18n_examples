USE i18n_table_per_field_trans;

--
-- Data for table locale
--

INSERT INTO locale (name, code) VALUES
('Spanish', 'es'),
('English', 'en'),
('Euskera', 'eu');

--
-- Data for table person
--

INSERT INTO person (age) VALUES
(10),
(35),
(11);

--
-- Data for table action_translation
--

INSERT INTO action_translation (id_person, id_locale, text) VALUES 
(1, 1, 'Estudiar'),
(1, 2, 'Study'),
(2, 1, 'Educar'),
(2, 2, 'Educate'),
(3, 1, 'Estudiar'),
(3, 2, 'Study');

--
-- Data for table role_translation
--

INSERT INTO role_translation (id_person, id_locale, text) VALUES 
(1, 1, 'Alumno'),
(1, 2, 'Student'),
(2, 1, 'Profesor'),
(2, 2, 'Teacher'),
(3, 1, 'Alumno'),
(3, 2, 'Student');
