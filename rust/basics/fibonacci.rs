// Print the first 20 Fibonacci numbers from a hand-written Iterator implementation.
// Build: rustc -o fibonacci fibonacci.rs

struct Fibonacci {
    current: u64,
    next: u64,
}

impl Iterator for Fibonacci {
    type Item = u64;

    fn next(&mut self) -> Option<u64> {
        let value = self.current;
        self.current = self.next;
        self.next += value;
        Some(value)
    }
}

fn main() {
    let fib = Fibonacci {
        current: 0,
        next: 1,
    };
    let values: Vec<String> = fib.take(20).map(|n| n.to_string()).collect();
    println!("{}", values.join(" "));
}
