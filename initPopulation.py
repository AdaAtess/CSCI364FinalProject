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

    #add the hardcoded buildings to the chromosomeList
    hardcodedList1 = [8, 14, 14, 9, 15, 1, 1, 17, 15, 1, 1, 17, 10, 16, 16, 11, 8, 14, 14, 9, 15, 1, 1, 17, 15, 1, 1, 17, 10, 16, 16, 11]
    c5 = Chromosome(hardcodedList1)
    c5.fitnessVal = calculateFitness(hardcodedList1)
    chromosomeList.append(c5)
    hardcodedList2 = [19, 14, 14, 19, 15, 1, 1, 17, 15, 1, 1, 17, 19, 16, 16, 19, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0]
    c5 = Chromosome(hardcodedList2)
    c5.fitnessVal = calculateFitness(hardcodedList2)
    chromosomeList.append(c5)
    hardcodedList3 = [18, 18, 18, 18, 18, 1, 1, 18, 18, 1, 1, 18, 18, 18, 18, 18, 23, 23, 23, 23, 7, 1, 1, 5, 10, 1, 1, 17, 10, 16, 16, 5]
    c5 = Chromosome(hardcodedList3)
    c5.fitnessVal = calculateFitness(hardcodedList3)
    chromosomeList.append(c5)
    hardcodedList4 = [8, 22, 14, 9, 20, 1, 1, 13, 20, 1, 1, 11, 10, 16, 21, 21, 8, 12, 7, 9, 17, 1, 1, 5, 17, 1, 1, 17, 10, 16, 16, 5]
    c5 = Chromosome(hardcodedList4)
    c5.fitnessVal = calculateFitness(hardcodedList4)
    chromosomeList.append(c5)
    hardcodedList5 = [1, 14, 1, 1, 18, 15, 13, 11, 20, 1, 16, 1, 18, 4, 18, 18, 9, 14, 5, 9, 17, 1, 15, 13, 1, 1, 1, 15, 11, 17, 16, 11]
    c5 = Chromosome(hardcodedList5)
    c5.fitnessVal = calculateFitness(hardcodedList5)
    chromosomeList.append(c5)
    hardcodedList6 = [8, 22, 21, 5, 21, 14, 14, 9, 21, 1, 21, 9, 10, 19, 10, 16, 8, 22, 21, 23, 15, 14, 9, 23, 13, 16, 17, 23, 4, 19, 4, 23]
    c5 = Chromosome(hardcodedList6)
    c5.fitnessVal = calculateFitness(hardcodedList6)
    chromosomeList.append(c5)

    fiveByFiveByTwo = 5*5*2
    if dimensions >= fiveByFiveByTwo:
        lastEmpty = int(buildingSize*2/3)
        percentEmpty = 80
    else:
        lastEmpty = int(buildingSize/2)
        percentEmpty = 60


    # 30 randomized buildings
    for randBuilding in range(0,24):
        randomList = []
        for index in range (0, lastEmpty):
            # 0-21 (not including 21)
            randomList.append(random.randrange(0, len(moduleIDs)))
        
        # last 1/3 of the moduleList has 80% chance of getting module 1 (a floor)
        for index in range (lastEmpty,buildingSize):
            if random.randint(0,100) <= percentEmpty:
                randomList.append(1)
            else:
                randomList.append(random.randrange(0, len(moduleIDs)))

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


