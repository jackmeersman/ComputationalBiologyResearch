"""
Author: John T. Meersman
Date Published: Wednesday, April 26th, 2017
The University of Georgia
Computational Systems Biology Department
Description: This Python script serves to load 1 or more SBML biological
models into memory and parse them for readable statistical data. The user
is then able to run a variety of tests (FBA, FVA, gene deletion, etc.) on
the entire directory of models.
"""

import cobra
import cobra.test
import csv
import glob
import io
import os
import pandas
import time
import xlsxwriter
import xlwt
from statistics import mean, median, stdev

# Loading models into memory sector
print("\nInitializing...")
print("\nAccessing SBML (.xml) files from package directory...\n")

#Finds .xml files and creates a list of SBML filenames to be read
model_list = glob.glob("**/*.xml")

bio_data = [] #Empty list bio_data to be filled below
for m in model_list:
    if m.endswith(".xml"): #'endswith' error exception handling
        bio_data.append(cobra.io.sbml3.read_sbml_model(m)) 
        print("Added model <"+m+"> to bio_data array.")
print("\nFinished loading biological models.\n")

titles = ["Organisms", "Reactions", "Genes", "Metabolites"]
organisms = []
reactions = []
genes = []
metabolites = []

# Individual model and group statistics sector
print("\nDo you wish to produce basic model values?")
print("If so, enter 1 to continue. Otherwise, enter 0.")
choice = input("--> ")
if int(choice)==1:
    print("Printing basic model values...")
    for m in bio_data: #appending the model data to the arrays
        organisms.append(m.id)
        reactions.append(len(m.reactions))
        genes.append(len(m.genes))
        metabolites.append(len(m.metabolites))

    to_csv = [titles, organisms, reactions, genes, metabolites]
    with open("Model_Stats.csv", "w") as f: #writing the data to a csv
        writer = csv.writer(f)
        writer.writerows(to_csv)
    print("Model statistics written to \'Model_Stats.csv\'.")

    print("Generating model group statistics")
    titles = ["Genes", "Reactions", "Metabolites"]
    minimums = [min(genes), min(reactions), min(metabolites)]
    medians = [median(genes), median(reactions), median(metabolites)]
    maximums = [max(genes), max(reactions), max(metabolites)]
    means = [mean(genes), mean(reactions), mean(metabolites)]
    standard_deviations = [stdev(genes), stdev(reactions), stdev(metabolites)]

    to_csv = [titles, minimums, medians, maximums, means, standard_deviations]
    with open("Group_Stats.csv", "w") as f: #writing the data to a csv
        writer = csv.writer(f)
        writer.writerows(to_csv)
    print("Group statistics written to \'Group_Stats.csv\'.")

# Model spreadsheet generation
try:
    print("\nDo you wish to continue with generating spreadsheets for"+
        " the group of models?")
    print("If so, enter 1 to continue. Otherwise, enter 0.")
    choice = input("--> ")
    if int(choice)==1:
        for m in bio_data:
            # Note this creates an entirely new group of files. Any files in the same
            # directory with the same name will be overwritten
            model_workbook = xlsxwriter.Workbook(m.id+".xlsx")
            rxnSheet = model_workbook.add_worksheet('Reactions')
            metsSheet = model_workbook.add_worksheet('Metabolites')
            geneSheet = model_workbook.add_worksheet('Genes')

            reactions =[m.reactions.name, m.reactions.reaction, \
                m.reactions.lower_bound, m.reactions.upper_bound, \
                m.reactions.gene_reaction_rule, m.reactions.objective_coefficient]

            metabolites = [m.metabolites.name, m.metabolites.formula, \
                m.metabolites.compartment, m.metabolites.charge]

            genes = [m.genes.strand, m.genes.functional, \
                m.genes.locus_start, m.genes.locus_end]

            row = 0
            col = 0
            for name, rxn, lwr_bnd, upr_bnd, gene_rxn_rule, objCoeff in reactions:
                rxnSheet.write(row, col, str(name))
                rxnSheet.write(row, col+1, str(rxn))
                rxnSheet.write(row, col+2, str(lwr_bnd))
                rxnSheet.write(row, col+3, str(upr_bnd))
                rxnSheet.write(row, col+4, str(gene_rxn_rule))
                rxnSheet.write(row, col+5, str(objCoeff))
                row += 1

            row = 0
            col = 0
            for name, form, compartment, charge in metabolites:
                metsSheet.write(row, col, str(name))
                metsSheet.write(row, col+1, str(form.formula))
                metsSheet.write(row, col+2, str(compartment))
                metsSheet.write(row, col+3, str(charge))
                row += 1

            row = 0
            col = 0
            for strand, functional, start, end in genes:
                geneSheet.write(row, col, str(strand))
                geneSheet.write(row, col+1, str(functional))
                geneSheet.write(row, col+2, str(compartment))
                geneSheet.write(row, col+3, str(charge))
                row += 1

            model_workbook.close()
        print("Model spreadsheets assembled")
