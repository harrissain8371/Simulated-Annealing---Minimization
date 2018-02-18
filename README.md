# Simulated-Annealing---Minimization
Minimization Using Simulated Annealing Algorithm

Introduction:
Simulated annealing (SA) is a probabilistic technique for approximating the global optimum of a given function. Specifically, it is a metaheuristic to approximate global optimization in a large search space. It is often used when the search space is discrete ( wikipedia)

This example shows how to create and minimize an objective function using Simulated Annealing.

Problem Description:
Solve the following problem using simulated annealing (SA):
Minimize f(X1, X2, X3) = X12 + X22 + X32 for -10.0 <= Xi <= 10.0, i = 1, 2, 3.
That is, the goal is to find values of X1, X2, and X3 (in the given interval) that will cause f(.,.,.) to have the minimum value.

• Choosing the initial temperature

The SA function gets a parameter ‘Step.V’ that could be given an initial value when calling the SA function.
function.SA = function(function.r,function.a, iterator, step.V = 0.01)
Here, the default is 0.01, which means the Temp will be 0.99 (because temp.T = (1 - step.V)^(i/10) where i (iterator) starts at 1
Converting all into numeric values, (1 - 0.01)^(1/10) = 0.9989955 at the first iteration. The idea is to give enough room for the program to run before probability of acceptance of a neighboring value (new value) becomes zero in, let us say, a fairly large number of iterations. Temperature T is very very slowly brought down when (1-stepValue)^i/10 is used to calculate the iteration i’s probability.


• Choosing the stopping condition

     In the function function.accept (which decides to accept the new value from the neighborhood or not), there is a break condition for       temperator T =0.
     In the SA function, iterator is set when calling the SA function. In the attached R code, iterator is 500. This means the SA               function will run for 500 times. This can be varied, to increase/decrease the runtime.

• Choosing the next point (neighbor)

Using rnorm function in R
neighbor.s = abs(rnorm(1, current.s, 0.4))
The absolute value is taken, as the evaluation function uses only the squares of the value of each variable X1, X2, X3. In the code, using a standard deviation of 0.4. This seems to be reasonable.


• Choosing the number of iterations spent at a fixed temperature.

This is a function of runif in R.
if (neighbor.s < current.s || runif(1, 0, 1) < function.a(current.s,neighbor.s,temp.T )) {
current.s = neighbor.s

What it means is, a uniform number between 0 and 1 is generated (for each iteration) as a random probability of acceptance, and then this value is compared with the probability value returned by the acceptance function. Acceptance function returns a probability value depending on:
             Current value of the variable Xi
             Neighbor value and,
             Value of temperature T
            
• Notes for any other special issues/techniques that you think might be important in your implementation.

The only thing I realized when writing the program is that this seemingly simple problem can really put a stress on the computer. Currently the program is set with an iteration of 500 for each of X1, X2 and X3. 1500 runs of the program completes in under a minute. If the number of iterations is increased to 1000, the result is more precise.
              With 500 iterations each: Minimized BestX1 BestX2 BestX3 0.000053046 0.004205011 0.004205011 0.004205011
              With 1000 iterations each: Minimized BestX1 BestX2 BestX3 0.000006499 0.001471892 0.001471892 0.001471892
              With 3000 iterations each: Minimized BestX1 BestX2 BestX3 0.000000120949 0.000018914 0.000159373 0.000308531
              
That means there is a lot of room for tuning the program for optimal results. However, 1000 iterations each takes about 2+ minute in a 2 core laptop. Similarly, it took 4 minutes to complete 3000 iterations of refined code. 
The computer runs the iterations in spasms. This could be related to paging-swapping, cycle-time contention etc…
