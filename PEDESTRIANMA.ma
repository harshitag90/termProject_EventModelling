[top]
components : pedestrianevacuation

[pedestrianevacuation]
type : cell
width : 20
height : 20
delay : transport
defaultDelayTime : 100
border : wrapped 
neighbors : pedestrianevacuation(-1,-1) pedestrianevacuation(-1,0) pedestrianevacuation(-1,1) 
neighbors : pedestrianevacuation(0,-1)  pedestrianevacuation(0,0)  pedestrianevacuation(0,1)
neighbors : pedestrianevacuation(1,-1)  pedestrianevacuation(1,0)  pedestrianevacuation(1,1)
%%%% state values %%%%
% 0 - Empty cell
% 1 - cell occupied by an up walker
% 2 - cell occupied by a down walker
% 3 - cell with state 1 has reached a wall and is going left
% 4 - cell with state 2 has reached a wall and is going right
% 5 - wall cell
initialvalue : 0
initialrowvalue :  0      55555555555555555555
initialrowvalue :  1      50000000100000004005
initialrowvalue :  2      50000000000000000005
initialrowvalue :  3      54000000000010000005
initialrowvalue :  4      50000000000000000005
initialrowvalue :  5      50000000000000000005
initialrowvalue :  6      50000000000000000005
initialrowvalue :  7      50000000000000000005
initialrowvalue :  8      50000000000000000035
initialrowvalue :  9      50000000000020000005
initialrowvalue : 10      50000000000012000005
initialrowvalue : 11      50100000000000000005
initialrowvalue : 12      53000000000000000005
initialrowvalue : 13      50000000000000200005
initialrowvalue : 14      50000000000000000005
initialrowvalue : 15      50000012000000000005
initialrowvalue : 16      50000000000000000005
initialrowvalue : 17      50000000000000000005
initialrowvalue : 18      51000000000200003005
initialrowvalue : 19      55555555550555555555
localtransition : pedestrianevacuation-rule

[pedestrianevacuation-rule]
%Pedestrian 1 - Going up
rule : 0 100 {(0,0)=1 and (-1,0)=0 and (1,0)!=5 and (-1,1)!=3}
rule : 1 100 {(0,0)=0 and (1,0)=1 and (0,-1)!=5 and (0,1)!=5 and (1,1)!=5 and (0,1)!=3}

%Pedestrian 1 has reached the top wall. State changes to 3 and going left
rule : 3 0 {(0,0)=1 and (statecount(5)>=1)}

%Pedestrian reached a wall at the top and cell to the left is empty
rule : 0 100 {(0,0)=3 and (0,-1)=0 and (-1,0)=5}

%Pedestrian is in current state 0, its right cell is in state 3 with wall at the top (Top to Left top)
rule : 3 100 {(0,0)=0 and (0,1)=3 and (-1,0)=5}

%Pedestrian has reached a wall to left top (0,-1) , cell below is empty
rule : 0 100 {(0,0)=3 and (1,0)=0 and (0,-1)=5}

%Pedestrian is in current state 0, its up cell is in state 3 with wall to the left top (Left top to Left bottom)
rule : 3 100 {(0,0)=0 and (-1,0)=3 and (1,0)!=4 and (0,-1)=5}

%Pedestrian has reached a wall to the left bottom(1,0), cell to the right is empty 
rule : 0 100 {(0,0)=3 and (0,1)=0 and (1,0)=5}

%Pedestrian is in current state 0, the person to the left is in state 3 with wall to left bottom (Left bottom to right bottom)
rule : 3 100 {(0,0)=0 and (0,-1)=3 and (0,1)!=4 and (1,0)=5}

%Pedestrian has reached a wall to right bottom (0,1) , cell above is empty
rule : 0 100 {(0,0)=3 and (-1,0)=0 and (0,1)=5}

%Pedestrian is in current state 0, the person to the bottom is in state 3 with wall to right bottom (Right bottom to right top)
rule : 3 100 {(0,0)=0 and (1,0)=3 and (0,1)=5}

%Pedestrian 2 - Going down
rule : 0 100 {(0,0)=2 and (1,0)=0 and (-1,0)!=5 and (1,1)!=4}
rule : 2 100 {(0,0)=0 and (-1,0)=2 and (0,1)!=5 and (0,-1)!=5 and (-1,-1)!=5 and (0,1)!=4}

%Pedestrian 1 has reached the bottom wall. State changes to 4 and going right
rule : 4 0 {(0,0)=2 and (statecount(5)>=1)}

% Pedestrian has reached to bottom wall (1,0) and cell to the left is empty
rule : 0 100 {(0,0)=4 and (0,-1)=0 and (1,0)=5}

% Pedestrian is in current state 0 and person the right is in state 4 with wall at the bottom (bottom to left bottom)
rule : 4 100 {(0,0)=0 and (0,1)=4 and (1,0)=5}

%Pedestrian has reached the left bottom wall (0,-1) and cell above is empty
rule : 0 100 {(0,0)=4 and (-1,0)=0 and (0,-1)=5}

%Pedestrian is in state 0 and cell to the bottom is in state 4 with wall at the left bottom (Left bottom to left top)
rule : 4 100 {(0,0)=0 and (1,0)=4 and(-1,0)!=3 and (0,-1)=5}

%Pedestrian has reached the left top wall (-1,0) and cell to the right is empty
rule : 0 100 {(0,0)=4 and (0,1)=0 and (-1,0)=5}

%Pedestrian is in state 0 and the cell to the right is in state 4 with wall the left top (Left top to right top)
rule : 4 100 {(0,0)=0 and (0,-1)=4 and (-1,0)=5}

%Pedestrian has reached the right top and the cell below is empty
rule : 0 100 {(0,0)=4 and (1,0)=0 and (0,1)=5}

%Pedestrian is in current state 0, the top cell is in state 4 with wall at the right top (Right top to right bottom)
rule : 4 100 {(0,0)=0 and (-1,0)=4 and (0,1)=5}

%Prevent collisions in the open area of the cells
%Pedestrian is in current state 2(down) and a cell is in state 1(up), dont change the position
rule : 0 100 {(0,0)=2 and (1,0)=1}
%Pedestrian is in current state 0, the cell to top right is in state 2(down) and either of right and bottom cell is in state 1(up)
rule : 2 100 {(0,0)=0 and (-1,1)=2 and ((0,1)=1 or (1,1)=1)}

%avoid clash in Bottom Right to Bottom Left
rule : 4 100 {(0,0)=3 and (0,1)=4 and (1,0)=5}
rule : 4 100 {(0,0)=0 and (0,-1)=3 and (0,1)=4 and (-1,-1)=0 and (-1,0)!=2 and (1,0)=5}

%New rules are added to handle collisions around the walls
%avoid clash in Bottom Left to Top Left 
rule : 4 100 {(0,0)=3 and (1,0)=4 and (0,-1)=5}
rule : 4 100 {(0,0)=0 and (-1,0)=3 and (1,0)=4 and (0,-1)=5}

%avoid clash in the Top Left to Top Right 
rule : 4 100 {(0,0)=3 and (0,-1)=4 and (-1,0)=5}
rule : 4 100 {(0,0)=0 and (0,1)=3 and (0,-1)=4 and (-1,0)=5}

%avoid clash in the Top Right to Bottom Right
rule : 4 100 {(0,0)=3 and (-1,0)=4 and (0,1)=5}
rule : 4 100 {(0,0)=0 and (1,0)=3 and (-1,0)=4 and (0,1)=5}

% Default - don't move
rule : {(0,0)} 100 {t}