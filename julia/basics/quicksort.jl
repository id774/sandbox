# Sort a fixed vector with a quicksort generic over any ordered element type.
# Run: julia quicksort.jl

function quicksort(items::AbstractVector{T}) where {T}
    length(items) <= 1 && return collect(items)
    pivot = items[begin]
    rest = @view items[(begin + 1):end]
    return vcat(quicksort(filter(x -> x <= pivot, rest)),
                pivot,
                quicksort(filter(x -> x > pivot, rest)))
end

println(join(quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]), " "))
