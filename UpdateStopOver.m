function StopOver=UpdateStopOver(PopSize,Dimension)
%% Initial population
%Input: 
% popSize: size of superorganism
% dimension: size of artificial organism/one clan
%Output: 
% Initial population
[PopSize,Dimension]=size(PopSize);

for i=1:PopSize
        StopOver(i,:)=randperm(Dimension); %%Donor of searching for the stopover site
end
