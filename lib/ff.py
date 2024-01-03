from flask import Flask,request
from isbntools.app import *
import gspread
from oauth2client.service_account import ServiceAccountCredentials





author_name=''
book_name=''
publisher=''
year=''

app= Flask(__name__)



@app.route('/upload', methods=['POST'])
def getBookDetails():
    json=request.get_json()
    barcodes = json['barcode']
    for barcode in barcodes:
        if(len(barcode) == 13):
            metadata = meta(barcode)
            string=''
            for idx, author in enumerate(metadata['Authors']):
                if idx == len(metadata['Authors']) - 1:
                    string += author
                else:
                    string += author + ','

            author_name=string
            print('author',author_name)
            book_name = metadata['Title']
            publisher = metadata['Publisher']
            year = metadata['Year']
            scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/spreadsheets",
                    "https://www.googleapis.com/auth/drive.file", "https://www.googleapis.com/auth/drive"]
            credentials = ServiceAccountCredentials.from_json_keyfile_name('assets\credentials.json', scope)
            client = gspread.authorize(credentials)

#             spreadsheet = client.open('libdata')

# # Access a specific worksheet (by index or title)
#             worksheet = spreadsheet.get_worksheet(0)  # Change index to access a different worksheet

#             # Get all the data from the worksheet
#             data = worksheet.get_all_records()
#             print('data hoon; ',data)
            # Open the Google Sheets document
            sheet = client.open_by_key('18R1iIEU8BoeWYREOvl879jcQriH8zHFLt9P6FbJ4Sks').sheet1
            # Convert the values to strings explicitly
            barcode_str = str(barcode)
            book_name_str = str(book_name)
            author_name_str = str(author_name)
            publisher_str = str(publisher)
            year_str = str(year)

            # Append the row to the sheet
            sheet.append_row([barcode_str, book_name_str, author_name_str, publisher_str,year_str])

        
      
    
    

if __name__ == '__main__':
    app.run(debug=True, port=5000)