except:
    print("Unexpected error:", sys.exc_info()[0])

# Model studies sector
print("\nDo you wish to run tests (FBA, FVA, gene deletion, etc.) on"+
    " the group of models?")
print("If so, enter 1 to continue. Otherwise, enter 0.")
choice = input("--> ")
if int(choice)==1:
    loop = True
    while loop:
        print("___________________________________________")
        print("1. Flux Balance Analysis (FBA)")
        print("2. Parsimonius Flux Balance Analysis (pFBA)")
        print("3. Flux Variability Analysis (FVA)")
        print("4. Single Reaction Deletion Study")
        print("5. Single Gene Deletion Study")
        print("6. Double Gene Deletion Study")
        print("7. Double Reaction Deletion Study")
        print("___________________________________________")
        print("Any other number will exit the program.")
        print("Which test would you like to run on the models:")

        choice = input("--> ")
        num = None
        try:
            num = int(choice)
        except ValueError as ex:
            print(ex)
            continue
        # FBA
        if num==1:
            FBA_Solutions = []
            for m in bio_data:
                FBA_Solutions.append(m.optimize())
            print("Results stored in list \"FBA_Solutions\".\n")

        # pFBA
        elif num==2:
            pFBA_Solutions = []
            for m in bio_data:
                pFBA_Solutions.append(cobra.flux_analysis.pfba(m))
            print("Results stored in list \"pFBA_Solutions\".\n")

        # FVA
        elif num==3:
            FVA_Solutions = []
            print("Input a floating-point number between 0 and 1.")
            print("This the flux ranges for reactions at" +
                " that number's percentage of optimality.")
            temp = input("--> ")
            for m in bio_data:
                FVA_Solutions.append(flux_variability_analysis(
                    m, m.reactions[0:], fraction_of_optimum = temp))
            print("Results stored in list \"FVA_Solutions\".\n")

        # Single Reaction Deletion
        elif num==4:
            SRD_Solutions = []
            for m in bio_data:
                SRD_Solutions.append(single_gene_deletion(m))
            print("Results stored in list \"SRD_Solutions\".\n")

        # Single Gene Deletion
        elif num==5:
            SGD_Solutions = []
            for m in bio_data:
                SGD_Solutions.append(single_reaction_deletion(m))
            print("Results stored in list \"SGD_Solutions\".\n")

        # Double Gene Deletion
        elif num==6:
            print("WARNING: DOUBLE GENE DELETIONS ARE COMPUTATIONALLY INTENSIVE")
            print("AND AUTOANALYSIS OF MULTIPLE MODELS CAN TAKE SEVERAL HOURS")
            temp = input("DO YOU WISH TO CONTINUE? (\'Y\' or \'N\'):  ")
            if temp=='Y':
                DGD_Solutions = []
                for m in bio_data:
                    DGD_Solutions.append(double_gene_deletion(m, return_frame=True))
                print("Results stored in list \"DGD_Solutions\".\n")
            else:
                continue

        # Double Reaction Deletion
        elif num==7:
            DRD_Solutions = []
            for m in bio_data:
                DRD_Solutions.append(double_reaction_deletion(m, return_frame=True))
            print("Results stored in list \"DRD_Solutions\".\n")

        # Close script
        else:
            print("Closing script.")
else:
    print("Closing script.")
