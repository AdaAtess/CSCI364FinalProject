# crossover function (one crossover for each set of parent that we're randomly picking) Ada
    # how many parents are we picking each time? how many offsprings are we making?
    # for each location, randomly pick one of the two parents' modules
    # make a new chromosome from the two parents (because parent might have high fitness, don't want to modify)
    # call fitness function right after generating a child
import copy
import random
from initPopulation import fitness
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

    c1_f = fitness(c1)
    c1.fitnessVal = c1_f

    c2_f = fitness(c2)
    c2.fitnessVal(c1_f)

    max_f = max(c1_f, c2_f)
    if max_f == c1_f:
        return c1
    else:
        return c2





