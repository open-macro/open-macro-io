import argcomplete
import argparse
import re
import json
import os

def check_svg(model_name, model_json):

	# parameters in model definition
	params = model_json['params_init'].keys() + model_json['params_deep'].keys()

	# parameter svg files
	params_svg = os.listdir(model_name + '_params')
	params_svg = [ps.replace('.svg', '') for ps in params_svg]

	missing_params = list(set(params) - set(params_svg))

	# This should really be throwing an error/warning or something
	# TODO: look up the Pythonic way to do this
	assert len(missing_params) > 0, 'One of the parameters is missing'