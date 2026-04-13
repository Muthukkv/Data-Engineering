# Find the character that occurs the most in a string and print it.

str = "aaaabbbbbc"
dict = {}

for i in str: # adding charector as key and its occurence as value in the dictionary
    if i in dict:
        dict[i] += 1 # if the charector is already in the dictionary then increase its value by 1
    else:
        dict[i] = 1 # if the charector is not in the dictionary then add it to the dictionary with value 1

max_occur = max(dict, key=dict.get) # using max function to find the key with the maximum value in the dictionary and storing it in max_occur variable

print(max_occur)