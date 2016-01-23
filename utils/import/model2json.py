import argcomplete
import argparse
import json
import xlrd

def get_metadata(sheet):
	return dict(zip(sheet.row_values(0, 0, sheet.ncols), 
		sheet.row_values(1, 0, sheet.ncols)))

def get_sheet_info(sheet):
	headers = sheet.row_values(0, 1, sheet.ncols)

	jsons = ['{']
	for r in range(1, sheet.nrows):
		val = sheet.cell_value(r, 0)
		if isinstance(val, float): val = "{:.0f}".format(val)
		jsons.append('"' + val + '":')
		data = sheet.row_values(r, 1, sheet.ncols);
		jsons.append(json.dumps(dict(zip(headers, data))) + ',')
	jsons = ''.join(jsons)[:-1] + '}'

	return json.loads(jsons)

def excel2json(fname):
	
	wb = xlrd.open_workbook(fname)
	sheets = wb.sheets()

	for s in sheets:
		if s.name == 'metadata': 
			model_definition = get_metadata(s)
		else: 
			model_definition[s.name] = get_sheet_info(s)

	# import code
	# code.interact(local=locals())

	return model_definition

# def main():
# 	parser = argparse.ArgumentParser(
# 		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
# 	parser.add_argument(
# 		'-m', '--model_name', dest='model_name',
# 		help="name of model (e.g. rbc, ca, dig")
# 	argcomplete.autocomplete(parser)
# 	options = parser.parse_args()
	
# 	wb = xlrd.open_workbook(options.model_name + '_information.xlsx')
# 	sheets = wb.sheets()

# 	for s in sheets:
# 		if s.name == 'metadata': 
# 			model_definition = get_metadata(s)
# 		else: 
# 			model_definition[s.name] = get_sheet_info(s)

# 	json.dump(model_definition, open(options.model_name + '_information.json','w'))


# if __name__ == "__main__":
#     main()