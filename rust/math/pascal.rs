// Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
// Build: rustc -o pascal pascal.rs

const ROWS: usize = 10;

fn main() {
    let mut row: Vec<u64> = vec![1];

    for _ in 0..ROWS {
        let fields: Vec<String> = row.iter().map(|value| value.to_string()).collect();
        println!("{}", fields.join(" "));

        let shifted = std::iter::once(&0).chain(row.iter());
        let padded = row.iter().chain(std::iter::once(&0));
        row = shifted.zip(padded).map(|(left, right)| left + right).collect();
    }
}
