# Strings

# 1. Write a Python program to check whether a given string is a palindrome (ignore case and spaces).


string = 'A man a plan a canal Panama'
cleaned = string.lower().replace(' ', '')
if cleaned == cleaned[::-1]:
    print('palindrome')
else:
    print('not palindrome')


# 2. Write a Python program to count the number of vowels in a string.

string = 'A man a plan a canal Panama'
lowered = string.lower()
vowels = 'aeiou'
result = sum(lowered.count(v) for v in vowels)
print(result)

# 3. Write a Python program to reverse the order of words in a sentence.

sen = 'Everyone Deserves Love And Respect'
rev_sen = sen.split()[::-1]
print(' '.join(rev_sen))  

# 4. Write a Python program to capitalize the first letter of every word in a string without using .title().

string = 'never give up on your dreams'
words = string.split()
capitalized = [word[0].upper() + word[1:] for word in words]
print(' '.join(capitalized))

# Numbers

# 5. Write a Python program to check whether a number is prime. "FAILED"

def is_prime(num):
    if num <= 1:
        return False

    for i in range(2, int(num**0.5) + 1):
        if num % i == 0:
            return False

    return True

number = int(input("Enter a number: "))

if is_prime(number):
    print("Prime")
else:
    print("Not Prime")
        

# 6. Write a Python program to convert Celsius to Fahrenheit and vice versa.

def conv_into_f(temp):
    return (temp*1.8) + 32

def conv_into_c(temp):
    return (temp - 32) / 1.8

print(conv_into_f(25))   # 77.0
print(conv_into_c(77))   # 25.0

# Conditionals

## 7. Write a Python program to assign a grade (A/B/C/D/F) based on marks.

def assign_grade(marks):

    if marks >= 90:
        return 'A'
    elif marks >= 80:
        return 'B'
    elif marks >= 70:
        return 'C'
    elif marks >= 50:
        return 'D'
    else:
        return 'F'

print(assign_grade(92))
print(assign_grade(82))
print(assign_grade(72))
print(assign_grade(52))
print(assign_grade(42))

# 8. Write a Python program to print the FizzBuzz sequence from 1 to n.

def FizzBuzz(n):
    for i in range(1,n+1):
        if i % 3 == 0 and i % 5 == 0:
            print('FizzBuzz')
        elif i % 3 == 0 :
            print('Fizz')
        elif i % 5 == 0:
            print('Buzz')
        else:
            print(i)

FizzBuzz(15)

# Loops

# 9. Write a Python program to find the sum of digits of a number.

def sum_of_digits(num):           # my approch 
    num_str = str(num)
    total = 0
    i = 0
    while i < len(num_str):
        total += int(num_str[i])
        i += 1
    return total

print(sum_of_digits(12345))

# version 2.0

def sum_of_digits(num):            # right approch 
    total = 0
    while num > 0:
        total += num % 10   # last digit
        num //= 10          # chop off the last digit
    return total

print(sum_of_digits(1234))  # 10

# 10. Write a Python program to find the factorial of a number using a loop.

def cal_fact(num):
    fact = 1
    i = 1
    while i <= num:
        fact *= i
        i += 1
    return fact

print(cal_fact(4))

# 11. Write a Python program to print a right-angled triangle pattern of stars using nested loops.

def star_triangle(num):             # my approch 
    for i in range(1, num + 1):
        print(i * '*')
        i += 1

star_triangle(10)

# version 2.0

def star_triangle(num):             # right approch 
    for i in range(1, num + 1):
        for j in range(i):
            print('*', end='')
        print()

star_triangle(10)

# Lists

# 12. Write a Python program to find the second largest number in a list without using sort().

nums = [1, 2, 7, 11, 5, 6 , 9]        # my approch 

max_n = nums[0]
for i in nums:
    if max_n < i:
        max_n = i 
print('Largest number:', max_n)
nums.remove(max_n)

max_2 = nums[0]
for i in nums:
    if max_2 < i:
        max_2 = i
print('Second largest number:', max_2)
nums.append(max_n)

# version 2.0
# right approch 

