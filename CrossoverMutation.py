# crossover function (one crossover for each set of parent that we're randomly picking) Ada
    # how many parents are we picking each time? how many offsprings are we making?
    # for each location, randomly pick one of the two parents' modules
    # make a new chromosome from the two parents (because parent might have high fitness, don't want to modify)
    # call fitness function right after generating a child
import copy
import random
from initPopulation import calculateFitness
from ParentSurvivorSelection import selectParents

class Chromosome:
    def __init__(self, moduleList):
        # list storing all the module numbers
        self.moduleList = moduleList
        self.fitnessVal = 0  # call fitness function
    def __lt__(self, other):
        return self.fitnessVal<other.fitnessVal
        # the number representing the module
        # the number identifying the cube it's in (figure out LATER)

#crossrate = 0.27
def crossover(p1, p2):

    c1 = Chromosome(p1.moduleList)
    c2 = Chromosome(p2.moduleList)
    # c1 = copy.deepcopy(p1)
    # c2 = copy.deepcopy(p2)

    p = random.random()
    #while p < crossrate:
    position = random.randint(1, len(p1.moduleList)-2)
    c1.moduleList = p1.moduleList[:position] + p2.moduleList[position:]
    c2.moduleList = p2.moduleList[:position] + p1.moduleList[position:]

    c1_f = calculateFitness(c1.moduleList)
    c1.fitnessVal = c1_f

    c2_f = calculateFitness(c2.moduleList)
    c2.fitnessVal = c2_f

    max_f = max(c1_f, c2_f)
    if max_f == c1_f:
        return c1
    else:
        return c2

# mutation function (parameters: probability)   Ada
    # generating a list 8 rooms
    # change the middle of the list, or add to the end
    # can slice lists in Python
    # for every given location, randomly change to another module (0.1)
    # have an option (for an even smaller probability)
    # (FOR LATER) if a position has an empty cube next to it, the position has a small probability (another room, a bigger room, or a turet)
    # call fitness function right after generating a child

#mutrate = 0.15
def mutation(offspring, mutrate):
    for index in range(len(offspring.moduleList)):      #for the length of the chromosome
        p = random.random()     #get a probability
        if p < mutrate:         #if lower than mutation rate
            rand_value = random.randrange(1,6)      #choose a random gene/module
            offspring.moduleList[index] = rand_value       #add in the middle
    off_f = calculateFitness(offspring.moduleList)
    offspring.fitnessVal = off_f
    return offspring






