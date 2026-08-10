// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
// Run: swift gcd_lcm.swift

let pairs = [(1071, 462), (270, 192), (17, 5), (120, 36)]

func euclid(_ first: Int, _ second: Int) -> Int {
    var first = first
    var second = second
    while second != 0 {
        (first, second) = (second, first % second)
    }
    return first
}

for (first, second) in pairs {
    let divisor = euclid(first, second)
    print("\(first) \(second) \(divisor) \(first / divisor * second)")
}
