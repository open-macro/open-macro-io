#   ___                                              
#   /___\_ __   ___ _ __   /\/\   __ _  ___ _ __ ___  
#  //  // '_ \ / _ \ '_ \ /    \ / _` |/ __| '__/ _ \ 
# / \_//| |_) |  __/ | | / /\/\ \ (_| | (__| | | (_) |
# \___/ | .__/ \___|_| |_\/    \/\__,_|\___|_|  \___/ 
#      |_|                                           

# THIS SCRIPT CAN BE USED TO GENERATE THE NECESSARY CONTENT TO IMPORT
# A MODEL INTO OPEN MACRO. SEE THE README FILE TO SATISFY ALL CONDITIONS
# NECESSARY TO RUN THIS SCRIPT

import os, sys, argparse, shutil, xlrd, json, re
from pymongo import MongoClient

MONGODB_URI_KEY = 'MONGODB_URI'
MONGODB_USER_KEY = 'MONGODB_USER'
MONGODB_PASSWORD_KEY = 'MONGODB_PASSWORD'
env_keys = [MONGODB_URI_KEY, MONGODB_USER_KEY, MONGODB_PASSWORD_KEY]

# Verify that all mongodb env variables are set
# Setup MongoDB connection and get the model collection
def get_model_collection():
  assert(all(key in os.environ for key in env_keys))
  uri = os.environ[MONGODB_URI_KEY]
  user = os.environ[MONGODB_USER_KEY]
  password = os.environ[MONGODB_PASSWORD_KEY]
  client = MongoClient(uri)
  db = client.get_default_database()
  db.authenticate(user, password)
  return db['models']

# Convert a rigidly defined Excel file into a json object with model data
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

# Helper function to get metadata out of Excel model definition
def get_metadata(sheet):
  return dict(zip(sheet.row_values(0, 0, sheet.ncols), 
    sheet.row_values(1, 0, sheet.ncols)))

# Helper function to get non-metadata out of Excel model definition
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

# Verify that all parameters in the model json file have
# corresponding SVG files
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

# Verify that vars in octave script (endo vars, exo vars, params) 
# match what is listed in the model json
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

# Helper function for parsing exo var names from Dynare code
def parse_exovars(exovars):
  exovars = [ev.replace('_neg', '') for ev in exovars]
  exovars = [ev[:-1] for ev in exovars]
  return exovars

def main():

  # setup argparse
  parser = argparse.ArgumentParser()
  parser.add_argument('-m', '--model-name', required=True,
      help='Name of model (same as directory with octave script).')
  parser.add_argument('-l', '--landing-html', required=True,
      help='Landing page html for model.')
  parser.add_argument('-i', '--xlsx-in', required=True,
      help='Excel doc defining model and parameters')
  args = parser.parse_args()

  # parse the xlsx to get the model json that 
  # follows the schema defined in mongodb 
  print 'Creating model.json from ' + args.xlsx_in + '.'
  model_json = excel2json(args.xlsx_in)
  
  # copy landing page html to landing_pages directory
  model_short_name = model_json['short_name']
  dst = '../landing_pages/' + model_short_name + '_landing.html'
  print 'Copying ' + args.landing_html + ' to ' + dst + '.'
  shutil.copy(args.landing_html, dst)

  # verify the octave script and copy into run
  octave_script_dir = args.model_name
  print 'Verifying octave script structure.'
  check_octave(args.model_name, model_json)
  dst = '../../run/definitions/' + model_short_name
  print 'Copying ' + octave_script_dir + ' to ' + dst + '.'
  shutil.copytree(octave_script_dir, dst)

  # upload model_json to mongodb
  model_collection = get_model_collection()
  print 'Uploading generated json to mongodb.'
  print model_collection.insert_one(model_json)

  print 'Success!'
  
if __name__ == "__main__":
  main()

