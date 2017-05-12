PopSize=10;  %size of superorganism
MaxGen=10;   %epoch/total generation/iteration
CompRun=10;
p1=0.3*rand;
p2=0.3*rand;

fileID=fopen('DataAnalysis.txt','w');
IDfile=fopen('Results.txt','w');
TimeFile=fopen('ElapsedTime.txt','w');

ScoringMatrix=csvread('x60189_4.csv');
Dimension=size(ScoringMatrix,1);   %size of artificial-organism/one clan


for i=1:CompRun
IniTime=tic;
fprintf('\nNo of Run %d\n',i);
fprintf(fileID,'-------------------------------------------------------');
fprintf(fileID,'\nNo of Run %d\n',i);
fprintf(fileID,'-----------------------------------------------------\n');
%% Initial population (generate artificial-organism/solution)
Chrom=InitPop(PopSize,Dimension);
ChromList=Chrom;

%% Initial artificial-organism (solution) with scoring value (fitness function)
InitialSolution=OutputSolution(Chrom(1,:))
InitialScoringValue=CalculateScore(ScoringMatrix,Chrom(1,:))

%% Evaluation of scoring value for each artificial-organism (solution) - fitness function: maximum score
ObjV=CalculateScore(ScoringMatrix,Chrom);
MaxObjV=max(ObjV);

%% Optimization
for Gen=1:MaxGen
%    fprintf('\nIteration: %d\n',Gen);
    Donor=Chrom(randperm(PopSize),:);
    map=zeros(PopSize,Dimension);
    if rand<rand
        if rand<p1
            % Random-mutation #1st strategy
            fprintf(fileID,'Random-mutation #1st strategy'); 
%            disp('Random-mutation #1st strategy');
            for i=1:PopSize
                map(i,:)=rand(1,Dimension)<rand;
            end
        else
            % Differential-mutation strategy
             fprintf(fileID,'Differential-mutation strategy');
%            disp('Differential-mutation strategy');
            for i=1:PopSize
                map(i,randi(Dimension))=1;
            end
        end
    else
        % Random-mutation #2nd strategy
         fprintf(fileID,'Random-mutation #2st strategy');
%         disp('Random-mutation #2st strategy');
        for i=1:PopSize
            map(i,randi(Dimension,1,ceil(p2*Dimension)))=1;
        end
    end
            
    Scale=4*randg;
    StopOver=PopSize+(Scale.*map).*(Donor-PopSize);
    StopOver=UpdateStopOver(StopOver,Dimension);
    StopOverObjV=CalculateScore(ScoringMatrix,StopOver);
    MaxStopOverObjV=max(StopOverObjV);
    ind=MaxStopOverObjV>MaxObjV;
    MaxObjV(ind)=MaxStopOverObjV(ind);
    Chrom(ind,:)=StopOver(ind,:);

    [globalmaximum,indexbest]=max(MaxObjV);
    globalmaximizer=Chrom(indexbest,:);

    globalmax(Gen)= globalmaximum;           % save globalminimum value in each iteration
    iteration(Gen)= Gen;                     % save number of iteration
   
  % export results
    assignin('base','globalmaximum',globalmaximum);
    assignin('base','globalmaximizer',globalmaximizer);
 %   fprintf('%5.0f   ---> %5d\n',Gen,globalmaximum);
    fprintf(fileID,'%5d   ---> %5d   ---> %5d   ---> %5d\n',Gen,MaxStopOverObjV,MaxObjV,globalmaximum); 
end
plot(iteration,globalmax);
xlabel('Iteration');
ylabel('Best Score');
hold on;
grid on;
OverallGlobalMax=max(globalmaximum);
fprintf(fileID,'\nOverallGlobalMax  ---> %5d\n',OverallGlobalMax);
fprintf(IDfile,'%5d\n',OverallGlobalMax); 
FinTime=toc(IniTime);
fprintf(TimeFile,'%5d\n',FinTime);
end
fclose(fileID);
fclose(IDfile);
fclose(TimeFile);
IDfile=fopen('Results.txt','r');
data=cell2mat(textscan(IDfile,'%5d'));
data=dlmread('results.txt')
TimeFile=fopen('ElapsedTime.txt','r');
ElapsedTime=cell2mat(textscan(TimeFile,'%5d'));
ElapsedTime=dlmread('elapsedtime.txt')
highestScore=max(data);
lowestScore=min(data);
avg=mean(data);
stdDev=std(data);
totalTime=sum(ElapsedTime);
avgElapsedTime=mean(ElapsedTime);
disp(['Best Overlap Score = ' num2str(highestScore)]);
disp(['Worst Overlap Score = ' num2str(lowestScore)]);
disp(['Average Overlap Score = ' num2str(avg)]);
disp(['Standard Deviation = ' num2str(stdDev)]);
disp(['Average Elapsed Time = ' num2str(avgElapsedTime)]);
fclose(IDfile); 
fclose(TimeFile);