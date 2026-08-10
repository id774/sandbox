// Print FizzBuzz for 1 through 100, choosing the label with a switch over a tuple.
// Run: swift fizzbuzz.swift

func fizzBuzzLabel(_ n: Int) -> String {
    switch (n % 3, n % 5) {
    case (0, 0): return "FizzBuzz"
    case (0, _): return "Fizz"
    case (_, 0): return "Buzz"
    default: return String(n)
    }
}

for n in 1...100 {
    print(fizzBuzzLabel(n))
}
