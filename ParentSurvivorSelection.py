#This file has the parent selection and survivor selection functions.
#When combining, remember to add archive=[] early in the main program, outside any functions. 
import random
import copy
class Chromosome:
    def __init__(self):
        # list storing all the module numbers
        self.moduleList = []
        self.fitnessVal = None  # call fitness function
        # the number representing the module
        # the number identifying the cube it's in (figure out LATER)
    def __lt__(self, other):
        return self.fitnessVal<other.fitnessVal
    
#overwrites the built-in less than method and
#makes it so list.sort() on a list of chromosomes will sort itself by fitness


#population is a list of chromosomes
#I've finished writing this function but haven't tested it yet. 
def selectParents(population, k, numKids):
    #This uses k way tournament selection to pick numKids pairs of parents.
    #It returns a list of lists, each inner list containing a pair of parent chromosomes.
    #Currently parents can be picked multiple times, although each pair will have two different parents.
    pairs=[]
    while len(pairs) < numKids: #within this loop, pick a pair and add it to the list
        thisPair=[]
        #tempPop=population.copy()
        tempPop = copy.deepcopy(population)
        
        for parent in range (2):
            competitors=[]
            for i in range(k): #just so it loops k times
                #picking k chromosomes randomly from the population
                choice=random.choice(tempPop)
                competitors.append(choice)
                tempPop.remove(choice) #Check that this works with the Chromosome objects
                

            #Now fight! (Pick the competitor with the highest fitness and add it to thisPair)
            competitors.sort(reverse=True) #should sort the list in descending order by fitness. It's not actually necessary to sort all of it but can fix later if needed.
            thisPair.append(competitors[0])

            #Next two lines only necessary 1st time through, setting up for the 2nd parent so parents in a pair are unique
            #tempPop=population.copy()
            tempPop = copy.deepcopy(population)
            tempPop.remove(thisPair[0])

        pairs.append(thisPair)
    return pairs
                  
                  
#parents should be the current population list of chromosomes, kids should be a list of the generated new chromosomes
#survivor selection function
archive=[]
def makeNextGeneration(parents, kids, numToReplace, numToArchive):
    global archive
    parents.sort(reverse=True) #sorts in descending order by fitness
    kids.sort(reverse=True)

    #Add the top numToArchive chromosomes from the parent population to the "best of" archive
    for i in range(numToArchive):
        archive.append(parents[i])

    nextGeneration=[]
    popSize=len(parents)

    #Add the parents we are keeping to the next generation
    for j in range((popSize-numToReplace)):
        nextGeneration.append(parents[j])
    
    #Add the most fit children to the next generation
    for k in range(numToReplace):
        nextGeneration.append(kids[k])

    return nextGeneration


    
#testing code for the makeNextGeneration function below
'''population=[]
for i in range(30):
    c=Chromosome()
    c.fitnessVal=i
    population.append(c)

a=Chromosome()
a.fitnessVal=80
b=Chromosome()
b.fitnessVal=60
c=Chromosome()
c.fitnessVal=72
d=Chromosome()
d.fitnessVal=65
e=Chromosome()
e.fitnessVal=55
kids=[a,b,c,d,e]

newPop=makeNextGeneration(population, kids, 3, 5)
print("Archive:")
for item in archive:
    print(item.fitnessVal)
print()

print("new generation")
for c in newPop:
    print(c.fitnessVal)'''

# pairsParents=selectParents(population, 4, 12)

