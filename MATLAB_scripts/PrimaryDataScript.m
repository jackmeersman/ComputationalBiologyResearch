%********************* PRIMARY DATA TABLE *******************************
Organisms = repmat({''},numberOfFiles,1);
Reactions = zeros(numberOfFiles,1);
Genes = zeros(numberOfFiles,1);
Metabolites = zeros(numberOfFiles,1);

for k=1:35
    Organisms{k} = (BioData{k}.description);
    Genes(k) = numel(BioData{k}.genes);
    Reactions(k) = numel(BioData{k}.rxns);
    Metabolites(k) = numel(BioData{k}.mets);
end

mkdir('ScriptExcelResults');
cd('ScriptExcelResults')
researchData = table(Organisms,Genes,Reactions,Metabolites);
writetable(researchData,'ResearchDataOverview.xlsx');
