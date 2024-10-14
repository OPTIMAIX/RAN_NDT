RAN NDT OF A URBAN SCENARIO

2024 - Mobile Communications Research Group - UPC

The software included here incorporates different scripts implemented in Matlab that produce different modules of the OPTIMAIX RAN NDT architecture. The correspondence between the service mapping models of the architecture and the different scripts is explained in the following:
- Scenario topology model: The default scenario topology is a urban scenario composed of different streets and multi-floor buildings where a number of base stations that provide service to different UEs can be placed. The scenario topology can be configured and modified in the scripts "create_scenario.m" by specifying the position of buildings, streets, etc. Normally, this only needs to be executed once and it creates a file “ScenarioBuildings.mat” to be used in the subsequent executions of the RAN NDT. 
- gNB model: The positions of the base stations (gNBs) in the scenario is configured in the script "add_BSs.m". Specific parameters of each base station such as the frequency, antenna height or the propagation model are configured here. Then, this script allows adding a number of BSs in the scenario and computing the propagation losses. This needs to be executed once for each configuration of BSs that we would like to test. It needs the ScenarioBuildings.mat to be previously created and it generates a file named by default as “ScenarioBSs.mat”. The rest of parameters of the gNB (e.g. transmitted power, antenna gains, bandwidth, etc.) are configured in the "main.m" script.
- UE model: The parameters of the UE (noise power, antenna gain etc.) are configured in the "main.m" script.
- Propagation model: UMa and UMi path loss models from 3GPP TR 38.901 are supported covering distance-dependent path loss, outdoor-to-indoor propagation losses and 2D spatially correlated shadowing. They are included in the scripts "prop_model.m" and "LOS_prob.m" for computing, respectively, the path loss and the probability of line of sight at a certain distance. The shadowing is computed in the script "shadowing_2D.m".
- Traffic generation model: Traffic generation is modelled at session level, generating sessions following a Poisson arrival process and an exponential duration. The model of session arrivals and finalisations is included in the "main.m" script.
- Mobility model: UEs with different mobility types are included in the scenario, namely, pedestrian UEs which move either following the sidewalks of the streets or through the open areas, vehicular UEs, which move following the streets, and stationary UEs, which remain static either in indoor or outdoor positions. Pedestrian and vehicular mobility is implemented in scripts "mobility_model_pedestrian.m" and "mobility_model_cars.m", respectively.
- Mobility control: As a result of their mobility, a handover algorithm is implemented in which the UEs connect to the best serving base station at each time. This is included in the "main.m" script.
- KPIs reporting: As a result of each execution, the script "main.m" provides different KPIs, including for example, the spectral efficiency observed by the UEs per user type (including average values, 5th and 95th percentiles and Cumulative Distribution Function (CDF)), the outage probability, the number of UEs served by each BS as a function of time or the time that the UEs are connected to a BS (average, 5th and 95th percentiles). These KPIs are provided in the results file whose name is specified in the "config.output_file_name" variable. Different map files including the SNR, spectral efficiency and serving BS per pixel are also provided. The name of the map file is specified in the "config.map_BS_file_name" variable.

EXECUTION PROCEDURE:

Step 1) Create the scenario with the buildings and the trajectories:
- Configure the scenario size and the buildings positions at: create_scenario.m
- Configure the streets for pedestrian and cars and the pedestrian random walk areas at mobility_regions.m
- Execute script:  create_scenario.m  (this already calls mobility_regions script)

The resulting scenario is stored at:   ScenarioBuildings.mat

Step 2) Add the BSs and compute the propagation losses:
- Configure the BS positions and the parameters that impact the prop. model (frequency, heights) at file add_BSs.m
- Execute the script add_BSs.m

The resulting scenario with the BSs is stored at: ScenarioBSs.mat

Step 3) Execution (this requires that the scenario file ‘ScenarioBSs.mat’ is computed before).
- Configure the parameters (e.g. Tx powers, noise, mobility model parameters, etc.)
- Execute script main.m
- Collect the results 
