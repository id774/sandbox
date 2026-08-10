# Annotate a function with types so mypy can flag a wrong argument type.

def add(a: int, b: int) -> int:
    return a + b

print(add(2, 3))
print(add("a", 3))
