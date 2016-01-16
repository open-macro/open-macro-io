#   ___                                              
#   /___\_ __   ___ _ __   /\/\   __ _  ___ _ __ ___  
#  //  // '_ \ / _ \ '_ \ /    \ / _` |/ __| '__/ _ \ 
# / \_//| |_) |  __/ | | / /\/\ \ (_| | (__| | | (_) |
# \___/ | .__/ \___|_| |_\/    \/\__,_|\___|_|  \___/ 
#      |_|                                           

# THIS SCRIPT CAN BE USED TO GENERATE THE NECESSARY CONTENT TO IMPORT
# A MODEL INTO OPEN MACRO. SEE THE README FILE TO SATISFY ALL CONDITIONS
# NECESSARY TO RUN THIS SCRIPT

import os, sys, argparse
import mongothon

env_keys = ['MONGODB_URI','MONGODB_USER', 'MONGODB_PASSWORD']

# Ensure that the following conditions are met
# * Environment keys in env_keys are set
# * Model excel definition is present
# * Landing page is present
# * Octave scripts are present
# * Octave scripts have the correct structure
# * Octave scripts run with default input
def ensure_env():
  assert(all(key in os.environ for key in env_keys))
  return None

# Generate model json to be pushed to mongodb
def xlsx_to_json():
  return None

def main(argv):

  parser = argparse.ArgumentParser()
  # Setup required input arguments
  parser.add_argument('-s', '--octave-script-dir', required=True,
      help='Directory with octave script for model.')
  parser.add_argument('-l', '--landing-html', required=True,
      help='Landing page html for model.')
  parser.add_argument('-i', '--xlsx-in', required=True,
      help='Excel doc defining model and parameters')

  args = parser.parse_args()

  model_xlsx = ensure_env()
  model_json = xlsx_to_json()

if __name__ == "__main__":
  main(sys.argv[1:])

