
# http://www.mickaellegal.com/blog/2014/1/30/how-to-build-a-recommender

# Importing the libraries
from scipy.stats.stats import pearsonr
import pandas as pd

data = pd.read_csv("data_books.csv", sep=",", header=None,
                   names=['Reviewer', 'Book', 'Rating'])

# Picking 2 books
book_1 = "Harry Potter and the Chamber of Secrets (Book 2)"
book_2 = "Harry Potter and the Sorcerer's Stone (Harry Potter (Paperback))"

# Getting all the reviewers for these books
book_1_reviewers = data[data.Book == book_1].Reviewer
book_2_reviewers = data[data.Book == book_2].Reviewer

# Look for common reviewers
common_reviewers = set(book_1_reviewers).intersection(book_2_reviewers)

# Let's create a function that collect the reviews of our common reviewers
def get_book_reviews(title, common_reviewers):
    reviewer_books = (data.Reviewer.isin(common_reviewers)) & (
        data.Book == title)
    reviews = data[reviewer_books].sort('Reviewer')
    reviews = reviews[reviews.Reviewer.duplicated() == False]
    return reviews

# Let's extract the reviews for our 2 Harry potter books
book_1_reviews = get_book_reviews(book_1, common_reviewers)
book_2_reviews = get_book_reviews(book_2, common_reviewers)

# We compute the Pearson Correlation Score
correlation_coefficient = pearsonr(
    book_1_reviews.Rating, book_2_reviews.Rating)[0]

# We know how they related
print(correlation_coefficient)
