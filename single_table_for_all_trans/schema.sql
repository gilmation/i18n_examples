DROP DATABASE IF EXISTS i18n_single_table_for_all_trans;

CREATE DATABASE i18n_single_table_for_all_trans DEFAULT CHARACTER SET latin1;

-- --------------------------------------------------------

USE i18n_single_table_for_all_trans;

-- --------------------------------------------------------

--
-- Table structure for table 'locale'
--

CREATE TABLE IF NOT EXISTS locale (
  id_locale int(11) NOT NULL auto_increment,
  name varchar(30) NOT NULL,
  code varchar(6) NOT NULL,
  PRIMARY KEY (id_locale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'translation'
--

CREATE TABLE IF NOT EXISTS translation (
  id_translation int(11) NOT NULL auto_increment,
  field int(11) NOT NULL,
  id_locale int(11) NOT NULL,
  text varchar(100) NOT NULL,
  PRIMARY KEY (id_translation),
  UNIQUE KEY t_field_locale (field, id_locale),
  FOREIGN KEY t_fk_locale(id_locale) REFERENCES locale(id_locale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'person'
--

CREATE TABLE IF NOT EXISTS person (
  id_person int(11) NOT NULL auto_increment,
  age int(11) default NULL,
  action int(11) NOT NULL,
  role int(11) NOT NULL,
  PRIMARY KEY (id_person),
  FOREIGN KEY person_fk_action(action) REFERENCES translation(field),
  FOREIGN KEY person_fk_role(role) REFERENCES translation(field)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

