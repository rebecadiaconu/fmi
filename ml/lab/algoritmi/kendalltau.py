from scipy.stats import kendalltau

y = [23, 14, 30, 45, 18, 31]
p = [26, 20, 39, 38, 18, 33]


print(kendalltau(y, p))