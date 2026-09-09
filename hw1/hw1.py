# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "marimo>=0.23.3",
#     "matplotlib>=3.11.1",
#     "numpy==2.4.6",
#     "sympy>=1.14.0",
# ]
# ///

import marimo

__generated_with = "0.24.0"
app = marimo.App(width="columns")

with app.setup:
    import marimo as mo
    import numpy as np
    import matplotlib.pyplot as plt
    import sympy as sp


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # MATH 620 Homework 1
    Jaden Mecham
    ## Problem Statement
    A local daily newspaper with a circulation of 80,000 subscribers is thinking of raising
    its subscription price. Currently the price is $1.50 per week, and it is estimated that
    the paper would loose 5,000 subscribers if the rate were to be raised by 10 cents/week.
    Further, it is assumed that s, the number of subscribers, is a linear function of the
    subscription price.
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ## Part A
    Find the subscription price that maximizes proﬁt. Use the ﬁve-step method, and
    model as a one-variable optimization problem.
    Notes: Let x be the subscription price (dollar/paper); s be the number of subscriptions
    (papers); y be proﬁt ($). The proﬁt function for y should be a quadratic function in x
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### Step 1: Ask the Question

    ***Variables:***

    $x$ = subscription price (dollars per week)

    $s$ = number of subscriptions

    $y$ = profit (dollars per week)

    ***Assumptions:***

    $s$ is a lienar function of $x$

    $y = xs$

    $x\geq 0$

    $s\geq 0$

    ***Question:*** What is the price $x$ that maximizes profit $y$?
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### Step 2: Select Modeling Approach
    Single variable optimization
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### Step 3: Formulate the Model
    """)
    return


@app.cell
def _():
    x= sp.symbols('x')
    s = 80000 - (50000*(x-1.5))
    s
    return s, x


@app.cell
def _(s, x):
    y = s*x
    y
    return (y,)


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### Step 4: Solve the Model
    """)
    return


@app.cell
def _(x, y):
    dydx = sp.diff(y, x)
    dydx
    return (dydx,)


@app.cell
def _(dydx, x):
    solution_price = sp.solve(dydx, x)
    solution_price
    return (solution_price,)


@app.cell
def _(solution_price, x, y):
    solution_profit = y.subs(x, solution_price[0])
    solution_profit
    return (solution_profit,)


@app.cell
def _(x, y):
    original_profit = y.subs(x, 1.5)
    original_profit
    return


@app.cell
def _(solution_price, solution_profit, x, y):
    plt.plot(np.linspace(0,3.1,100), [y.subs(x,i) for i in np.linspace(0,3.1,100)])
    plt.scatter(solution_price[0], solution_profit, color='red', s=100)
    plt.xlabel('subscription price ($/week)')
    plt.ylabel('profit ($/week)')
    plt.title('Profit vs Subscription Price per Week')
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### Step 5: Answer the Question
    To maximize profits, the price of the newspaper should be increased to $1.55. This would generate a profit of $120,125. This is compared to an original profit of $120,000 when the price was $1.50.
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ## Part B
    Let $n=5,000$ denote the number of subscribers lost when the subscription price increases by ten cents.
    Calculate the optimal subscription price $x$ as a function of $n$, and use this formula to
    determine the sensitivity $S(x, n)$.
    """)
    return


@app.cell
def _(x):
    # number of subscribers as a function of price and n
    n = sp.symbols(names='n')
    sb = 80000-10*n*(x-sp.Rational(3,2))
    sb
    return n, sb


@app.cell
def _(sb, x):
    # profit as a function of price and n
    yb = sb*x
    yb
    return (yb,)


@app.cell
def _(x, yb):
    # derivative of profit with respect to price
    dybdx = sp.diff(yb, x)
    dybdx
    return (dybdx,)


@app.cell
def _(dybdx, x):
    # solve for price as a function of n
    xn=sp.solve(dybdx, x)
    xn
    return (xn,)


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    The optimal price as a function of n is
    $$
    x(n)=\frac{3}{4}+\frac{4000}{n}
    $$
    """)
    return


@app.cell
def _(n, xn):
    # derivative of price with respect to n
    dxndn = sp.diff(xn[0], n)
    dxndn
    return (dxndn,)


@app.cell
def _(dxndn, n, xn):
    # sensitivity S(x, n) = (dx/dn)(n/x), substituting x = x*(n) so S depends only on n
    S = sp.simplify(dxndn * n / xn[0])
    S
    return (S,)


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    The sensitivity of the price ti the subscriber loss rate is
    $$
    S(x,n)=\frac{-160000}{3n+160000}
    $$
    """)
    return


@app.cell
def _(S, n):
    # sensitivity at the estimated loss rate n = 5000
    S_5000 = S.subs(n, 5000)
    S_5000, float(S_5000)
    return (S_5000,)


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    The sensitivity of the optimal price to the subscriber loss rate is -0.516 when n=5000. This means that a 1% increase in $n$ drives down the optimal price by about 0.516%. This means that a higher $n$ leads to subscribers being more sensitive to price, limiting how high you can increase the price.
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ## Part C
    Use the sensitivity S(x, n) found in part (b) to predict:
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### (i)
    The eﬀect of a 20% increase in n = 5000 on the optimal subscription price x; In
    other words, what does the sensitivity give as the new optimal subscription price
    x?
    """)
    return


@app.cell
def _(S_5000):
    x_old= sp.symbols('x_old')  
    delta_n = sp.symbols('delta_n') # percent change in n
    x_new= x_old * (1 + S_5000*(delta_n))
    x_new
    return delta_n, x_new, x_old


@app.cell
def _(delta_n, solution_price, x_new, x_old):
    x_new.subs({x_old: float(solution_price[0]), delta_n: 0.2})
    return


@app.cell
def _(n, xn):
    # compare to exact solution for n = 6000
    x_exact_6000 = xn[0].subs(n, 6000)
    x_exact_6000, float(x_exact_6000)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    A 20% increase in n=5000 decreases the optimal price solution to $1.39. The sensitivity analysis has about a 2 cent discrepancy compared to the exact solution where n=6000.
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    ### (ii)
    The eﬀect of a 20% decrease in n = 5000 on the optimal subscription price x. In
    other words, what does the sensitivity give as the new optimal subscription price
    x?
    """)
    return


@app.cell
def _(delta_n, solution_price, x_new, x_old):
    x_new.subs({x_old: float(solution_price[0]), delta_n: -0.2})
    return


@app.cell
def _(n, xn):
    # compare to exact solution for n = 4000
    x_exact_4000 = xn[0].subs(n, 4000)
    x_exact_4000, float(x_exact_4000)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    A 20% decrease in n=5000 increases the optimal price to $1.71. The sensitivity analysis shows about a 4 cent difference compareed to the exact solution where n=4000.
    """)
    return


if __name__ == "__main__":
    app.run()
