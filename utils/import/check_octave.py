import argcomplete
import argparse
import re
import json

def parse_exovars(exovars):
	exovars = [ev.replace('_neg', '') for ev in exovars]
	exovars = [ev[:-1] for ev in exovars]
	return exovars

def check_octave(model_name, model_json):

	# model name should be the same as directory where it is stored
	with open(model_name + '/' + model_name + '_main.mod', 'r') as f:
		dynare = f.read().replace('\n', '')

	endovars = re.search('var([^;]*);', dynare).group(1).split()
	exovars = parse_exovars(re.search('varexo([^;]*);', dynare).group(1).split())
	params = re.search('parameters([^;]*);', dynare).group(1).split()

	missing_endovars = list(set(endovars) - set(model_json['endovars'].keys()))
	missing_exovars = list(set(exovars) - set(model_json['exovars'].keys()))
	missing_params = list(set(params) - set(model_json['params_init'].keys() + 
		model_json['params_deep'].keys()))

	assert len(missing_endovars) == 0, 'One of the endogenous variables is missing: %s' % missing_endovars
	assert len(missing_exovars) == 0, 'One of the exogenous variables is missing: %s' % missing_exovars
	assert len(missing_params) == 0, 'One of the parameters is missing: %s' % missing_params

# def main():
# 	parser = argparse.ArgumentParser(
# 		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
# 	parser.add_argument(
# 		'-m', '--model_name', dest='model_name',
# 		help="name of model (e.g. rbc, ca, dig")
# 	argcomplete.autocomplete(parser)
# 	options = parser.parse_args()

# 	with open(options.model_name + '_information.json') as f:    
# 		model_json = json.load(f)
	
# 	with open(options.model_name + '/' + options.model_name + '_main.mod', 'r') as f:
# 		dynare = f.read().replace('\n', '')

# 	endovars = re.search('var([^;]*);', dynare).group(1).split()
# 	exovars = parse_exovars(re.search('varexo([^;]*);', dynare).group(1).split())
# 	params = re.search('parameters([^;]*);', dynare).group(1).split()

# 	missing_endovars = list(set(endovars) - set(model_json['endovars'].keys()))
# 	missing_exovars = list(set(exovars) - set(model_json['exovars'].keys()))
# 	missing_params = list(set(params) - set(model_json['params_init'].keys() + 
# 		model_json['params_deep'].keys()))

# 	# This should really be throwing an error/warning or something
# 	# TODO: look up the Pythonic way to do this
# 	if len(missing_endovars) > 0:
# 		print 'One of the endogenous variables is missing'
# 	if len(missing_exovars) > 0:
# 		print 'One of the exogenous variables is missing'
# 	if len(missing_params) > 0:
# 		print 'One of the parameters is missing'


# 	import code
# 	code.interact(local=locals())


# if __name__ == "__main__":
#     main()