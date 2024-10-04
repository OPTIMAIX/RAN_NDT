%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script creates the scenario (buildings, streets, trajectories)
%
% (c) 2024 - Mobile Communications Research Group - UPC
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
rng(700);

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CONFIGURATION PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Scenario parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scenario_x=700;
scenario_y=700;
pixel_size=1;
sizeX=scenario_x/pixel_size;
sizeY=scenario_y/pixel_size;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Receiver height
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hUT=1.5;
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Characterisation of the buildings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_floors=7; %Note: floor=1 is ground.
floor_height=3.5; %m  Note that the models are valid for hUT<=22.5m. We should take
%this into account when setting floor_height and number of floors.
for flo=1:num_floors  %Note: we cannot use the name "floor" for a variable because there is a Matlab function called floor.
    hUT_total(flo)=hUT+(flo-1)*floor_height;
end

num_buildings=22;  
buildings(1).vertices=[85,40; 45,60; 25,100; 45,140; 85,160; 145,160; 145,40]; %Coordinates in m
buildings(2).vertices=[160,40; 160,160; 280,160; 280,40];
buildings(3).vertices=[295,40; 295,160; 415,160; 415,40];
buildings(4).vertices=[430,40; 430,160; 550,160; 550,40];
buildings(5).vertices=[565,40; 565,160; 685,160; 685,40];

buildings(6).vertices=[295,175; 295,295; 415,295; 415,175];
buildings(7).vertices=[430,175; 430,295; 550,295; 550,175];
buildings(8).vertices=[565,175; 565,295; 685,295; 685,175];

buildings(9).vertices=[295,310; 295,430; 415,430; 415,310];
buildings(10).vertices=[430,310; 430,430; 550,430; 550,310];
buildings(11).vertices=[565,310; 565,430; 685,430; 685,310];

buildings(12).vertices=[25,455; 25,565; 145,565; 145,445];
buildings(13).vertices=[160,445; 160,565; 280,565; 280,445];
buildings(14).vertices=[295,445; 295,565; 415,565; 415,445];
buildings(15).vertices=[430,445; 430,565; 550,565; 550,445];
buildings(16).vertices=[565,445; 565,565; 685,565; 685,445];

buildings(17).vertices=[25,580; 25,700; 145,700; 145,580];
buildings(18).vertices=[160,580; 160,700; 280,700; 280,580];
buildings(19).vertices=[295,580; 295,700; 340,700; 415,680; 415,580];
buildings(20).vertices=[430,580; 430,677; 550,645; 550,580];
buildings(21).vertices=[565,580; 565,642; 685,610; 685,580];

buildings(22).vertices=[640,682; 640,700; 685,700; 685,670];

num_buildings=size(buildings,2);

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COMPUTATIONS            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.- Computation of the positions that are indoor and the map 
% of buildings.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Computing Indoor map.\n');
[map_indoor_points,map_buildings]=find_indoor_points(sizeX,sizeY,pixel_size,buildings);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2.- Create the mobility regions for pedestrians and cars
%and the valid points where to place relays.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Creating Mobility Regions.\n');
mobility_regions

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3.- Save scenario
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('ScenarioBuildings.mat');