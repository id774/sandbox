// box_non_null.rs: Box ownership transfer through NonNull
//
// Description:
// Convert a Box<String> into a NonNull<String> with Box::into_non_null and
// restore it with Box::from_non_null, both stable in Rust 1.99.0.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     rustc +1.99.0 --edition 2024 -o box_non_null box_non_null.rs
//     ./box_non_null
//
// Requirements:
// - Rust 1.99.0 or later (rustc)
// - No third-party package is required
//
// References:
// - Rust 1.99.0 release: https://blog.rust-lang.org/2026/10/01/Rust-1.99.0/
// - API documentation: https://doc.rust-lang.org/std/boxed/struct.Box.html
// - Inspiration: https://qiita.com/DwarfM42/items/b4a78fdbf38129ee2fcd

fn main() {
    let boxed = Box::new(String::from("sandbox"));
    let ptr = Box::into_non_null(boxed);

    // SAFETY: `ptr` came directly from Box::into_non_null above and has been
    // neither freed nor re-owned since, so it is reclaimed exactly once.
    let restored = unsafe { Box::from_non_null(ptr) };

    assert_eq!(*restored, "sandbox");
    println!("{}", restored);
}
