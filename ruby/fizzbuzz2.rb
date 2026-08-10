# Print FizzBuzz for 1 through 100 using array indexing tricks.

1.upto(100){|i|s =[[:Fizz][i%3],[:Buzz][i%5]]*'';p s[1]?s:i}
