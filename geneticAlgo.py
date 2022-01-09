# import the files from everybody

# chromosome class - one chromosome is an entire building structure
class Chromosome:
    def __init__(self):
        # list storing all the module numbers
        self.moduleList = []
        self.fitnessVal = None  # call fitness function
        pass
        # the number representing the module
        # the number identifying the cube it's in (figure out LATER)
    pass

# main function (call genetic algorithm functions) (paramenters: receive input to use for fitness function)

# NUMBER OF MODULES FOR TESTING: 10 module options hypothetically (spit out a list at the end)

# initliaze population (~30 chromosomes)  An
    # hardcode 6 buildings of a fixed number of cubes - generate the other buildings of the same size randomly
    # at first, hardcode for testing (certain dimensions). Later, have user input initialize
    # hardcode a few (heuristic) and generate some randomly
    # store all chromosomes in a list (8 cubes or 2x2x2 dimensions)
    # position 1: 0,0,0 (x,y,z)/ start in the corner (1 cube)
    # going in x-direction (0,0,0) (1,0,0) (1,1,0) (0,1,0)
    # p5 (next level): (0,0,1) (1,0,1) (1,1,1) (0,1,1)

# parent selection function (choose from population) Lynn
    # tournament selection (12 set of parents/ 24 chromosomes)

# crossover function (one crossover for each set of parent that we're randomly picking) Ada
    # how many parents are we picking each time? how many offsprings are we making?
    # for each location, randomly pick one of the two parents' modules
    # make a new chromosome from the two parents (because parent might have high fitness, don't want to modify)
    # call fitness function right after generating a child

# mutation function (parameters: probability)   Ada
    # generating a list 8 rooms
    # change the middle of the list, or add to the end
    # can slice lists in Python
    # for every given location, randomly change to another module (0.1)
    # have an option (for an even smaller probability) 
    # (FOR LATER) if a position has an empty cube next to it, the position has a small probability (another room, a bigger room, or a turet)
    # call fitness function right after generating a child

# fitness function (a bunch of if statements, LATER consider user input)    An
    # what is a good number of rooms? turets? you want
    # and the importance of that feature
    # hardcode (each building element has utility = a number)
    # ex) if building has module 2, add 2 points of utility to fitness score
    # ex) two gates next to each other (just an example)
    # loop through each chromosome
        # calc fitness by summing the modules in the list (since moduleList is a list of numbers)

# function that update fitness vals for all the chromosomes by calling fitness or calc from scratch
# WHILE LOOP: termination condition that returns True or False (>= a fitness val) (do 20 generations, then stop) 

# survivor selection    Lynn
    # keep some parents, replace some with offsprings
        # how many parents to replace? (8 chromosomes) and 8 children
        # still fitness-based
    # have a separate archive of the highest fitnessVal chromosomes no matter the generation 


# LATER - all chromosomes are half-buildings. Have a function to mirror them at the end

# a list of cube regions
# start from the corner, then add to the surrounding cubes
