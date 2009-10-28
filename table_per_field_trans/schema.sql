DROP DATABASE IF EXISTS i18n_2;
CREATE DATABASE i18n_2 DEFAULT CHARACTER SET latin1;

-- --------------------------------------------------------

USE i18n_2;

--
-- Table structure for table 'locale'
--

CREATE TABLE IF NOT EXISTS locale (
  id_locale int(11) NOT NULL auto_increment,
  name varchar(30) NOT NULL,
  code varchar(6) NOT NULL,
  PRIMARY KEY  (id_locale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'person'
--

CREATE TABLE IF NOT EXISTS person (
  id_person int(11) NOT NULL auto_increment,
  age int(11) default NULL,
  PRIMARY KEY  (id_person)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'action_translation'
--

CREATE TABLE IF NOT EXISTS action_translation (
  id_action_translation int(11) NOT NULL auto_increment,
  id_person int(11) NOT NULL,
  id_locale int(11) NOT NULL,
  text varchar(100) NOT NULL,
  PRIMARY KEY  (id_action_translation),
  UNIQUE KEY at_person_locale (id_person, id_locale),
  FOREIGN KEY at_fk_person(id_person) REFERENCES person(id_person),
  FOREIGN KEY at_fk_locale(id_locale) REFERENCES locale(id_locale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'role_translation'
--

CREATE TABLE IF NOT EXISTS role_translation (
  id_role_translation int(11) NOT NULL auto_increment,
  id_person int(11) NOT NULL,
  id_locale int(11) NOT NULL,
  text varchar(100) NOT NULL,
  PRIMARY KEY  (id_role_translation),
  UNIQUE KEY at_person_locale (id_person, id_locale),
  FOREIGN KEY at_fk_person(id_person) REFERENCES person(id_person),
  FOREIGN KEY at_fk_locale(id_locale) REFERENCES locale(id_locale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

