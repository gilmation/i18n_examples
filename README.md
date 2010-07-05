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
1. [A separate table for each translated field.](#separate) - This is the way to go.
2. [A single table which is used for all translations.](#single) - Not a good idea, provided as a contrast.

## Notes
We are talking here about dynamic user data stored in the database not static presentation data that would normally be controlled by the creation of text file translations which would then be loaded and switched in and out by the application framework or some i18n plugin.  i.e. The functionality available in Struts, Struts2, Rails or Zend.  In some cases framework based solutions exist for this dynamic data but by no means is this available for all languages or frameworks.

In both these examples if a reduction in the number of joins being made to retrieve the values of the multi-lingual columns is desired then the locales table could be removed and the string code for each locale duplicated in the translation table.  This is not recommended, however, because it does not remove the need for some type of administration of available system locales and results in the need for related data to be stored in at least two places (the database, in a config file on disk or in a constants class).

<h1 id="separate">A separate table for each translated field</h1>
Separate tables which are created and used for each field that is to be translated.

<h2 id="separate-desc">Description</h2>

<h2 id="separate-pros-cons">Pros <span class="amp">&amp;</span> Cons</h2>

### When to use it

<h2 id="separate-schema">Database Schema</h2>

![Table per field Translations](./tree/master/table_per_field_trans/table_per_field_trans.jpg "A Table of Translations for every Field")

<h2 id="separate-data">Sample Data</h2>

To be added

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
In this design a single table is used to store all the translations available to the system.

<h2 id="single-pros-cons">Pros <span class="amp">&amp;</span> Cons</h2>

### Pros
This design allows us to minimise duplication of the translations that are present in the system. Since they are all located in the same table, the code that is responsable for managing them can optimise for words or phrases that already exist.  

This is a more "explicit" solution in that it is clear from looking at the table that has multi-language columns which columns that table contains because they physically exist in the definition of that table, although a join will be necessary to see their available translations.

As there are less tables less database maintenance is required.  When a new field requires multi-lingual capabilities there is no need to add a new translation table to the system. 

### Cons
As you can see from the diagram the table that contains the translated fields (in this case *person*) must have a column for each field that is to be translated.  This column is then used to link to one or more rows in the *translation* table (using the *field* column the referenced key).

Since each one of the 

The translation table is likely to become a bottleneck.

Care needs to be taken to allow the system to cater for more than one translation for words or phrases whose meaning changes depending on the context of their use.

### When to use it

<h2 id="single-schema">Database Schema</h2>

![Single Table for all Translations](http://github.com/gilmation/i18n_examples/blob/master/single_table_for_all_trans/single_table_for_all_trans.jpg "Single Table for all Translations")

<h2 id="single-data">Sample Data</h2>

To be added

<h2 id="single-command">Commands</h2>
If you run either of these commands without any arguments it will output a usage statement. 

### Bash
    
    ./run localhost single_table_for_all_trans

### Windows
    
    .\run.ps1 localhost single_table_for_all_trans

- - -
