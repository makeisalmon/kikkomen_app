# Setup Instructions

Install MySQL Workbench 8.0 CE.

Install MySQL Server Community with 'Typical' configuration.

Use MySQL Configurator to set root password to "password" and apply.

in MySQL workbench, connect to the server and open the Data Import UI from the Navigator pane. Under Import Options, choose "Import from Self-Contained File" then choose the "sushi.sql" file located in the repository root folder.

Run the testqueries.sql to verify that the database is working properly. Be sure to set the ‘sushi’ database as the default before running.

Run the application by running “Release\kikkomen_app.exe”.
