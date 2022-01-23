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

def getBuildingSize():
    instruction = """
    Enter a building size.
    ex) 32 (since 4*4*2 = 32)
    """
    print(instruction)
    dimensions = int(input())
    return dimensions

def getPreference(moduleIDs, fitnessPreference):
    # initialize dict with 0 freq of occurence
    for id in moduleIDs:
        fitnessPreference[id] = 0    
    
    while True:
        instruction = """
        Please enter a castle feature ID, followed by a space  and its frequency of occurences.
        ex) 12 1

        [0: empty(), 1: floor(), 2: wall(), 3: room with 4 walls(), 4: threeWallRoomTowardsX(), 5: threeWallRoomTowardsY(), 
        6: threeWallRoomAwayX(), 7: threeWallRoomAwayY(), 8: cornerRoomOrigin(), 9: cornerRoomAlongX(),
        10: cornerRoomAlongY(), 11: cornerRoomAlongXandY(), 12: twoWallRoomAlongX(),
        13: twoWallRoomAlongY(), 14: oneWallRoomX(), 15: oneWallRoomY(), 16: oneWallRoomParallelX().
        17: oneWallRoomParallelY(), 18: column(), 19: cone_top_turret(), 20: arch(), 21: portcullis(), 22: door(), 23: roof()]
        
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

moduleIDs = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
dimensions = getBuildingSize()
fitnessPreference = dict() # preference dict
getPreference(moduleIDs, fitnessPreference)
#print(fitnessPreference)

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
    buildingSize = dimensions
    #print("buildingSize:", buildingSize)

    # list of lists
    chromosomeList = []

    fiveByFiveByTwo = 5*5*2
    if dimensions >= fiveByFiveByTwo:
        lastEmpty = int(buildingSize*2/3)
        percentEmpty = 80
    else:
        lastEmpty = int(buildingSize/2)
        percentEmpty = 60


    # 30 randomized buildings
    for randBuilding in range(0,30):
        randomList = []
        for index in range (0, lastEmpty):
            # 0-21 (not including 21)
            randomList.append(random.randrange(0, len(moduleIDs)+1))
        
        # last 1/3 of the moduleList has 80% chance of getting module 1 (a floor)
        for index in range (lastEmpty,buildingSize):
            if random.randint(0,100) <= percentEmpty:
                randomList.append(1)
            else:
                randomList.append(random.randrange(0, len(moduleIDs)+1))

        c4 = Chromosome(randomList)
        c4.fitnessVal = calculateFitness(randomList) 
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


