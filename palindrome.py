def isPalindrome(s):
    ''' check if a number is a Palindrome '''
    s = str(s)
    return s == s[::-1]

for i in range(10, 100000000):
  if isPalindrome(i):
    print(i)