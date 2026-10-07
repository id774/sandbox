// vec_parts.rs: Vec ownership round trip through NonNull
//
// Description:
// Split a Vec<i32> into a NonNull pointer, length and capacity with
// Vec::into_parts and rebuild it with Vec::from_parts, both stable in
// Rust 1.99.0.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     rustc +1.99.0 --edition 2024 -o vec_parts vec_parts.rs
//     ./vec_parts
//
// Requirements:
// - Rust 1.99.0 or later (rustc)
// - No third-party package is required
//
// References:
// - Rust 1.99.0 release: https://blog.rust-lang.org/2026/10/01/Rust-1.99.0/
// - API documentation: https://doc.rust-lang.org/std/vec/struct.Vec.html

fn main() {
    let vec = vec![10, 20, 30, 40];
    let (ptr, len, capacity) = vec.into_parts();

    // SAFETY: `ptr`, `len` and `capacity` are the unmodified components
    // returned by Vec::into_parts for one Vec<i32>, which has not been freed
    // or rebuilt since, so they are consumed exactly once.
    let restored = unsafe { Vec::from_parts(ptr, len, capacity) };

    assert_eq!(restored, [10, 20, 30, 40]);
    let line: Vec<String> = restored.iter().map(|n| n.to_string()).collect();
    println!("{}", line.join(" "));
}
