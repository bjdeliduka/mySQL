# mySQL
some time saving stuff I've tossed together that relates to mySql servers and databases

dump_database.sh  - Dump all tables in a mySql database as individual TAB delimited files with column headers.

As luck would have it I had a customer who wanted all the tables in a drupal website dumped to files they could import into excel.  I'm unsure what made them think this is what they wanted to do and my efforts to encourage them to use other means to access / migrate the data were not well received.

proposed additions to dump_database.sh  
- enhance in-script documentation
- add support for command line provided userid (removing necessity of having root access to the sql server and a .my.cnf with the password specified)
