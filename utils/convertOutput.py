from scipy.io import loadmat
from json import load
from sys import argv
import os

#######################################
## 1 -- convert mat file to a JSON file
#######################################

## argv[1] -- simulation ID
simID = argv[1]

## debug
print "simulation ID = " + simID
print "current working direcotry = " + os.getcwd()

## move to simulation directory
os.chdir("../run/simulations/" + simID)

## debug
print "moved to sim dir"
print "working dir is now = " + os.getcwd()

TT = 40

json = ['{']
plot_vars_mat = loadmat('plot_vars.mat')
plot_names = plot_vars_mat['plot_vars'].dtype.names
plot_simul = plot_vars_mat['plot_vars'][0][0]

for name, simul in zip(plot_names, plot_simul):
    json.append('"' + name.strip() + '":')
    json.append('[' + ','.join(['%2f' % jj for jj in simul[0:TT]]) + '],')

## write the actual file
with open('plot_vars.json', 'w') as txt_file:
    txt_file.write(''.join(json)[:-1] + '}')


#######################################
## 2 -- convert that JSON to a CSV file
#######################################

# pull JSON data into python dict
json_data = open('plot_vars.json')
data = load(json_data)
json_data.close()

T = len(data[data.keys()[0]])

f = open('plot_vars.csv','w')
f.write('period,' + ','.join(map(str, range(0, T))) + '\n')
for key in data.keys():
    f.write(str(key) + ', ' + str(data[key])[1:-1] + '\n')    
f.close()
