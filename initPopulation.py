# 10 buildings total
# hardcode 3 buildings of a fixed number of cubes
# and generate the other buildings of the same size randomly

# - column 1
# - wall 2
# - arch 3
# - gateway 4
# - turret 5
# - courtyard/pond area 6

# combination of modules
# ex) 4 cols on one side, wall on the other side

import random

class Chromosome:
    def __init__(self, moduleList):
        # list storing all the module numbers
        self.moduleList = moduleList
        self.fitnessVal = None  # call fitness function
    def __lt__(self, other):
        return self.fitnessVal<other.fitnessVal


def getPreference(moduleIDs, fitnessPreference):
    # initialize dict with 0 freq of occurence
    for id in moduleIDs:
        fitnessPreference[id] = 0    
    
    user_input = ""
    while user_input != 'exit':
        instruction = """
        [1: wall, 2: column, 3: turret, ...]
        Please enter a castle feature ID, followed by a space  and its frequency of occurences.
        To exit, enter "exit"
        """
        print(instruction)

        user_input = input()
        if (user_input == 'exit'):
            break
        else:
            inputList = user_input.split()
            # skip over 'exit'
            if len(inputList) > 1:
                feature = inputList[0]
                featureFreq = inputList[1]
                # check if key exists in moduleIDs list
                if feature in moduleIDs:
                    fitnessPreference[feature] = featureFreq  

moduleIDs = [1,2,3,4,5,6,7,8,9,10]
fitnessPreference = dict() # preference dict
getPreference(moduleIDs, fitnessPreference)

def calculateFitness(moduleIDs, moduleList, fitnessPreference):    
    sum = 0
    # check freq of each feature in the moduleIDs list
    for id in moduleIDs:
        initialVal = 50
        idFreq = 0
        # get freq of ID
        for num in moduleList:
            if id == num:
                idFreq += 1
        # if idFreq is closer to to the preference, it has higher fitness value
        difference = abs(fitnessPreference[id] - idFreq)
        sum += initialVal - difference
        print(id)
        print(sum)
    return sum


def initPopulation():
    # list of lists
    chromosomeList = []
    building1 = [1,1,2,2,5,5,2,2]
    building2 = [1,1,2,2,3,3,2,2]
    building3 = [1,1,2,2,5,5,2,2]

    # 3 hardcoded buildings
    c1 = Chromosome(building1)
    c1.fitnessVal = calculateFitness(moduleIDs, building1, fitnessPreference)
    c2 = Chromosome(building2)
    c1.fitnessVal = calculateFitness(moduleIDs, building2, fitnessPreference)
    c3 = Chromosome(building3)
    c1.fitnessVal = calculateFitness(moduleIDs, building3, fitnessPreference)
    chromosomeList.append(c1)
    chromosomeList.append(c2)
    chromosomeList.append(c3)

    # 27 randomized buildings
    i = 3
    for randBuilding in range(0,27):
        randomList = []
        for index in range (0,8):
            randomList.append(random.randrange(1, 6))
        c4 = Chromosome(randomList)
        c4.fitnessVal = calculateFitness(moduleIDs, randomList, fitnessPreference)    
        chromosomeList.append(c4)
    
    return chromosomeList

population = initPopulation()
# for pop in population:
#     print(pop.moduleList)

# def calculateFitness(moduleList):
#     sum = 0
#     for num in moduleList:
#         sum += num
#     return sum


