import marimo

__generated_with = "0.23.9"
app = marimo.App()


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    # MATH 620 Homework 2
    Jaden Mecham
    """)
    return


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    ## Problem Statement
    A manufacturer of tablet computers currently sells 10,000 units per month
    of a basic model. The cost of manufacture is $700/unit and the wholesale
    price is $950. During the last quarter the manufacturer lowered the price
    $100 in a few test markets, and the result was a 50% increase in sales—
    we will call this the price elasticity. The company has been advertising its
    products nationwide at a cost of $50,000 per month. The advertising agency
    claims that increasing the advertising budget by $5,000/month would result
    in a sales increase of 100 units/month. Management has agreed to consider
    an increase in the advertising budget to no more than $75,000/month.
    """)
    return


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    ## Part A
    Determine the price and the advertising budget that will maximize
    profit. Use the five-step method. Model as a constrained optimization
    problem. Include both a 3d plot and a contour plot of the profit func-
    tion. In your search for the location of the optimal profit, be certain
    to

    • examine the interior of the feasible region and
    • examine the boundary of the feasible region using the Lagrange
    Multiplier Method when and where appropriate. If you dismiss
    part of the boundary from further consideration without applica-
    tion of the Lagrange Multiplier Method, explain why.
    """)
    return


@app.cell
def _():
    return


if __name__ == "__main__":
    app.run()
