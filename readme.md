# Sieve of Eratosthenes

* The Sieve of Eratosthenes is an algorithm that is used to find all prime numbers in a given range.

* The Sieve of Eratosthenes is implemented in the MIPS assembly language.

* The time complexity is O(n log log n)

### How the Sieve of Eratosthenes works

* The Sieve of Eratosthenes finds all prime numbers by iteratively marking each number as not prime if it is a multiple of some prime, starting with the first prime number.

* When a prime number is found it generates all multiples of it within the range and marks them as not prime.

* This process is repeated from the first prime number in the range to square root of the nth number
![image](https://user-images.githubusercontent.com/64645167/126760328-f48aefed-50ac-498b-a6b2-3ed800bc1070.png)
