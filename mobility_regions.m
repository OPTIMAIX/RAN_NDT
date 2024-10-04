%%%THIS SCRIPT COMPUTES THE MAPS OF THE DIFFERENT MOBILITY REGIONS
%%% It is called by the 'create_scenario.mat' script:

%%%Specifically, the relevant maps are the following ones:
% - map_trajectories_ped: Binary map with the trajectories of pedestrians in the
% strets
% - map_numbers_traject_ped: Map that indicates in each pixel the number of
% trajectory. If it is an intersection between traj n,m, it is encoded as
% 1000*n+m  where n>m
% - map_pedestrian_points: Binary map with the positions where pedestrians
% move with random walk.
% - map_valid_points_pedestrian: Binary map with the positions where
% pedestrians can move (trajectories + random walk areas)
% - list_valid_points_pedestrian: List with the linear indices of the valid
% points for pedestrians.
% - num_valid_points_pedestrian: Number of valid points for pedestrians.
%
% - map_trajectories_cars: Binary map with the trajectories of cars in the
% strets
% - list_valid_points_cars: List with the linear indices of the valid
% points for cars.
%  - num_valid_points_cars: Number of valid points for cars.
% - map_numbers_traject_cars: Map that indicates in each pixel the number of
% trajectory. If it is an intersection between traj n,m, it is encoded as
% 1000*n+m  where n>m
% - map_valid_points_relays: Binary map with the positions where we can
% have a fixed relay (i.e. all points except those in car trajectories)
%
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%PEDESTRIAN TRAJECTORIES: mobility according to direction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trajectories_ped(1).points=[22,1; 22,701]; %Trajectory goes from point in first row to point in second row.
trajectories_ped(1).width=8;  %It is +/- width/2 around the points
trajectories_ped(2).points=[148,1; 148,701]; 
trajectories_ped(2).width=4;  
trajectories_ped(3).points=[159,1; 159,701]; 
trajectories_ped(3).width=4;
trajectories_ped(4).points=[283,1; 283,701]; 
trajectories_ped(4).width=4;
trajectories_ped(5).points=[294,1; 294,701]; 
trajectories_ped(5).width=4;
trajectories_ped(6).points=[418,1; 418,701]; 
trajectories_ped(6).width=4;
trajectories_ped(7).points=[429,1; 429,701]; 
trajectories_ped(7).width=4;
trajectories_ped(8).points=[553,1; 553,701]; 
trajectories_ped(8).width=4;
trajectories_ped(9).points=[564,1; 564,701]; 
trajectories_ped(9).width=4;
trajectories_ped(10).points=[688,1; 688,701]; 
trajectories_ped(10).width=4;
trajectories_ped(11).points=[699,1; 699,701]; 
trajectories_ped(11).width=4;

trajectories_ped(12).points=[1,3; 701,3]; %GranVia - Passeig 1
trajectories_ped(12).width=6;
trajectories_ped(13).points=[1,21; 701,21]; %GranVia - Passeig 2
trajectories_ped(13).width=6;
trajectories_ped(14).points=[1,38; 701,38]; %GranVia - Vorera
trajectories_ped(14).width=4;
trajectories_ped(15).points=[1,162; 701,162];
trajectories_ped(15).width=4;
trajectories_ped(16).points=[1,173; 701,173];
trajectories_ped(16).width=4;
trajectories_ped(17).points=[1,297; 701,297];
trajectories_ped(17).width=4;
trajectories_ped(18).points=[1,308; 701,308];
trajectories_ped(18).width=4;
trajectories_ped(19).points=[1,432; 701,432];
trajectories_ped(19).width=4;
trajectories_ped(20).points=[1,443; 701,443];
trajectories_ped(20).width=4;
trajectories_ped(21).points=[1,567; 701,567];
trajectories_ped(21).width=4;
trajectories_ped(22).points=[1,578; 701,578];
trajectories_ped(22).width=4;

