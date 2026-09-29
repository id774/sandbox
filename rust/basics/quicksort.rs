// quicksort.rs: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array with a quicksort generic over any ordered element type.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     rustc -o quicksort quicksort.rs
//     ./quicksort
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

fn quicksort<T: Ord + Clone>(items: &[T]) -> Vec<T> {
    match items.split_first() {
        None => Vec::new(),
        Some((pivot, rest)) => {
            let smaller: Vec<T> = rest.iter().filter(|x| *x <= pivot).cloned().collect();
            let larger: Vec<T> = rest.iter().filter(|x| *x > pivot).cloned().collect();
            let mut sorted = quicksort(&smaller);
            sorted.push(pivot.clone());
            sorted.extend(quicksort(&larger));
            sorted
        }
    }
}

fn main() {
    let items = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6];
    let sorted: Vec<String> = quicksort(&items).iter().map(|n| n.to_string()).collect();
    println!("{}", sorted.join(" "));
}
