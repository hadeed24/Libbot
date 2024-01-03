from flask import Flask, jsonify,request
from isbntools.app import*
import pandas as pd
import gspread
import oauth2client






def get_book_metadata(isbn):
    metadata = meta(isbn)
    print(metadata)
    return metadata
    



isbn = '9781784161934'
 


ff = get_book_metadata(isbn)



# def receive_data():
#     barcode = request.form['data']
#     print('Received data from Flutter:', barcode)
#     # Process the data as needed

#     return jsonify({'message': 'Data received successfully'})



#     print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
#     print(barcode)
#     print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

# def get_book_metadata(isbn):
#     metadata = meta(isbn)
#     return metadata

# isbn = "9781612680019"
# book_data = get_book_metadata(isbn)
# print("aaaaaaaaaaaaaaaa")



# print(registry.bibformatters['labels'](book_data))
# print("ffffffffffffffffffffffffffffffffffffffff")
# # convert the data to a pandas 
# book_df = pd.DataFrame(book_data, index=[0])


# df = pd.DataFrame(book_data)
# print(df.at[1, "ISBN"])

# print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")

# # save  to an Excel spreadsheet
# print(book_df)
# # book_df.to_excel("book_metadata.xlsx")

# # Load credentials from JSON key file
# scope = ['https://spreadsheets.google.com/feeds', 'https://www.googleapis.com/auth/drive']
# credentials = ServiceAccountCredentials.from_json_keyfile_name('assets\credentials.json', scope)
# client = gspread.authorize(credentials)

# # Open the Google Sheets document
# sheet = client.open_by_key('18R1iIEU8BoeWYREOvl879jcQriH8zHFLt9P6FbJ4Sks').sheet1

# row_to_append = [barcode,book_name, author_name]

# # function

# async def append(sheet, row_to_append):
#     await sheet.append_row(row_to_append)


# append(row_to_append)


# # Access data
# data = sheet.get_all_records()
# print(data)