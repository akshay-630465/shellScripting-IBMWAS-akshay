#!/usr/bin/env python3

db=input("Enter db name")
providerType=input("Enter provider type (DB2 Universal JDBC Driver Provider/Oracle JDBC Driver: ")
impl=input("Implementation Type \n Connection pool data source \n XA data source: ")
name=input("Enter name for provider: ")
path=input("path for the drivers: ")

AdminTask.createJDBCProvider('[-scope Cell=swasCell02 -databaseType "${db}" -providerType \"${providerType}\" -implementationType \"${implType}\" -name \"${name}\" -classpath \"${driver}\"]')

