/* Sort a fixed array in place with a quicksort over a Lomuto partition. */
/* Build: cc -o quicksort quicksort.c */

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
