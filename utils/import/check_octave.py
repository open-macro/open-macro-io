import argcomplete
import argparse
import re
import json

def parse_exovars(exovars):
	exovars = [ev.replace('_neg', '') for ev in exovars]
	exovars = [ev[:-1] for ev in exovars]
	return exovars

def main():
	parser = argparse.ArgumentParser(
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument(
		'-m', '--model_name', dest='model_name',
		help="name of model (e.g. rbc, ca, dig")
	argcomplete.autocomplete(parser)
	options = parser.parse_args()

	with open(options.model_name + '_information.json') as f:    
		model_json = json.load(f)
	
	with open(options.model_name + '/' + options.model_name + '_main.mod', 'r') as f:
		dynare = f.read().replace('\n', '')

	endovars = re.search('var([^;]*);', dynare).group(1).split()
	exovars = parse_exovars(re.search('varexo([^;]*);', dynare).group(1).split())
	params_all = re.search('parameters([^;]*);', dynare).group(1).split()

	missing_endovars = list(set(endovars) - set(model_json['endovars'].keys()))
	missing_exovars = list(set(exovars) - set(model_json['exovars'].keys()))
	
	# This should really be throwing an error/warning or something
	# TODO: look up the Pythonic way to do this
	if len(missing_endovars) > 0:
		print 'One of the endogenous variables is missing'
	if len(missing_exovars) > 0:
		print 'One fo the exogenous variables is missing'

	# TODO: look for missing parameters as well

	import code
	code.interact(local=locals())


if __name__ == "__main__":
    main()