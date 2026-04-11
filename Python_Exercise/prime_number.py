# print the list of prime numbers between 25 and 50
lst = []
for i in range(25,51):
    for j in range(2,i): # starting from 2 as 1 is always a factor of every number
        if i%j==0: # checking  will be divisible by any number between 2 and itself
            break
    else: # if break is hit then else will be executed and the number will be added to the list
        lst.append(i)
print(lst)
