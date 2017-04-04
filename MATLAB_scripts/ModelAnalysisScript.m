%*********************** MODEL DATA MOD SCRIPT **************************
x = 1;
while x ~= 0
    disp('________________________________')
    disp('1. Flux Balance Analysis');
    disp('2. Geometric Flux Balance Analysis');
    disp('3. Single Gene Deletion Study');
    disp('4. Double Gene Deletion Study');
    disp('5. Flux Variability Analysis');
    disp('6. Metabolic Dead End Detection');
    disp('7. Exit Script');
    disp('--------------------------------')
    prompt = {'Which analysis would you like to run on your data? (1-7):  '};
    x = input(prompt{1});
    
    if x == 1
        FBA_Solutions = cell(numberOfFiles,1);
        for k=1:numberOfFiles
            FBA_Solutions{k} = optimizeCbModel(BioData{k}, 'max');
        end
        disp('Results compiled in MATLAB structure ''FBA_Solutions''.')
    elseif x == 2
        fluxSolutions = cell(numberOfFiles,1);
        for k=1:numberOfFiles
            FVA_Solutions{k} = geometricFBA(BioData{k});
        end
        disp('Results compiled in MATLAB structure ''FBA_Solutions''.')
    elseif x == 3
        for k=1:numberOfFiles
            [grRatio, grRateKO, grRateWT, hasEffect, delRxns,...
                fluxSolution] = singleGeneDeletion(BioData{k}, 'FBA');
            SingleGeneDeletionMatrix(k).BioName = BioData{k}.description...
                (1:(length(BioData{k}.description))-4); %#ok<*SAGROW>
            SingleGeneDeletionMatrix(k).grRatio = grRatio;
            SingleGeneDeletionMatrix(k).grRateKO = grRateKO;
            SingleGeneDeletionMatrix(k).grRateWT = grRateWT;
            SingleGeneDeletionMatrix(k).hasEffect = hasEffect;
            SingleGeneDeletionMatrix(k).delRxns = delRxns;
            SingleGeneDeletionMatrix(k).fluxSolution = fluxSolution;
        end
        disp('Results compiled in MATLAB');
        disp('structure ''SingleGeneDeletionMatrix''.');
    elseif x == 4
        disp('_________________________________________________________');
        disp('WARNING: DOUBLE GENE DELETIONS ARE MEMORY/POWER INTENSIVE');
        disp('AND AUTOANALYSIS OF MULTIPLE MODELS WILL TAKE SEVERAL');
        prompt = {'HOURS. DO YOU WISH TO CONTINUE? (''Y'' or ''N''):  '};
        y = input(prompt{1});
        if (y == 'Y' || y == 'y')
            disp('________________________________________');
            disp('Which method of analysis should be used?');
            prompt = {'| 1. ''FBA'' | 2. ''MOMA'' | 3. ''lMOMA'' |:  '};
            y = {input(prompt{1})};
            for k=1:numberOfFiles
                [grRatioDble, grRateKO, grRateWT] = ...
                    doubleGeneDeletion(BioData{k}, y{1});
                DoubleGeneDeletionMatrix(k).BioName = BioData{k}.description...
                    (1:(length(BioData{k}.description))-4);
                DoubleGeneDeletionMatrix(k).grRatioDble = grRatioDble;
                DoubleGeneDeletionMatrix(k).grRateKO = grRateKO;
                DoubleGeneDeletionMatrix(k).grRateWT = grRateWT;
            end
            disp('Results compiled in MATLAB');
            disp('structure ''DoubleGeneDeletionMatrix''.');
        else
            disp('____________________________________________________');
            disp('Individual dual lethal gene studies can be performed');
            disp('using COBRA''s doubleGeneDeletion() function.');
            disp('----------------------------------------------------');
        end
    elseif x == 5
        for k=1:numberOfFiles
            [minFlux, maxFlux] = fluxVariability(BioData{1}, 100);
            FVA_Matrix(k).minimumFlux = minFlux;
            FVA_Matrix(k).maximumFlux = maxFlux;
        end
        disp('Results compiled in MATLAB structure ''FVA_Matrix''.')
    elseif x == 6
        outputMetabolites = cell(numberOfFiles,1);
        for k=1:numberOfFiles
            outputMetabolites{k} = detectDeadEnds(BioData{k});
        end
        disp('Results compiled in MATLAB structure ''outputMetabolites''.')
    else
        disp('Script closing...');
        x = 0;
    end
end
