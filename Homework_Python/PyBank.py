#Reference: RUTJER201809DATA3/03-Python/Classwork/2/Activities/07-Ins_ReadCSV/Solved/read_csv.py
import os
import csv
csvpath = os.path.join('C:/Users/jbenitez/Desktop/RutgersDataScience/Github_Homework', "Homework_Python" , "budget_data.csv")

with open(csvpath, newline='') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    print(csvreader)
    
    csv_header=next(csvreader)
    
    print(f"CSV Header: {csv_header}")

    for row in csvreader:
    
        print(row)
