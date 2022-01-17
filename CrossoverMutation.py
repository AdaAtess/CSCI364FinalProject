# crossover function (one crossover for each set of parent that we're randomly picking) Ada
    # how many parents are we picking each time? how many offsprings are we making?
    # for each location, randomly pick one of the two parents' modules
    # make a new chromosome from the two parents (because parent might have high fitness, don't want to modify)
    # call fitness function right after generating a child
import copy
import random
from initPopulation import calculateFitness
from ParentSurvivorSelection import selectParents

#crossrate = 0.27
def crossover(p1, p2, crossrate):

    c1 = copy.deepcopy(p1)
    c2 = copy.deepcopy(p2)

    p = random.random()
    while p < crossrate:
        position = random.randint(1, len(p1)-2)
        c1 = p1[:position] + p2[position:]
        c2 = p2[:position] + p1[position:]

    c1_f = calculateFitness(c1)
    c1.fitnessVal = c1_f

    c2_f = calculateFitness(c2)
    c2.fitnessVal(c1_f)

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
    for index in range(8):
        rand_value = random.randrange(1,6)
        offspring[index,4] = offspring[index, 4] + rand_value
    return offspring






