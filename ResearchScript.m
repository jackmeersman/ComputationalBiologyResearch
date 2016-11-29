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

mkdir('Script_Results');
cd('Script_Results')
researchData = table(Organisms,Genes,Reactions,Metabolites);
writetable(researchData,'ResearchDataOverview.xlsx');

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

%******************* INDIVIDUAL MODEL DATA ASSEMBLY *********************
prompt = {'Would you like individual spreadsheets to be assembled for'...
               ;'your models? (Type in ''Y'' or ''N'')\n'};
disp(prompt{1});
x = input(prompt{2});

if (strcmp(x,'Y') == 1) || (strcmp(x,'y') == 1)
    for k=1:2
        if (myIsField(BioData{k},'description')==1)
            Organism = BioData{k}.description;
        else Organism = zeros(numel(BioData{k}.description),1);
        end
        
        if (myIsField(BioData{k},'rxns')==1)
            Reactions = BioData{k}.rxns;
        else Reactions = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'mets')==1)
            Metabolites = BioData{k}.mets;
        else Metabolites = zeros(numel(BioData{k}.mets),1);
        end
        
        if (myIsField(BioData{k},'rev')==1)
            ReversibleRxn = BioData{k}.rev;
        else ReversibleRxn = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'lb')==1)
            RxnLowerBound = BioData{k}.lb;
        else RxnLowerBound = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'ub')==1)
            RxnUpperBound = BioData{k}.ub;
        else RxnUpperBound = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'c')==1)
            ObjCoeff = BioData{k}.c;
        else ObjCoeff = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'metCharge')==1)
            MetaboliteCharge = BioData{k}.metCharge;
        else MetaboliteCharge = zeros(numel(BioData{k}.mets),1);
        end
        
        if (myIsField(BioData{k},'rules')==1)
            BooleanRules = BioData{k}.rules;
        else BooleanRules = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'genes')==1)
            Genes = BioData{k}.genes;
        else Genes = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'grRules')==1)
            StringRules = BioData{k}.grRules;
        else StringRules = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'subSystems')==1)
            SubSystem = BioData{k}.subSystems;
        else SubSystem = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'rxnNames')==1)
            ReactionNames = BioData{k}.rxnNames;
        else ReactionNames = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'rxnReferences')==1)
            ReactionRefs = BioData{k}.rxnReferences;
        else ReactionRefs = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'rxnECNumbers')==1)
            ReactionECNumbers = BioData{k}.rxnECNumbers;
        else ReactionECNumbers = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'rxnNotes')==1)
            ReactionNotes = BioData{k}.rxnNotes;
        else ReactionNotes = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'confidenceScores')==1)
            confScore = BioData{k}.confidenceScores;
        else confScore = zeros(numel(BioData{k}.rxns),1);
        end
        
        if (myIsField(BioData{k},'metNames')==1)
            MetaboliteNames = BioData{k}.metNames;
        else MetaboliteNames = zeros(numel(BioData{k}.mets),1);
        end
        
        if (myIsField(BioData{k},'metCHEBIID')==1)
            MetaboliteCHEBI_ID = BioData{k}.metCHEBIID;
        else MetaboliteCHEBI_ID = zeros(numel(BioData{k}.mets),1);
        end
        
        if (myIsField(BioData{k},'metKEGGID')==1)
            MetaboliteKEGG_ID = BioData{k}.metKEGGID;
        else MetaboliteKEGG_ID = zeros(numel(BioData{k}.mets),1);
        end
        
        if (myIsField(BioData{k},'metPubChemID')==1)
            MetabolitePubChemID = BioData{k}.metPubChemID;
        else MetabolitePubChemID = zeros(numel(BioData{k}.mets),1);
        end
        
        if (myIsField(BioData{k},'metInChIString')==1)
            MetaboliteINCHI_String = BioData{k}.metInChIString;
        else MetaboliteINCHI_String = zeros(numel(BioData{k}.mets),1);
        end
        
        name = {BioData{k}.description(1:(length(BioData{k}.description...
                    ))-4)};
        fileName = {strcat(name{1},'.xlsx')};
        
        rxnData = table(Reactions, ReactionNames, ReversibleRxn,...
            RxnLowerBound, RxnUpperBound, ObjCoeff, BooleanRules,...
            StringRules, SubSystem, confScore, ReactionRefs,...
            ReactionECNumbers, ReactionNotes);
        
        metData = table(Metabolites, MetaboliteNames, MetaboliteCharge,...
            MetaboliteCHEBI_ID, MetaboliteKEGG_ID, MetabolitePubChemID,...
            MetaboliteINCHI_String);
        
        geneData = table(Genes);
        
        writetable(rxnData,fileName{1},'Sheet',1);
        writetable(metData,fileName{1},'Sheet',2);
        writetable(geneData,fileName{1},'Sheet',3);
    end
    disp('Spreadsheets assembled in new directory.')
else
    disp('No spreadsheets assembled.');
end
