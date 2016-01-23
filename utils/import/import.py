#   ___                                              
#   /___\_ __   ___ _ __   /\/\   __ _  ___ _ __ ___  
#  //  // '_ \ / _ \ '_ \ /    \ / _` |/ __| '__/ _ \ 
# / \_//| |_) |  __/ | | / /\/\ \ (_| | (__| | | (_) |
# \___/ | .__/ \___|_| |_\/    \/\__,_|\___|_|  \___/ 
#      |_|                                           

# THIS SCRIPT CAN BE USED TO GENERATE THE NECESSARY CONTENT TO IMPORT
# A MODEL INTO OPEN MACRO. SEE THE README FILE TO SATISFY ALL CONDITIONS
# NECESSARY TO RUN THIS SCRIPT

import os, sys, argparse, shutil
from model2json import excel2json
from check_octave import check_octave
from check_svg import check_svg
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

# Verifies Octave script 
# * Octave scripts are present
# * Octave scripts have the correct structure
# * Octave scripts run with default input
# def verify_octave_script(octave_script_dir):
#   print 'Octave script directory: ' + octave_script_dir

# Generate model json to be pushed to mongodb
# def xlsx_to_json(xlsx):
#   return {'short_name' : 'test'}

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

