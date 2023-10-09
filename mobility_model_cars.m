function [new_pos,new_traj,stop_tx] = mobility_model_cars(pos,traj,speed,time_step,prob_change_inters,sizeX,sizeY,pixel_size,map_valid_points,trajectories,map_trajectories)
%MOBILITY_MODEL_PEDESTRIAN:  Executes the movement of one pedestrian UE in
%one time_step. Input parameters:
%   -pos: Initial position: vector with the x,y component in m 
%   -traj: index of the current trajectory (this directly gives the
%   direction, because each trajectory has a single direction)
%   -speed: in m/s
%   -time_step: duration of the time step in s.
%   - prob_change_inters: probability of changing direction when reaching
%   an intersection in a street.
%   - sizeX,sizeY,pixel_size: parameters of the maps
%   - map_valid_points: Map with the valid points for a pedestrian (marked 
%   - trajectories: List of trajectories characterized by points, widths and
%   directions
%   - map_trajectories: Map with the trajectory associated to each pixel.
%
%   OUTPUTS:
%   -new_pos: New position
%   -new_traj: Index of the new trajectory
%   -stop_tx: 1 if the vehicle has left the scenario, so that it is
%   removed, 0 otherwise.

%Since the speed can be high and in one time_step it can move more than one
%pixel, we do several updates in each step, so that we cover all the
%pixels. This will give appropriate granularity to identify the
%intersections.
num_updates=ceil(time_step*speed/pixel_size);
time_step_mod=time_step/num_updates;

direction=trajectories(traj).direction;
current_traj=traj;
current_position=pos;
stop_tx=0; %Initialisation.

pos_index=ceil(pos/pixel_size);
if map_valid_points(pos_index(1),pos_index(2))==0
    fprintf('\nERROR: The vehicle is in an invalid position!!');
    %Do nothing
    
else
    %Movement in a street.
    direction_change_allowed=1; %Flag that will be set to 0 once there is a change in direction (this is to allow only one single direction change in the step)
    for n=1:num_updates
        new_pos=current_position+speed*time_step_mod*[cos(direction),sin(direction)];
        new_pos_index=ceil(new_pos/pixel_size);

        if new_pos_index(1)<1 || new_pos_index(1)>sizeX || new_pos_index(2)<1 || new_pos_index(2)>sizeY || map_valid_points(new_pos_index(1),new_pos_index(2))==0
            %The car exceeds the limits of the scenario or enters an invalid
            %zone. It stops the tx, because the car cannot go in the
            %opposite direction and keeps the last good position.
            stop_tx=1;
            break %To get out of the for loop.
        else
            %Check if it is an intersection
            current_position=new_pos;
            traj_number=map_trajectories(new_pos_index(1),new_pos_index(2));
            if traj_number>1000
                %It is an intersection
                if direction_change_allowed==1
                    %Conditions to change direction:
                    %1) The next position update in the current trajectory
                    %will lead the car out of the scenario. If so, the
                    %change is forced
                    %2) Otherwise, with probability prob_change_inters.
                    
                    %Estimate the next position with the current
                    %trajectory:
                    new_pos_aux=current_position+speed*time_step_mod*[cos(direction),sin(direction)];
                    new_pos_aux_index=ceil(new_pos_aux/pixel_size);
                    if new_pos_aux_index(1)<1 || new_pos_aux_index(1)>sizeX || new_pos_aux_index(2)<1 || new_pos_aux_index(2)>sizeY || map_valid_points(new_pos_aux_index(1),new_pos_aux_index(2))==0
                        %Forced change:
                        prob_change_dir=1;
                    else
                        prob_change_dir=prob_change_inters;
                    end
                    if rand<prob_change_dir
                        traj1=mod(traj_number,1000);
                        traj2=(traj_number-traj1)/1000;
                        
                        %Choose the other trajectory.
                        if current_traj==traj1
                            current_traj=traj2;
                        else
                            current_traj=traj1;
                        end
                        direction=trajectories(current_traj).direction;
                        direction_change_allowed=0;
                    end
                end
            end
        end
    end        
end
new_pos=current_position;
new_traj=current_traj;    
 
end

