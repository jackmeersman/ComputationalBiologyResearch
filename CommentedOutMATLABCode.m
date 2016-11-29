% Won't work because not all fields are numbers
%         if (myIsField(BioData{k},'rxns')==1)
%             Reactions = zeroes(numel(BioData{k}.rxns),1);
%             for i=1:numel(BioData{k}.rxns)
%                 Reactions(i) = BioData{k}.rxns(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'mets')==1)
%             Metabolites = zeroes(numel(BioData{k}.mets),1);
%             for i=1:numel(BioData{k}.mets)
%                 Metabolites(i) = BioData{k}.mets(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'rev')==1)
%             ReversibleRxn = zeroes(numel(BioData{k}.rev),1);
%             for i=1:numel(BioData{k}.rev)
%                 ReversibleRxn(i) = BioData{k}.rev(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'lb')==1)
%             RxnLowerBound = zeroes(numel(BioData{k}.lb),1);
%             for i=1:numel(BioData{k}.lb)
%                 RxnLowerBound(i) = BioData{k}.lb(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'ub')==1)
%             RxnUpperBound = zeroes(numel(BioData{k}.ub),1);
%             for i=1:numel(BioData{k}.ub)
%                 RxnUpperBound(i) = BioData{k}.ub(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'c')==1)
%             ObjCoeff = zeroes(numel(BioData{k}.c),1);
%             for i=1:numel(BioData{k}.c)
%                 ObjCoeff(i) = BioData{k}.c(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metCharge')==1)
%             MetaboliteCharge = zeroes(numel(BioData{k}.metCharge),1);
%             for i=1:numel(BioData{k}.metCharge)
%                 MetaboliteCharge(i) = BioData{k}.metCharge(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'rules')==1)
%             BooleanRules = zeroes(numel(BioData{k}.rules),1);
%             for i=1:numel(BioData{k}.rules)
%                 BooleanRules(i) = BioData{k}.rules(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'genes')==1)
%             Genes = zeroes(numel(BioData{k}.genes),1);
%             for i=1:numel(BioData{k}.genes)
%                 Genes(i) = BioData{k}.genes(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'grRules')==1)
%             StringRules = zeroes(numel(BioData{k}.grRules),1);
%             for i=1:numel(BioData{k}.grRules)
%                 StringRules(i) = BioData{k}.grRules(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'subSystems')==1)
%             SubSystem = zeroes(numel(BioData{k}.subSystems),1);
%             for i=1:numel(BioData{k}.subSystems)
%                 SubSystem(i) = BioData{k}.subSystems(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'rxnNames')==1)
%             ReactionNames = zeroes(numel(BioData{k}.rxnNames),1);
%             for i=1:numel(BioData{k}.rxnNames)
%                 ReactionNames(i) = BioData{k}.rxnNames(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'rxnReferences')==1)
%             ReactionRefs = zeroes(numel(BioData{k}.rxnReferences),1);
%             for i=1:numel(BioData{k}.rxnReferences)
%                 ReactionRefs(i) = BioData{k}.rxnReferences(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'rxnECNumbers')==1)
%             ReactionECNumbers = zeroes(numel(BioData{k}.rxnECNumbers),1);
%             for i=1:numel(BioData{k}.rxnECNumbers)
%                 ReactionECNumbers(i) = BioData{k}.rxnECNumbers(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'rxnNotes')==1)
%             ReactionNotes = zeroes(numel(BioData{k}.rxnNotes),1);
%             for i=1:numel(BioData{k}.rxnNotes)
%                 ReactionNotes(i) = BioData{k}.rxnNotes(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'confidenceScores')==1)
%             confScore = zeroes(numel(BioData{k}.confidenceScores),1);
%             for i=1:numel(BioData{k}.confidenceScores)
%                 confScore(i) = BioData{k}.confidenceScores(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metNames')==1)
%             MetaboliteNames = zeroes(numel(BioData{k}.metNames),1);
%             for i=1:numel(BioData{k}.metNames)
%                 MetaboliteNames(i) = BioData{k}.metNames(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metChEBIID')==1)
%             MetaboliteCHEBI_ID = zeroes(numel(BioData{k}.metChEBIID),1);
%             for i=1:numel(BioData{k}.metChEBIID)
%                 MetaboliteCHEBI_ID(i) = BioData{k}.metChEBIID(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metCHEBIID')==1)
%             MetaboliteCHEBI_ID = zeroes(numel(BioData{k}.metCHEBIID),1);
%             for i=1:numel(BioData{k}.metCHEBIID)
%                 MetaboliteCHEBI_ID(i) = BioData{k}.metCHEBIID(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metKeggID')==1)
%             MetaboliteKEGG_ID = zeroes(numel(BioData{k}.metKeggID),1);
%             for i=1:numel(BioData{k}.metKeggID)
%                 MetaboliteKEGG_ID(i) = BioData{k}.metKeggID(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metKEGGID')==1)
%             MetaboliteKEGG_ID = zeroes(numel(BioData{k}.metKEGGID),1);
%             for i=1:numel(BioData{k}.metKEGGID)
%                 MetaboliteKEGG_ID(i) = BioData{k}.metKEGGID(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metPubChemID')==1)
%             MetabolitePubChemID = zeroes(numel(BioData{k}.metPubChemID),1);
%             for i=1:numel(BioData{k}.metPubChemID)
%                 MetabolitePubChemID(i) = BioData{k}.metPubChemID(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metInchiString')==1)
%             MetaboliteINCHI_String =...
%                 zeroes(numel(BioData{k}.metInchiString),1);
%             for i=1:numel(BioData{k}.metInchiString)
%                 MetaboliteINCHI_String(i) = BioData{k}.metInchiString(i);
%             end
%         end
%         
%         if (myIsField(BioData{k},'metInChIString')==1)
%             MetaboliteINCHI_String =...
%                 zeroes(numel(BioData{k}.metInChIString),1);
%             for i=1:numel(BioData{k}.metInChIString)
%                 MetaboliteINCHI_String(i) = BioData{k}.metInChIString(i);
%             end
%         end