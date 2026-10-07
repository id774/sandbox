// c_variadic.rs: C ABI variadic function defined in Rust
//
// Description:
// Define an unsafe extern "C" variadic function in Rust, stable in Rust 1.99.0,
// read its arguments through VaList, and print their sum.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     rustc +1.99.0 --edition 2024 -o c_variadic c_variadic.rs
//     ./c_variadic
//
// Requirements:
// - Rust 1.99.0 or later (rustc)
// - No third-party package is required
//
// References:
// - Rust 1.99.0 release: https://blog.rust-lang.org/2026/10/01/Rust-1.99.0/
// - API documentation: https://doc.rust-lang.org/stable/core/ffi/struct.VaList.html
// - Inspiration: https://qiita.com/DwarfM42/items/b4a78fdbf38129ee2fcd

/// Sums `count` variadic `i32` arguments.
///
/// # Safety
///
/// The caller must pass at least `count` variadic arguments, and every one of
/// them must be an `i32`.
unsafe extern "C" fn sum(count: usize, mut args: ...) -> i32 {
    let mut total = 0;
    for _ in 0..count {
        // SAFETY: the function contract requires `count` variadic arguments
        // of type i32, so each read matches the argument actually passed.
        total += unsafe { args.next_arg::<i32>() };
    }
    total
}

fn main() {
    // SAFETY: exactly 4 variadic arguments are passed, all of type i32,
    // which matches the count given as the fixed argument.
    let result = unsafe { sum(4, 10_i32, -3_i32, 7_i32, 6_i32) };
    assert_eq!(result, 20);
    println!("sum = {}", result);
}
