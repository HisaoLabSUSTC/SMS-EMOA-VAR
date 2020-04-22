function Population = Reduce(Population,ref)
% Delete one solution from the population

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Identify the solutions in the last front
    PopObj = Population.objs;
    a = 0;     
    [N,M]     = size(PopObj);
    PopObj1 = PopObj+a*(sqrt(sum(PopObj.^2,2))*ones(1,M)/sqrt(M)-PopObj);
    
    %alpha is the stretching parameter
    alpha = 1;
    W = ones(1,M);
    
    FrontNo    = NDSort(PopObj1,inf);
    LastFront = find(FrontNo==max(FrontNo));
    PopObj = PopObj(LastFront,:);
    [N,M]     = size(PopObj);
    PopObj = PopObj+alpha*(PopObj-PopObj*W'/M*W);
   
    %% Calculate the contribution of hypervolume of each solution   
    deltaS = CalHVC(PopObj,ref,N);
    
    %% Delete the worst solution from the last front
    [~,worst] = min(deltaS);
    Population(LastFront(worst)) = [];
end