import pandas as pd
import numpy
from sqlalchemy import create_engine

# read CSV file
#column_names = ['Name','Age', 'height', 'dob']

#df = pd.read_csv('/CSVFiles/test2.csv', header = None, names = column_names)
#print(df)

df = pd.read_csv('/CSVFiles/test2.csv', header = 0)
print(df)

engine = create_engine('mysql://root:@localhost/test')
with engine.connect() as conn, conn.begin():
    df.to_sql('csv_table', conn, if_exists='append', index=False)