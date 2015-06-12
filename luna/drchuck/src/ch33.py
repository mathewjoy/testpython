from pip._vendor.distlib.compat import raw_input
from builtins  import ValueError

score_in = raw_input("Enter a number between 0.0 and 1.0 : ")

try:
    score = float(score_in)
except ValueError as e:
    print ("Value Error({0}): {1}".format(e.errno, e.strerror))
    quit()

if (score > 1.0) :
    grade = "Out of range. Enter a value between 0 and 1"
elif (score >= .9) :
    grade = 'A'
elif (score >= .8) :
    grade = 'B'
elif (score >= .7) :
    grade = 'C'
elif (score >= .6) :
    grade = 'D'
elif (score <= .6 and score >= 0):
    grade = 'F'
else:
    grade = "Out of range. Enter a value between 0 and 1"
     

print (grade)
    
