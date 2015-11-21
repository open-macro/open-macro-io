import xlrd
import json
import os

def sheet_to_json(sheet):
    """ Converts elements of an Excel worksheet into a json string.

    A worksheet that looks like this:
    | endovar | description           | units | <-- header row
    | p       | aggregate price index | index |
    Gets converted to this:
    "p":{"units": "index", "description": "aggregate price index"}

    Args: 
        sheet: A worksheet object from the xlrd module.

    Returns:
        A json string with data from the Excel worksheet.
    """
    
    headers = sheet.row_values(0, 1, sheet.ncols)
    
    jsons = ['{']
    for r in range(1, sheet.nrows):
        val = sheet.cell_value(r, 0)
        if isinstance(val, float): val = "{:.0f}".format(val)
        jsons.append('"' + val + '":')
        data = sheet.row_values(r, 1, sheet.ncols);
        jsons.append(json.dumps(dict(zip(headers, data))) + ',')

    return "".join(jsons)[:-1] + '}'

def wkbk_to_json(wkbk):
    """ Converts an Excel workbook into a json string.

    Each sheet in the workbook becomes its own sub-json

    Args:
        wkbk - name of an Excel workbook (e.g. 'file.xlsx')

    Returns:
        Formatted json of Excel workbook contents
    """

    model_name = wkbk[:-5]

    wb = xlrd.open_workbook(wkbk)
    sheets = wb.sheets()

    jsons = ['{']
    for sheet in sheets:
        # hacky way to deal with metadata sheet 
        # (has a slightly different format)
        if sheet.name == 'metadata':
            jsons.append(sheet_to_json(sheet)[1:-1] + ',')
        else:
            jsons.append('"' + sheet.name + '":' 
                            + sheet_to_json(sheet) + ',')
            
            with open(model_name + '.json', 'w') as txt_file:
                # hacky way to pretty print the json file
                txt_file.write( 
                    json.dumps(json.loads(''.join(jsons)[:-1] + '}'), 
                               indent=4, sort_keys=True) ) 


for file in os.listdir(os.getcwd()):
    if file.endswith('.xlsx'):
        wkbk_to_json(file)
