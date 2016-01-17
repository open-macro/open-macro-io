import argcomplete
import argparse
import re
import json
import os

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

	# parameters in model definition
	params = model_json['params_init'].keys() + model_json['params_deep'].keys()

	# parameter svg files
	params_svg = os.listdir(options.model_name + '_params')
	params_svg = [ps.replace('.svg', '') for ps in params_svg]

	missing_params = list(set(params) - set(params_svg))

	# This should really be throwing an error/warning or something
	# TODO: look up the Pythonic way to do this
	if len(missing_params) > 0:
		print 'One of the parameters is missing'

	import code
	code.interact(local=locals())


if __name__ == "__main__":
    main()