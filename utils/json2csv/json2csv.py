## take a JSON file of results and turn it into a CSV file

from json import load

json_data = open('plot_vars.json')
data = load(json_data)
json_data.close()

T = len(data[data.keys()[0]])

f = open('plot_vars.csv','w')
f.write('period,' + ','.join(map(str, range(0, T))) + '\n')
for key in data.keys():
    f.write(str(key) + ', ' + str(data[key])[1:-1] + '\n')    
f.close()
