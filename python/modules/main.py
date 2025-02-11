import test1
# from test2 import simple_intrest
# from test3 import matrix

# # print(add(5,5))
# # print(sub(5,4))

# # from test1.py 
# @my_deco
# def say_something():
#     print('hai')
print(test1.add(1,2))


# # from test2.py
# p = [1000, 2000, 3000, 4000, 5000]
# r = [2, 4, 6, 8, 10]
# n = [2, 4, 6, 8, 10]
# name = ['a','b','c','d','e']
# si = []

# for i in range(len(name)):
#     amount = simple_intrest(p[i], r[i], n[i])
#     si.append(amount)
#     print(f'{name[i]} invested {p[i]} with interest rate of {r[i]}% for {n[i]} years, resulting in a total amount of {si[i]}')


# # from test3.py
# # matrix(int(input), int(input))
# matrix(3, 3)

# import inspect module 
# import inspect 

# # our treeClass function 
# def treeClass(cls, ind = 0): 
	
# 	# print name of the class 
# 	print ('-' * ind, cls.__name__) 
	
# 	# iterating through subclasses 
# 	for i in cls.__subclasses__(): 
# 		treeClass(i, ind + 3) 

# print("Hierarchy for Built-in exceptions is : ") 

# # inspect.getmro() Return a tuple 
# # of class cls’s base classes. 

# # building a tree hierarchy 
# inspect.getclasstree(inspect.getmro(BaseException)) 

# # function call 
# treeClass(BaseException) 

# this can be run in a teminal and pass the value
'''
import sys
print(sys.argv)
print(sys.argv[1:])
Sum = 0

for i in range(1,len(sys.argv)):
    Sum += int(sys.argv[i])
    
print('result:',Sum)
'''


# import argparse

# # initilize the parser
# parser = argparse.ArgumentParser()

# #adding optional argument
# parser.add_argument('-o','--output',help = 'show output')

# # Read arguments from comangd line 
# args = parser.parse_args()

# if args.output:
#     print('displaying output as: % s' % args.output )


'''
# the -with variables are optional if u dont specify it will automatically accept the args..
# the variable without -  is mandatory you have to provide it 
# for example in here filename is mandatory and if u dont specify it will throw an error that will specify


import argparse

parser = argparse.ArgumentParser()

parser.add_argument('filename', help = 'enter a file name to open')

parser.add_argument('-c','--copy',type=int,help= 'make n copies of files')

parser.add_argument('-s','--something',action= 'store_const',const=5)

parser.add_argument('-t','--true',action='store_true')

args = parser.parse_args()

print(args)
'''

