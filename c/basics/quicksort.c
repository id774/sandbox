/*
 * quicksort.c: Quicksort of a fixed integer sequence
 *
 * Description:
 * Sort a fixed array in place with a quicksort over a Lomuto partition.
 *
 * Part of the basics cross-language exercise set: the input is fixed in the
 * source, and the output is the same as that of the same exercise in every
 * other language. The exercises are specified in README.md at the
 * repository root.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o quicksort quicksort.c
 *     ./quicksort
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stddef.h>
#include <stdio.h>

static void swap(int *a, int *b)
{
    int tmp = *a;

    *a = *b;
    *b = tmp;
}

static void quicksort(int *items, size_t length)
{
    int pivot;
    size_t boundary = 0;
    size_t i;

    if (length <= 1)
        return;

    pivot = items[length - 1];
    for (i = 0; i + 1 < length; i++) {
        if (items[i] <= pivot)
            swap(&items[i], &items[boundary++]);
    }
    swap(&items[length - 1], &items[boundary]);

    quicksort(items, boundary);
    quicksort(items + boundary + 1, length - boundary - 1);
}

int main(void)
{
    int numbers[] = { 5, 3, 8, 4, 2, 7, 1, 10, 9, 6 };
    size_t length = sizeof numbers / sizeof numbers[0];
    size_t i;

    quicksort(numbers, length);
    for (i = 0; i < length; i++)
        printf("%s%d", i > 0 ? " " : "", numbers[i]);
    putchar('\n');
    return 0;
}
