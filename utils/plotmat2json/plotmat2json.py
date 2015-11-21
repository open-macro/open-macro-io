## utility script to transform a mat file of plot vars to a json file
## TO DO: remove print lines, add CSV functionality

from scipy.io import loadmat
from json import load
from sys import argv
import os

## argv[1] -- simulation ID
simID = argv[1]

print "simulation ID = " + simID
print "current working direcotry = " + os.getcwd()

## move to simulation directory
os.chdir("../../run/simulations/" + simID)
print "moved to sim dir"
print "working dir is now = " + os.getcwd()

TT = 1000

json = ['{']
plot_vars_mat = loadmat('plot_vars.mat')
plot_names = plot_vars_mat['plot_vars'].dtype.names
plot_simul = plot_vars_mat['plot_vars'][0][0]

for name, simul in zip(plot_names, plot_simul):
    json.append('"' + name.strip() + '":')
    json.append('[' + ','.join(['%2f' % jj for jj in simul[0:TT]]) + '],')

with open('plot_vars.json', 'w') as txt_file:
    txt_file.write(''.join(json)[:-1] + '}')
