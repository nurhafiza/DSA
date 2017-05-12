function Score=CalculateScore(ScoringMatrix,Chrom)
%% Calculate scoring value for each chromosome (artificial-organism/solution)
% Input: scoring value for each fragment involved
% Chrom individual tracks
[row,col]=size(ScoringMatrix);
PopSize=size(Chrom,1);
Score=zeros(PopSize,1);
for i=1:PopSize
    chromosome=Chrom(i,:);
    i1=chromosome(1:end-1);
    i2=chromosome(2:end);
    Score(i,1)=sum(ScoringMatrix((i1-1)*col+i2));
end