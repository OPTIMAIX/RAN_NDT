RAN NDT OF A URBAN SCENARIO
2024 - Mobile Communications Research Group - UPC

DESCRIPTION OF THE MAIN SCRIPTS

This RAN NDT simulates a urban scenario where a number of base stations are deployed providing service to different User Equipments (UE). 
The main scripts and functions included in the code are:

- create_scenario.m: This script allows creating a scenario with a given number of buildings, streets, etc. Normally, this only needs to be executed once and it creates a file “ScenarioBuildings.mat” to be used in the different simulations.
- add_BSs.m: This script allows adding a number of BSs in the scenario and computing the propagation losses. This needs to be executed once for each configuration of BSs that we would like to test. It needs the ScenarioBuildings.mat to be previously created and it generates a file “ScenarioBSs.mat”.
- main.m: This is the script that executes the simulation runs specified by config.num_simulations, and generates the results file with the different statistics. Each simulation run corresponds to a different random distribution of the UEs acting as relays selected from the relay database.
- prop_model.m: computation of path loss for different types of propagation models
- LOS_prob.m: Computation of the LOS probability for different propagation models
- shadowing_2D.m: Generates a 2D map of correlated shadowing
- mobility_model_cars.m: Computes the position update for a car that moves through the scenario following the streets
- mobility_model_pedestrian.m: Computes the position update for a pedestrian that moves through the scenario, either following the sidewalks of the streets or the open areas.

EXECUTION PROCEDURE:

Step 1) Create the scenario with the buildings and the trajectories:
- Configure the scenario size and the buildings positions at: create_scenario.m
- Configure the streets for pedestrian and cars and the pedestrian random walk areas at mobility_regions.m
- Execute script:  create_scenario.m   (this already calls mobility_regions script)
The resulting scenario is stored at:   ScenarioBuildings.mat

Step 2) Add the BSs and compute the propagation losses:
- Configure the BS positions and the parameters that impact the prop. model (freq., heights) at file add_BSs.m
- Execute the script add_BSs.m
The resulting scenario with the BSs is stored at: ScenarioBSs.mat

Step 3) Simulation (this requires that the scenario file ‘ScenarioBSs.mat’ is computed before).
- Configure the parameters of the simulation (e.g. Tx powers, noise, mobility model parameters, etc.)
- Execute script main.m 

RESULTS:

The execution of main.m generates the following files:

- Results file (name of the file is specified in "config.output_file_name" variable): Details of the statistics per simulation and in global. Also includes the configuration parameters. 
- map file (name specified in "config.map_BS_file_name" variable): Details of the BSs and maps of SNR_total, speff_total and serving BSs. This file is only generated if no file exists with the same name in the same directory. This allows that, if we are doing simulations just changing the number of UEs, mobility models, etc. this does not need to be resaved every time. If we are doing simulations changing the tx_power, antenna_gains, etc., it is better to give different names to the file to reflect the considered conditions.
