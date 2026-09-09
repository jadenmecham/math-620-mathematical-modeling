# ============================================================
# MATH 620 Homework 1
# Jaden Mecham
#
# Maple translation of hw1.py (marimo notebook).
# Each section below corresponds to one cell of the notebook, in order.
# ============================================================
#
# PROBLEM STATEMENT
#
# A local daily newspaper with a circulation of 80,000 subscribers is
# thinking of raising its subscription price. Currently the price is $1.50
# per week, and it is estimated that the paper would loose 5,000 subscribers
# if the rate were to be raised by 10 cents/week. Further, it is assumed
# that s, the number of subscribers, is a linear function of the
# subscription price.
# ============================================================

restart;

# ============================================================
# PART A
#
# Find the subscription price that maximizes profit. Use the five-step
# method, and model as a one-variable optimization problem.
#
# Notes: Let x be the subscription price (dollar/paper); s be the number of
# subscriptions (papers); y be profit ($). The profit function for y should
# be a quadratic function in x.
# ============================================================

# ------------------------------------------------------------
# Step 1: Ask the Question
#
# Variables:
#   x = subscription price (dollars per week)
#   s = number of subscriptions
#   y = profit (dollars per week)
#
# Assumptions:
#   s is a linear function of x
#   y = x*s
#   x >= 0
#   s >= 0
#
# Question: What is the price x that maximizes profit y?
# ------------------------------------------------------------

# ------------------------------------------------------------
# Step 2: Select Modeling Approach
#
# Single variable optimization
# ------------------------------------------------------------

# ------------------------------------------------------------
# Step 3: Formulate the Model
# ------------------------------------------------------------

# NOTE: Maple needs no equivalent of `x = sp.symbols('x')` -- after restart,
# any unassigned name is already a symbol.
s := 80000 - (50000*(x - 1.5));

y := s*x;

# ------------------------------------------------------------
# Step 4: Solve the Model
# ------------------------------------------------------------

dydx := diff(y, x);

# NOTE: Maple's solve returns the root itself, not a list, so there is no
# equivalent of the `solution_price[0]` indexing used in the Python.
solution_price := solve(dydx = 0, x);

solution_profit := eval(y, x = solution_price);

original_profit := eval(y, x = 1.5);

plots[display](
    plot(y, x = 0 .. 3.1),
    plots[pointplot]([[solution_price, solution_profit]],
                     color = red, symbol = solidcircle, symbolsize = 20),
    labels = ["subscription price ($/week)", "profit ($/week)"],
    title  = "Profit vs Subscription Price per Week"
);

# ------------------------------------------------------------
# Step 5: Answer the Question
#
# To maximize profits, the price of the newspaper should be increased to
# $1.55. This would generate a profit of $120,125. This is compared to an
# original profit of $120,000 when the price was $1.50.
# ------------------------------------------------------------

# ============================================================
# PART B
#
# Let n = 5,000 denote the number of subscribers lost when the subscription
# price increases by ten cents. Calculate the optimal subscription price x
# as a function of n, and use this formula to determine the sensitivity
# S(x, n).
# ============================================================

# number of subscribers as a function of price and n
sb := 80000 - 10*n*(x - 3/2);

# profit as a function of price and n
yb := sb*x;

# derivative of profit with respect to price
dybdx := diff(yb, x);

# solve for price as a function of n
xn := simplify(solve(dybdx = 0, x));

# ------------------------------------------------------------
# The optimal price as a function of n is
#
#   x(n) = 3/4 + 4000/n
# ------------------------------------------------------------

# derivative of price with respect to n
dxndn := diff(xn, n);

# sensitivity S(x, n) = (dx/dn)(n/x), substituting x = x*(n) so S depends
# only on n
S := simplify(dxndn * n / xn);

# ------------------------------------------------------------
# The sensitivity of the price to the subscriber loss rate is
#
#   S(x,n) = -16000 / (3*n + 16000)
# ------------------------------------------------------------

# sensitivity at the estimated loss rate n = 5000
S_5000 := eval(S, n = 5000);
evalf(S_5000);

# ------------------------------------------------------------
# The sensitivity of the optimal price to the subscriber loss rate is
# -0.516 when n = 5000. This means that a 1% increase in n drives down the
# optimal price by about 0.516%. This means that a higher n leads to
# subscribers being more sensitive to price, limiting how high you can
# increase the price.
# ------------------------------------------------------------

# ============================================================
# PART C
#
# Use the sensitivity S(x, n) found in part (b) to predict:
# ============================================================

# ------------------------------------------------------------
# (i)
# The effect of a 20% increase in n = 5000 on the optimal subscription
# price x; In other words, what does the sensitivity give as the new
# optimal subscription price x?
# ------------------------------------------------------------

# NOTE: x_old and delta_n need no declaration in Maple; unassigned names are
# symbols already.  delta_n is the percent change in n.
x_new := x_old * (1 + S_5000*(delta_n));

eval(x_new, [x_old = solution_price, delta_n = 0.2]);

# compare to exact solution for n = 6000
x_exact_6000 := eval(xn, n = 6000);
evalf(x_exact_6000);

# ------------------------------------------------------------
# A 20% increase in n = 5000 decreases the optimal price solution to $1.39.
# The sensitivity analysis has about a 2.7 cent discrepancy compared to the
# exact solution where n = 6000.
# ------------------------------------------------------------

# ------------------------------------------------------------
# (ii)
# The effect of a 20% decrease in n = 5000 on the optimal subscription
# price x. In other words, what does the sensitivity give as the new
# optimal subscription price x?
# ------------------------------------------------------------

eval(x_new, [x_old = solution_price, delta_n = -0.2]);

# compare to exact solution for n = 4000
x_exact_4000 := eval(xn, n = 4000);
evalf(x_exact_4000);

# ------------------------------------------------------------
# A 20% decrease in n = 5000 increases the optimal price to $1.71. The
# sensitivity analysis shows about a 4 cent difference compared to the exact
# solution where n = 4000.
# ------------------------------------------------------------
