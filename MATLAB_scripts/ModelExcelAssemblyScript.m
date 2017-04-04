%******************* INDIVIDUAL MODEL DATA ASSEMBLY *********************
for k=1:numberOfFiles
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
