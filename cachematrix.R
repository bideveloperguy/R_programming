# Example usage:
# > mx <- makeCacheMatrix(matrix(rnorm(4), 2,2))  // Create the wrapped matrix
# > mx$get()                                  // Return the matrix
# > cacheSolve(mx)                            // Return the inverse
# > cacheSolve(mx)                            // Return the cached inverse

##wrapper function for matrices that provides setter/getter methods for
##the caching functionality
makeCacheMatrix <- function(x = matrix()) {
  minv <- NULL
  set <- function(y) {
    x <<- y
    minv <<- NULL
  }
  get <- function() x
  setinv <- function(invm) minv <<- invm
  getinv <- function() minv
  list(set = set, get = get,
       setinv = setinv,
       getinvn = getinv)
}


## Return a matrix that is the inverse of 'x'  
cacheSolve <- function(x, ...) {
  minv <- x$getinv()
  if(!is.null(minv)) {
    message("getting cached data")
    return(minv)
  }
  data <- x$get()
  minv <- solve(data, ...)
  x$setinv(minv)
  minv
}
