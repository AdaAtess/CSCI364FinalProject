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
    
    while True:
        instruction = """
        [0: empty, 1: floor, 2: wall, 3: room with 4 walls, ...]
        Please enter a castle feature ID, followed by a space  and its frequency of occurences.
        To exit, enter "exit"
        """
        print(instruction)

        user_input = input()
        if (user_input == 'exit'):
            break
        else:
            inputList = user_input.split(" ")

            # skip over 'exit' and vet format of the input
            if len(inputList) > 1:
                feature = int(inputList[0])
                featureFreq = int(inputList[1])

                # check if key exists in moduleIDs list
                if int(feature) in moduleIDs:
                    del(fitnessPreference[feature])
                    fitnessPreference[feature] = featureFreq  

moduleIDs = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
fitnessPreference = dict() # preference dict
getPreference(moduleIDs, fitnessPreference)
print(fitnessPreference)

def calculateFitness(moduleList):    
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
    buildingSize = 5*5*2

    # list of lists
    chromosomeList = []


    # 30 randomized buildings
    for randBuilding in range(0,30):
        randomList = []
        for index in range (0, int(buildingSize*2/3)):
            # 0-21 (not including 21)
            randomList.append(random.randrange(0, len(moduleIDs)+1))
        
        # last 1/3 of the moduleList has 80% chance of getting module 1 (a floor)
        for index in range (int(buildingSize*2/3),buildingSize):
            if random.randint(0,100) <= 80:
                randomList.append(1)
            else:
                randomList.append(random.randrange(0, len(moduleIDs)+1))

        c4 = Chromosome(randomList)
        c4.fitnessVal = calculateFitness(randomList) 
        # print(c4.fitnessVal)   
        chromosomeList.append(c4)
    
    return chromosomeList

population = initPopulation()
for pop in population:
    print(pop.moduleList)
    print(pop.fitnessVal)

# def calculateFitness(moduleList):
#     sum = 0
#     for num in moduleList:
#         sum += num
#     return sum


