lst = ["Muthu","Kumar","Arun"]
lst2 = []
for i in lst:
    if i == "Muthu" or "Navanee": # This condition is always true because "Navanee" is a non-empty string, so it will always evaluate to True. Therefore, the code inside the if block will always execute, and "nothing else" will never be printed.
        lst2.append(i)
    else:
        print("nothing else")
print(lst)
print(lst2)