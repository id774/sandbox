// utf8_lossy_owned.rs: Lossy UTF-8 conversion of an owned Vec<u8>
//
// Description:
// Convert an owned Vec<u8> containing an invalid UTF-8 sequence into a String
// with String::from_utf8_lossy_owned, stable in Rust 1.99.0.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     rustc +1.99.0 --edition 2024 -o utf8_lossy_owned utf8_lossy_owned.rs
//     ./utf8_lossy_owned
//
// Requirements:
// - Rust 1.99.0 or later (rustc)
// - No third-party package is required
//
// References:
// - Rust 1.99.0 release: https://blog.rust-lang.org/2026/10/01/Rust-1.99.0/
// - API documentation: https://doc.rust-lang.org/std/string/struct.String.html
// - Inspiration: https://qiita.com/DwarfM42/items/b4a78fdbf38129ee2fcd

fn main() {
    let mut bytes = Vec::new();
    bytes.extend_from_slice(b"rust ");
    bytes.extend_from_slice(&[0xF0, 0x90, 0x80]);
    bytes.extend_from_slice(b" sample");

    let text = String::from_utf8_lossy_owned(bytes);

    assert_eq!(text, "rust \u{FFFD} sample");
    println!("{}", text);
}
