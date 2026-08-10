# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
# Run: julia pascal.jl

const ROWS = 10

row = [1]
for _ in 1:ROWS
    global row
    println(join(row, " "))
    row = [0; row] .+ [row; 0]
end