trajectories_ped(23).points=[340,707; 715,607]; %Av. Roma Vorera sud
trajectories_ped(23).width=14;
trajectories_ped(24).points=[340,747; 715,647]; %Av. Roma Vorera centre
trajectories_ped(24).width=10*cos(atan(4/15));
trajectories_ped(25).points=[340,760; 715,660]; %Av. Roma Vorera nord
trajectories_ped(25).width=4*cos(atan(4/15));

num_trajectories_ped=size(trajectories_ped,2);

for n=1:num_trajectories_ped
    trajectories_ped(n).direction=atan2(trajectories_ped(n).points(2,2)-trajectories_ped(n).points(1,2),trajectories_ped(n).points(2,1)-trajectories_ped(n).points(1,1));
end

[map_trajectories_ped,map_numbers_traject_ped] = fill_trajectory_map(sizeX,sizeY,pixel_size,map_indoor_points,trajectories_ped);

%map_buildings_with_traj=map_indoor_points+2*map_trajectories_ped;
%figure; imshow(flip(map_trajectories_ped'),[0,1]);colormap(jet);colorbar;title('Trajectories Pedestrians');
%figure; imshow(flip(map_numbers_traject_ped'),[0,num_trajectories_ped]);colormap(jet);colorbar;title('Trajectories Pedestrians');
%figure; imshow(flip(map_buildings_with_traj'),[0,2]);colormap(jet);colorbar;title('Buildings and Trajectories');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%PEDESTRIAN AREAS: mobility according to random walk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pedestrian_areas(1).vertices=[17,171; 17,434; 285,434; 285,171];
pedestrian_areas(1).vertices=[25,175; 25,430; 280,430; 280,175];
pedestrian_areas(2).vertices=[25,40; 85,40; 45,60; 25,100];
pedestrian_areas(3).vertices=[25,100; 45,140; 85,160; 25,160];
pedestrian_areas(4).vertices=[25,445; 25,455; 145,445];
pedestrian_areas(5).vertices=[572.5,700; 640,700; 640,682];

[map_pedestrian_points,~]=find_indoor_points(sizeX,sizeY,pixel_size,pedestrian_areas);
map_pedestrian_points=map_pedestrian_points.*(1-map_indoor_points); %This to force that all pedestrian points are outdoor.
%figure; imshow(flip(map_pedestrian_points'),[0,1]);colormap(jet);colorbar;title('Pedestrian areas');

%map_buildings_with_traj_and_ped_areas=map_buildings_with_traj+3*map_pedestrian_points;
%figure; imshow(flip(map_buildings_with_traj_and_ped_areas'),[0,3]);colormap(jet);colorbar;title('Buildings,Traject. and pedest. areas');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%CAR TRAJECTORIES: mobility according to direction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


trajectories_cars(1).points=[9,701; 9,1]; %Tarragona -- Trajectory goes from point in first row to point in second row.
trajectories_cars(1).width=16;  %It is +/- width/2 around the points
trajectories_cars(2).points=[153.5,1; 153.5,170.5];  %Llançà
trajectories_cars(2).width=6;
trajectories_cars(3).points=[153.5,434.5; 153.5,701];  %Llançà
trajectories_cars(3).width=6;
trajectories_cars(4).points=[288,701; 288,1]; %Vilamarí
trajectories_cars(4).width=6;
trajectories_cars(5).points=[423.5,1; 423.5,701];  %Entença
trajectories_cars(5).width=6;
trajectories_cars(6).points=[558,701; 558,1];  %Rocafort
trajectories_cars(6).width=6;
trajectories_cars(7).points=[693.5,1; 693.5,701];  %Calabria
trajectories_cars(7).width=6;

trajectories_cars(8).points=[1,12; 701,12];   %Gran Via Central
trajectories_cars(8).width=12;    
trajectories_cars(9).points=[701,30.5; 1,30.5];   %Gran Via Lateral
trajectories_cars(9).width=12;
trajectories_cars(10).points=[701,168; 1,168]; %Diputacio 
trajectories_cars(10).width=6;
trajectories_cars(11).points=[288.5,302.5; 701,302.5]; %Consell de cent
trajectories_cars(11).width=7;
trajectories_cars(12).points=[701,438; 1,438];  %Arago
trajectories_cars(12).width=6;
trajectories_cars(13).points=[1,572.5; 701,572.5];  %Valencia
trajectories_cars(13).width=7;

trajectories_cars(14).points=[715,627; 340,727]; %Av. Roma Main
trajectories_cars(14).width=30*cos(atan(4/15));
trajectories_cars(15).points=[340,755; 715,655]; %Av. Roma Lateral Nord
trajectories_cars(15).width=6*cos(atan(4/15));

num_trajectories_cars=size(trajectories_cars,2);

for n=1:num_trajectories_cars
    trajectories_cars(n).direction=atan2(trajectories_cars(n).points(2,2)-trajectories_cars(n).points(1,2),trajectories_cars(n).points(2,1)-trajectories_cars(n).points(1,1));
end

[map_trajectories_cars,map_numbers_traject_cars] = fill_trajectory_map(sizeX,sizeY,pixel_size,map_indoor_points,trajectories_cars);
map_trajectories_cars=map_trajectories_cars.*(1-map_pedestrian_points);  %To avoid that cars go through pedestrian areas
map_numbers_traject_cars=map_numbers_traject_cars.*(1-map_pedestrian_points);


%To get the list of valid points for placing a car, consider only those
%that are the center of a square with 9 pixels equal to 1 in
%map_trajectories_cars (in this way we avoid cars going very close to
%pedestrian)
map_valid_points_initial_position_cars=zeros(sizeX,sizeY);
for i=1:sizeX
    for j=1:sizeY
        if map_trajectories_cars(i,j)==1
           num_valid_pixels=0;
           for iaux=max(1,i-1):min(sizeX,i+1)
                for jaux=max(1,j-1):min(sizeY,j+1)
                    if map_trajectories_cars(iaux,jaux)==1
                        num_valid_pixels=num_valid_pixels+1;
                    end
                end
           end
           if num_valid_pixels>=9
               map_valid_points_initial_position_cars(i,j)=1;
           end
        end
    end
end
%list_valid_points_cars=find(map_trajectories_cars==1);
list_valid_points_cars=find(map_valid_points_initial_position_cars==1);
num_valid_points_cars=size(list_valid_points_cars,1);


%map_buildings_with_traj_cars=map_indoor_points+2*map_trajectories_cars;
%figure; imshow(flip(map_trajectories_cars'),[0,1]);colormap(jet);colorbar;title('Trajectories Cars');
%figure; imshow(flip(map_numbers_traject_cars'),[0,num_trajectories_cars]);colormap(jet);colorbar;title('Trajectories Cars');
%figure; imshow(flip(map_buildings_with_traj_cars'),[0,2]);colormap(jet);colorbar;title('Buildings and Trajectories Cars');

%map_buildings_with_traj_ped_areas_and_cars=map_buildings_with_traj+3*map_pedestrian_points+4*map_trajectories_cars;
%figure; imshow(flip(map_buildings_with_traj_ped_areas_and_cars'),[0,4]);colormap(jet);colorbar;title('Buildings, Trajectories Ped and Cars');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%MAPS OF VALID POINTS FOR MOBILITY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Map of positions where the pedestrians can move: the trajectories and the
%random walk areas (no need to exclude the indoor points because they are
%not included in these maps).
map_valid_points_pedestrian=min(1,map_trajectories_ped+map_pedestrian_points);
list_valid_points_pedestrian=find(map_valid_points_pedestrian==1);
num_valid_points_pedestrian=size(list_valid_points_pedestrian,1);

%Map of positions where the relays can be: all the points (indoor/outdoor)
%except the trajectories of the cars.
map_valid_points_relays=ones(sizeX,sizeY).*(1-map_trajectories_cars);


%figure; imshow(flip(map_valid_points_pedestrian'),[0,1]);colormap(jet);colorbar;title('Map Valid Points Pedestrians');
%figure; imshow(flip(map_valid_points_relays'),[0,1]);colormap(jet);colorbar;title('Map Valid Points Relays');


