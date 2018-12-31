import pandas
df = pandas.read_csv("CSVFiles/test2.csv")
df.to_sql("test2table", db_connection, flavor='mysql', if_exists='append')