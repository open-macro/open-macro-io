## model-demo
Get a macro model up and running on a fresh EC2 instance

## Setup
Set up the environment:

```sh
sudo apt-get install -y git-core
sudo apt-get install -y octave
sudo apt-get install -y dynare
git clone https://github.com/wclark3/model-demo.git
```

Alternatively, run a script that does this automatically, plus loads some of my custom configurations for bash and Emacs:
```sh
cd $HOME
sudo apt-get install -y git-core
git clone https://github.com/wclark3/model-demo.git
./model-demo/setup.sh   
```

## Run the model
The main script that runs the model is called ``run_model.m`` (duh). It will call a bunch of other scripts to handle different parts of the simulation.
```sh
octave /model-demo/run_model.m   
```
If the simulation runs successfully, the last bit of output should read:
```sh
The rank condition is verified.

-----------------------------------------------------
MODEL SIMULATION:

Largest absolute residual at iteration 1:      5.000

Largest absolute residual at iteration 2:      0.458

Largest absolute residual at iteration 3:      0.002

Largest absolute residual at iteration 4:      0.000

Simulation concluded successfully after 4 iterations.
Total time of simulation        :     18.953
Convergency obtained.
```

## User inputs
There are two places where user inputs (from the web interface) will go into the model: ``set_params.m`` and ``shocks.mod``. 

The ``set_params.m`` inputs are fairly straightforward. The user gives some values in a text box and those have to make their way somehow into the m-file.

The ``shocks.mod`` inputs are less straightforward. Shocks are basically time series that the user specifies, and there are two ways for this to work. The first is that the user literally specifies 30 individual values corresponding to periods ``t=1, 2, 3, ..., 30``. The second is to specify a constant value ``X`` from period ``T1`` to period ``T2``. In each case, positive values mush be separated from negative values and put into ``shocks.mod`` as separate series of all POSITIVE values. Then the negative values are subtracted from their corresponding variables and the positive values are just added to theirs.

## Outputs

The main script will create a mat-file called ``plot_vars.mat`` that stores the time series to be returned to the web interface. Each is 1000 periods long, but only 30 periods need to go to the browser (note: maybe cut this down in Octave). Somehow this mat-file needs to get into a JSON format -- maybe use Python? Numpy + SciPy can read mat files and Python has JSON reading/writing libraries. In any case, Octave is probably not the best tool for this task.