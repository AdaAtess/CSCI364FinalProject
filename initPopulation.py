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
        self.fitnessVal = 0  # call fitness function
    def __lt__(self, other):
        return self.fitnessVal < other.fitnessVal


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

            # skip over 'exit' and vet format of the input
            if len(inputList) > 1:
                feature = int(inputList[0])
                featureFreq = int(inputList[1])

                # check if key exists in moduleIDs list
                if int(feature) in moduleIDs:
                    del(fitnessPreference[feature])
                    fitnessPreference[feature] = featureFreq  

moduleIDs = [1,2,3,4,5,6,7,8,9,10]
fitnessPreference = dict() # preference dict
getPreference(moduleIDs, fitnessPreference)
print(fitnessPreference)

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
    return sum


def initPopulation():
    # list of lists
    chromosomeList = []
    # 3 hardcoded buildings
    buildingsList = [[1,1,2,2,5,5,2,2], [1,1,2,2,3,3,2,2], [1,1,2,2,5,5,2,2]]
    
    for building in buildingsList:
        c1 = Chromosome(building)
        c1.fitnessVal = calculateFitness(moduleIDs, building, fitnessPreference)
        # print(c1.fitnessVal)
        chromosomeList.append(c1)

    # 27 randomized buildings
    i = 3
    for randBuilding in range(0,27):
        randomList = []
        for index in range (0,8):
            randomList.append(random.randrange(1, 6))
        c4 = Chromosome(randomList)
        c4.fitnessVal = calculateFitness(moduleIDs, randomList, fitnessPreference) 
        # print(c4.fitnessVal)   
        chromosomeList.append(c4)
    
    return chromosomeList

population = initPopulation()
# for pop in population:
#     print(pop.moduleList)
#     print(pop.fitnessVal)

# def calculateFitness(moduleList):
#     sum = 0
#     for num in moduleList:
#         sum += num
#     return sum


