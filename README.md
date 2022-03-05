# palindrom2

Computes numbers that are palindromes in both decimal and binary.

## Execute

swift run -c release

## Execute with debug info and processing rate measurements

palindromes with ordinal numbers and elapsed time since start.
swift run -c release -Xswiftc -DTIMING

Rate of operations
swift run -c release -Xswiftc -DMEASURE

## Notes

a simple loop perform 1733902255 iterations a second.

naive isBinaryPalindrom 105,500,130 times a second after 30 steps,
starting from Int32.max.

isBinaryPalindrom with lookup 163,223,167 times a second after 30 steps,
starting from Int32.max.

decimal palindrome of 16 digits checked by lookup: 1,000,639 / sec

parallel E2E after checking 100,000,000 numbers rate is 2,252,938 / sec
batchSize is 100,000
Single operation witht same parameters rate is 540,173 / sec
