options(scipen = 999)
set.seed(45)

# Step One - Function that evaluates old(current) value with the new (proposed) value
# Temperature at each iteration is used to derive a probability(threshold) of acceptance.
function.accept = function(current.v, new.v,temp.v) {
  prob = 0
  if (new.v < current.v){
    break()}  
  if (temp.v == 0){
    break()}
  {
    prob = exp(-(new.v - current.v) / temp.v)
  }
  return(prob)
}

# Step Two - function.f represents the function f(X1, X2, X3) = X1^2 + X2^2 + X3^2. Returns the function output
# This is the function from the homework assignment. 
function.f = function(k1,k2,k3) {
  {k = k1^2 + k2^2 +k3^2}
  return(k) 
}

# Step Three - function.rand is the one that assigns random values between -10 and +10 to the 3 variables in the original function function.f 
# The absolute value of the random number generated is what the Simulated Annealing function uses, since the main function anyways wants the square of this value. 
function.rand = function() {
  x = runif(1, -10.0, 10.0)
   return(c(x))
}


# Step Four - function.SA is the Simulated Annealing function, that takes function.f as input. 
# The number of iterations and the step value of temperature are also parameters of SA function. 
# Note - iterator * stepv = 1 
(1 - 0.01)^1


function.SA = function(function.r,function.a, iterator, step.V = 0.01) {
  
  # Initialize
  # s stands for state
  # b stands for best
  # c stands for current
  # n stands for neighbor
  # all variables are given the absolute value of the random number
  best.s = current.s =  neighbor.s = init.s= abs(function.r())
 
  message("It\tBest\tCurrent\tNeigh\tTemp")
  message(sprintf("%i\t%.4f\t%.4f\t%.4f\t%.4f", 0L, best.s,current.s,neighbor.s, 1))
  
  for (i in 1:iterator) {     
    temp.T = (1 - step.V)^(i/10)
    # consider a random neighbor near the current value of the state variable.
    # The absolute value of the neighbor is again used for comparison
   
    neighbor.s = abs(rnorm(1, current.s, 0.4))
    
    # update current state
    if (neighbor.s < current.s || runif(1, 0, 1) < function.a(current.s,neighbor.s,temp.T )) {
      current.s = neighbor.s
      
    }
    # update best state
    if (neighbor.s < best.s) {
      best.s = neighbor.s
    }
    message(sprintf("%i\t%.4f\t%.4f\t%.4f\t%.4f", i, best.s, current.s, neighbor.s, temp.T))
  }
  return(list(initial.X1=init.s, best.state = best.s))
}

# Step Five -  Finally, the SA functin is fed into a main function, and controlled by the number of iteration needed


function.main = function(iterator) {
X1 = function.SA(function.rand,function.accept,iterator)
X2 = function.SA(function.rand,function.accept,iterator)
X3 = function.SA(function.rand,function.accept,iterator)
min.val = (X1$best.state^2)+(X2$best.state^2)+(X3$best.state^2)
message("Minimized\t  BestX1\t  BestX2\t  BestX3")
message(sprintf("%.12f\t%.9f\t%.9f\t%.9f", min.val, X1$best.state,X2$best.state,X3$best.state))
}

# Step 6- Calling the main function with an iteration of 500
function.main(500)









