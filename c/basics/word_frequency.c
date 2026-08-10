/* Count the words of a fixed text, most frequent first and alphabetically within a tie. */
/* The C standard library has no map, so the counts live in a linear array. */
/* Build: cc -o word_frequency word_frequency.c */

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORDS 64
#define MAX_WORD_LENGTH 32

struct entry {
    char word[MAX_WORD_LENGTH];
    int count;
};

static struct entry entries[MAX_WORDS];
static size_t entry_count;

static void count_word(const char *word)
{
    size_t i;

    for (i = 0; i < entry_count; i++) {
        if (strcmp(entries[i].word, word) == 0) {
            entries[i].count++;
            return;
        }
    }
    if (entry_count == MAX_WORDS)
        return;

    snprintf(entries[entry_count].word, MAX_WORD_LENGTH, "%s", word);
    entries[entry_count].count = 1;
    entry_count++;
}

static int by_count_then_word(const void *left, const void *right)
{
    const struct entry *a = left;
    const struct entry *b = right;

    if (a->count != b->count)
        return b->count - a->count;
    return strcmp(a->word, b->word);
}

int main(void)
{
    char text[] = "the quick brown fox jumps over the lazy dog the fox barks";
    char *word;
    size_t i;

    for (word = strtok(text, " "); word != NULL; word = strtok(NULL, " "))
        count_word(word);

    qsort(entries, entry_count, sizeof entries[0], by_count_then_word);
    for (i = 0; i < entry_count; i++)
        printf("%s %d\n", entries[i].word, entries[i].count);
    return 0;
}
