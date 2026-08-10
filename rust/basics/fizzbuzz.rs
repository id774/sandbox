// Print FizzBuzz for 1 through 100, branching with match on a tuple of remainders.
// Build: rustc -o fizzbuzz fizzbuzz.rs

fn main() {
    for n in 1..=100 {
        let line = match (n % 3, n % 5) {
            (0, 0) => "FizzBuzz".to_string(),
            (0, _) => "Fizz".to_string(),
            (_, 0) => "Buzz".to_string(),
            _ => n.to_string(),
        };
        println!("{}", line);
    }
}
