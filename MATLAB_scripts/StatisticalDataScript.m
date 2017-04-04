%********************* STATISTICAL DATA TABLE ***************************
Field = {'Genes';'Reactions';'Metabolites'};
Minimum = zeros(3,1); Median = zeros(3,1); Maximum = zeros(3,1);
Mean = zeros(3,1); Standard_Dev = zeros(3,1);

Minimum(1) = min(Genes); Minimum(2) = min(Reactions);
Minimum(3) = min(Metabolites);

Median(1) = median(Genes); Median(2) = median(Reactions);
Median(3) = median(Metabolites);

Maximum(1) = max(Genes); Maximum(2) = max(Reactions);
Maximum(3) = max(Metabolites);

Mean(1) = mean(Genes); Mean(2) = mean(Reactions);
Mean(3) = mean(Metabolites);

Standard_Dev(1) = std(Genes); Standard_Dev(2) = std(Reactions);
Standard_Dev(3) = std(Metabolites);

statsData = table(Field,Minimum,Median,Maximum,Mean,Standard_Dev);

writetable(statsData,'ModelStats.xlsx');
