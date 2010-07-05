# i18n_examples 
Example database configurations for i18n of dynamic user data.

For each example this document contains

* Description
* Discussion of the Pros <span class="amp">&amp;</span> Cons of this choice 
* When you would be likely to want to use it. 
* A diagram of the database schema
* A diagram with some sample data 
* Commands to run in order to install and populate the sample database

For each example there is a sub-directory which contains SQL scripts which

* Create of a sample schema
* Populate this schema with some example data

## Examples
1. [A separate table for each translated field.](#separate) - This is the way to go for most frameworks and ORMs
2. [A single table which is used for all translations.](#single) - More complicated, your code has to do more work 

## Notes
We are talking here about dynamic user data stored in the database not static presentation data that would normally be controlled by the creation of text file translations which would then be loaded and switched in and out by the application framework or some i18n plugin.  i.e. The functionality available in Struts, Struts2, Rails or Zend.  In some cases framework based solutions exist for this dynamic data but by no means is this available for all languages or frameworks.

In both these examples if a reduction in the number of joins being made to retrieve the values of the multi-lingual columns is desired then the locales table could be removed and the string code for each locale duplicated in the translation table.  This is not recommended, however, because it does not remove the need for some type of administration of available system locales and results in the need for related data to be stored in at least two places (the database, in a config file on disk or in a constants class).

<h1 id="separate">A separate table for each translated field</h1>
Separate tables which are created and used for each field that is to be translated.

<h2 id="separate-desc">Description</h2>
This is the route that most frameworks take. In general this is the way that I would always tend to do it because it fits best with the way that most ORMs (Object Relational Mapper) work. You simply define a one to many releationship from the main (entity) table to the table that represents each translated field. It's vital that you use some standard naming conventions so that it's easy to see from their names which tables are related. In the example schema given here for example it would be better to start the names of the two translation tables with the name of the "main" table, in this case Person. 

<h2 id="separate-pros-cons">Pros <span class="amp">&amp;</span> Cons</h2>

### Pros
Best fit with frameworks and ORMs.

Allows you to use the database (primary and foreign keys) to guarantee the integrity of your data, instead of having to program the logic yourself.

The fact that the translation tables all have the same structure means that, if you follow some standard naming conventions, you should be able to use the same logic to process all of the translated fields.

You can use a "on delete cascade" type relationship to guarantee that no unused translation exist. 

### Cons
If there are lots of translated fields then you are going to have a lot of very similar tables.

Translation information is spread throughout the system so it's not easy to get a global view of the translations that exist, for example, it's not easy to create a single command that can show you which fields have not been translated to a particular language.

### When to use it
When you are going to use an ORM (Hibernate, Propel, Doctrine, Active Record or something similar). When the fact that the translation data will be spread across a lot of tables is not a big inconvenience. Translations are going to be edited as part of the entity represented by the separate table rather than in some sort of centralised translation tool which is used to process all the translations that exist in the system at the same time.

<h2 id="separate-schema">Database Schema</h2>

table_per_field_trans/table_per_field_trans.jpg

<h2 id="separate-data">Sample Data</h2>

table_per_field_trans/example_data.jpg

<h2 id="separate-command">Commands</h2>
If you run either of these commands without any arguments it will output a usage statement. 

### Bash

    ./run localhost table_per_field_trans

### Windows

    .\run.ps1 localhost table_per_field_trans

---------------------

<h1 id="single">Single table for all translations</h1>
A single table which is used for all translations for all tables

<h2 id="single-desc">Description</h2>
In this design a single table is used to store all the translations available to the system which would mean that the system could quite easily have some sort of centralised translation administration tool. As you will be able to see from the example schema and data, related translations are grouped by the use of a common value in the field column. An improvement to this design would be to add a translation_group table between the table whose data is being translated and the translation table (which contains the actual translations), as you will be able to see from the diagram (example_data_trans_group.jpg) this would enable us to use the primary key of the translation_group table in both the action column of the table Person and the field (we could rename this column to transaction_group) column of the translation table. This would let us use the database to validate the integrity of these relationships and avoid the need to manually manage the id of each group of fields. In both examples we could use a unique index on translation.field and translation.id_locale to make sure that a field could only be translated once per locale. 

<h2 id="single-pros-cons">Pros <span class="amp">&amp;</span> Cons</h2>

### Pros
This design allows us to minimise duplication of the translations that are present in the system. Since they are all located in the same table, the code that is responsable for managing them can optimise for words or phrases that already exist.  

This is a more "explicit" solution in that it is clear from looking at the table that has multi-language columns which columns that table contains because they physically exist in the definition of that table, although a join will still be necessary to see their translations.

As there are less tables less database maintenance is required.  When a new field requires multi-lingual capabilities there is no need to add a new translation table to the system.

### Cons
As you can see from the diagram the table that contains the translated fields (in this case *person*) must have a column for each field that is to be translated.  This column is then used to link to one or more rows in the *translation* table (using the *field* column the referenced key). Since neither of these fields is a primary key we cannot enforce the integrity of relationships at the database level - we have to manage them in our code.

The translation management mechanism needs to be informed of each new field so that it can manage it. 

As the design stands it would need a sequence or something similar to generate the new ids for each tranlation group

The translation table is likely to become a bottleneck.

Care needs to be taken to allow the system to cater for more than one translation for words or phrases whose meaning changes depending on the context of their use.

### When to use it
When you want to have a centralised translations repository that you can use to manage all the tranlations in the system.

<h2 id="single-schema">Database Schema</h2>

single_table_for_all_trans/single_table_for_all_trans.jpg

<h2 id="single-data">Sample Data</h2>

single_table_for_all_trans/example_data.jpg

<h2 id="single-command">Commands</h2>
If you run either of these commands without any arguments it will output a usage statement. 

### Bash
    
    ./run localhost single_table_for_all_trans

### Windows
    
    .\run.ps1 localhost single_table_for_all_trans

- - -
