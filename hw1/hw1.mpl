# MATH 620 Homework 1 -- Jaden Mecham
# Maple translation of hw1.py
#
# Exact rationals (3/2, 31/20) are used instead of decimals so that Maple
# returns exact answers; evalf() is applied only where a decimal is wanted.

restart;

##############################################################
# Part A -- five-step method
##############################################################

# --- Step 3: Formulate the model ---

# s = number of subscribers, a linear function of the price x.
# Losing 5000 subscribers per $0.10 is a slope of -5000/0.10 = -50000 per dollar,
# through the known point (3/2, 80000).
s := 80000 - 50000*(x - 3/2);

# Profit = price * subscribers.  No cost data is given anywhere in the problem,
# so costs are taken to be zero (or fixed) and profit equals revenue.
y := expand(s*x);

# The assumption s >= 0 bounds the price from above, closing the domain:
xmax := solve(s = 0, x);                 # expect 31/10 = 3.10

# --- Step 4: Solve the model ---

dydx := diff(y, x);
xstar := solve(dydx = 0, x);             # expect 31/20 = 1.55
ystar := eval(y, x = xstar);             # expect 120125

# Verify the critical point is a MAXIMUM: second derivative is negative
# everywhere, so y is concave down and the vertex is the global max.
d2ydx2 := diff(y, x, x);                 # expect -100000

# Endpoint check on [0, 31/10]: profit vanishes at both ends, so the
# interior critical point is the global maximum.
y_left  := eval(y, x = 0);               # expect 0
y_right := eval(y, x = xmax);            # expect 0

# Profit at the current price, for comparison
y_current := eval(y, x = 3/2);           # expect 120000

# Plot, with the optimum marked
plots[display](
    plot(y, x = 0 .. xmax,
         labels = ["subscription price ($/week)", "profit ($/week)"]),
    plots[pointplot]([[xstar, ystar]],
         symbol = solidcircle, symbolsize = 20, color = red),
    title = "Profit vs Subscription Price"
);

##############################################################
# Part B -- optimal price as a function of n, and sensitivity
##############################################################

# n = subscribers lost per $0.10 increase, so the slope is -n/0.10 = -10*n
# per dollar.  Setting n = 5000 recovers the -50000 used in Part A.
sB := 80000 - 10*n*(x - 3/2);
yB := expand(sB*x);

dyBdx := diff(yB, x);
xn := simplify(solve(dyBdx = 0, x));     # expect 3/4 + 4000/n

# Consistency check against Part A
xn_at_5000 := eval(xn, n = 5000);        # expect 31/20 = 1.55

# Sensitivity S(x,n) = (dx/dn)*(n/x), with x replaced by x*(n) so that the
# result is a function of n alone.
dxndn := diff(xn, n);                    # expect -4000/n^2
Sxn := simplify(dxndn * n / xn);         # expect -16000/(3*n + 16000)

S5000 := eval(Sxn, n = 5000);            # expect -16/31
S5000_decimal := evalf(S5000);           # expect -0.5161290323

##############################################################
# Part C -- predictions from the sensitivity
##############################################################

# Relation:  x_new = x_old * (1 + S * (relative change in n))
xold := eval(xn, n = 5000);              # 31/20
xnew := xold*(1 + S5000*dn);             # dn = relative change in n

# (i) a 20% INCREASE in n
x_pred_up  := evalf(eval(xnew, dn = 1/5));       # expect 1.39
x_exact_up := evalf(eval(xn, n = 6000));         # expect 1.416666667
err_up     := evalf(x_exact_up - x_pred_up);     # expect 0.0266666 (2.7 cents)

# (ii) a 20% DECREASE in n
x_pred_down  := evalf(eval(xnew, dn = -1/5));    # expect 1.71
x_exact_down := evalf(eval(xn, n = 4000));       # expect 1.75
err_down     := evalf(x_exact_down - x_pred_down); # expect 0.04 (4 cents)

# Both predictions land BELOW the exact value because x*(n) is convex in n
# (positive second derivative), so the tangent-line approximation that the
# sensitivity represents always underestimates it.
convexity := diff(xn, n, n);             # expect 8000/n^3 > 0 for n > 0

##############################################################
# Optional: emit LaTeX for a typeset report
##############################################################
# latex(y);
# latex(xn);
# latex(Sxn);
