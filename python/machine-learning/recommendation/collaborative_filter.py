from recommendation_data import dataset
from math import sqrt

print(("Lisa Rose rating on Lady in the water: {}\n".format(
    dataset['Lisa Rose']['Lady in the Water'])))
print(("Michael Phillips rating on Lady in the water: {}\n".format(
    dataset['Michael Phillips']['Lady in the Water'])))

print('**************Jack Matthews ratings**************')
print((dataset['Jack Matthews']))

# Implementation of collaborative filtering recommendation engine

def similarity_score(person1, person2):

    # Returns ratio Euclidean distance score of person1 and person2

    both_viewed = {}  # To get both rated items by person1 and person2

    for item in dataset[person1]:
        if item in dataset[person2]:
            both_viewed[item] = 1

    # Conditions to check they both have an common rating items
    if len(both_viewed) == 0:
        return 0

    # Finding Euclidean distance
    sum_of_eclidean_distance = []

    for item in dataset[person1]:
        if item in dataset[person2]:
            sum_of_eclidean_distance.append(
                pow(dataset[person1][item] - dataset[person2][item], 2))
        total_of_eclidean_distance = sum(sum_of_eclidean_distance)

    return 1 / (1 + sqrt(total_of_eclidean_distance))

def pearson_correlation(person1, person2):

    # To get both rated items
    both_rated = {}
    for item in dataset[person1]:
        if item in dataset[person2]:
            both_rated[item] = 1

    number_of_ratings = len(both_rated)

    # Checking for number of ratings in common
    if number_of_ratings == 0:
        return 0

    # Add up all the preferences of each user
    person1_preferences_sum = sum(
        [dataset[person1][item] for item in both_rated])
    person2_preferences_sum = sum(
        [dataset[person2][item] for item in both_rated])

    # Sum up the squares of preferences of each user
    person1_square_preferences_sum = sum(
        [pow(dataset[person1][item], 2) for item in both_rated])
    person2_square_preferences_sum = sum(
        [pow(dataset[person2][item], 2) for item in both_rated])

    # Sum up the product value of both preferences for each item
    product_sum_of_both_users = sum(
        [dataset[person1][item] * dataset[person2][item] for item in both_rated])

    # Calculate the pearson score
    numerator_value = product_sum_of_both_users - \
        (person1_preferences_sum * person2_preferences_sum / number_of_ratings)
    denominator_value = sqrt((person1_square_preferences_sum - pow(person1_preferences_sum, 2) / number_of_ratings) * (
        person2_square_preferences_sum - pow(person2_preferences_sum, 2) / number_of_ratings))
    if denominator_value == 0:
        return 0
    else:
        r = numerator_value / denominator_value
        return r

print(pearson_correlation('Lisa Rose', 'Gene Seymour'))
