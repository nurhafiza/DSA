function Chrom=InitPop(PopSize,Dimension)
%% Initial population
%Input: 
% popSize: size of superorganism
% dimension: size of artificial organism/one clan
%Output: 
% Initial population

Chrom=zeros(PopSize, Dimension);
for i=1:PopSize
        Chrom(i,:)=randperm(Dimension); %%Donor of searching for the stopover site
end