def second_largest(nums):
    # Start both as negative infinity so that literally any number
    # in the list will be bigger than them at the start.
    max1 = max2 = float('-inf')

    for num in nums:
        if num > max1:
            # Current number is bigger than our current largest.
            # Before overwriting max1, save its old value into max2 —
            # because the old max1 is now the second largest, not lost.
            max2 = max1
            max1 = num

        elif num > max2 and num != max1:
            # Current number isn't big enough to beat max1,
            # but it IS bigger than our current second largest.
            # num != max1 avoids counting a duplicate of the largest
            # as a "new" second largest (e.g. [9, 9, 5] shouldn't say second = 9).
            max2 = num

    return max2

print(second_largest([1, 2, 7, 11, 5, 6, 9]))  # 9

# 13. Write a Python program to remove duplicate elements from a list while preserving order, without using set().

el = [2, 5, 9, 7, 3, 9, 2, 8, 9, 7, 8]
unique_el = []
for e in el:
    if e not in unique_el:
        unique_el.append(e)
print(unique_el)

# if you can use set

seen = set()
unique_ele = []
for e in el:
    if e not in seen:
        seen.add(e)
        unique_ele.append(e)
print(unique_ele)

# 14. Write a Python program to merge two sorted lists into one sorted list without using sorted(). # "FAILED"

list1 = [1, 2, 3, 4, 5]            
list2 = [1, 2, 6, 7, 8]
list3 = []

i = 0   # pointer into list1
j = 0   # pointer into list2

# Walk both lists side by side, as long as both still have elements left
while i < len(list1) and j < len(list2):
    if list1[i] <= list2[j]:
        list3.append(list1[i])
        i += 1          # only list1's pointer moves
    else:
        list3.append(list2[j])
        j += 1          # only list2's pointer moves

# One list may still have leftover elements once the other runs out —
# tack on whatever's left (only one of these actually adds anything)
list3.extend(list1[i:])
list3.extend(list2[j:])

print(list3)

# Dictionaries / Tuples

# 15. Write a Python program to find the frequency of each word in a sentence.

sentence = "I like python and I like coding"
w_fq = {}

for i in sentence.split():
    if i not in w_fq:
        w_fq[i] = 1
    else:
        w_fq[i] += 1
print(w_fq)

# version 2.0
# better version:

import string

sentence = "I like python and I like coding! Python is fun."

# Strip punctuation and lowercase everything BEFORE splitting,
# so "Python," "python" and "Python" all count as the same word.
cleaned = sentence.lower().translate(str.maketrans('', '', string.punctuation))

w_fq = {}
for i in cleaned.split():
    w_fq[i] = w_fq.get(i, 0) + 1

print(w_fq)

# 16. Write a Python program to swap the keys and values of a dictionary.

alp_num = {
    "a": 1,
    "b": 2,
    "c": 3
}
num_alp = {}

for key, val in alp_num.items():
    num_alp[val] = key
print(num_alp)

# version 2.0
# better version:

num_alp = {val: key for key, val in alp_num.items()}
print(num_alp)


# 17. Write a Python program to find the name with the highest score from a list of (name, score) tuples.

Input = [                             # my approch
    ("Aryan", 98),
    ("Rahul", 91),
    ("Priya", 95),
    ("Neha", 90)]
name_max_s = {'name': 'x', 'score' : 0}
max_score = 0
for n, s in Input:
    if s > max_score:
        max_score = s
        name_max_s['name'] = n
        name_max_s['score'] = s
print(name_max_s)

# version 2.0
# right solution :

records = [
    ("Aryan", 98),
    ("Rahul", 91), 
    ("Priya", 95),
    ("Neha", 90)]

best = max(records, key=lambda x: x[1])
print(best)  # ('Aryan', 98)

Functions

# 18. Write a Python program using *args to multiply any number of arguments.

def anything(*args):
    mult = 1
    for i in args:
        mult *= i
    return mult

print(anything(1,2,3,4,5))


# 19. Write a Python function with a default parameter to greet a person.

def greet(name='Guest'):
    return f'Hello, {name}!'

print(greet('Aryan'))  # Hello, Aryan!
print(greet())         # Hello, Guest!

# 20. Write a Python program to find the nth Fibonacci number using recursion.

def fibonacci(n):    # failed 
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)

print(fibonacci(5))  # 5