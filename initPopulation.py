# 10 buildings total
# hardcode 3 buildings of a fixed number of cubes
# and generate the other buildings of the same size randomly

# - column 1
# - wall 2
# - arch 3
# - gateway 4
# - turret 5
# - courtyard/pond area 6

import random

class Chromosome:
    def __init__(self, moduleList):
        # list storing all the module numbers
        self.moduleList = moduleList
        self.fitnessVal = None  # call fitness function
    def __lt__(self, other):
        return self.fitnessVal<other.fitnessVal

def initPopulation():
    # list of lists
    chromosomeList = []
    building1 = [1,1,2,2,5,5,2,2]
    building2 = [1,1,2,2,3,3,2,2]
    building3 = [1,1,2,2,5,5,2,2]

    # 3 hardcoded buildings
    c1 = Chromosome(building1)
    c2 = Chromosome(building2)
    c3 = Chromosome(building3)
    chromosomeList.append(c1)
    chromosomeList.append(c2)
    chromosomeList.append(c3)

    # 27 buildings
    for randBuilding in range(0,27):
        randomList = []
        for index in range (0,8):
            randomList.append(random.randrange(1, 6))
        c4 = Chromosome(randomList)
        chromosomeList.append(c4)
    
    return chromosomeList

population = initPopulation()
for pop in population:
    print(pop.moduleList)

# a chromosome is 8 cubes or 2x2x2 dimensions
# position 1: 0,0,0 (x,y,z)/ start in the corner (1 cube)
# going in x-direction
# returns a list 
def createChromosome(self, moduleList, buildingList):
    # level 1: (0,0,0) (1,0,0) (1,1,0) (0,1,0)
    # level 2: (0,0,1) (1,0,1) (1,1,1) (0,1,1)
    for cube in buildingList:
        # call module according to 
        pass
    pass
