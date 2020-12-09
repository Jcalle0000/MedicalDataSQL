# MedicalDataSQL
Normalized tables from an input file that has information about a customer's health data

Project Date (Started):November 27, 2020

Since im working on MAC and are working through docker
- I had to move the files to docker's container to be able to load the files rather 
than from directly loading the files from my computer.

Sucessfully loaded 10,000 rows of data.

Refernce for Formatting 
https://docs.microsoft.com/en-us/sql/t-sql/statements/bulk-insert-transact-sql?view=sql-server-ver15#interoperability

Reference for copying the excel file to docker's container
https://dba.stackexchange.com/questions/241082/macos-docker-cannot-bulk-load-the-file-path-does-not-exist-or-you-dont-have

Checking your docker container and checking which one is running
docker container ls
  my docker container was: 85e987ffbc87
  
<img src="dockerContainer.png">

Checking your docker containers file 
docker exec -t -i mycontainer /bin/bash

<img src="filesInContainer.png">

@Disease referes to the column name
Stored Procedures
1. countFunction2 @DiseaseInput @DiseaseCount
Takes the name of the disease as an Input
and then outputs the count of customers with that disease
2. returnCustomer @Disease
Executes a list of customers with a certain disease
3. MostCommonDisease
a. uses CountFunction2 to iterate through the column keeping 
track of the highestCount
b.  returning the list of customers
 with the returnCustomer procedure.
c. Also prints out the disease with its count.
