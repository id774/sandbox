// Sort a fixed array with a quicksort generic over any ordered element type.
// Build: rustc -o quicksort quicksort.rs

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
