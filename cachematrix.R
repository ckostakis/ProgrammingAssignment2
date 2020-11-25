##
#These fuctions are complementary in that they allow for a matrix's inverse to be cached
#in order to avoid potentially repetitive function calls
#Example Usage
#
#1. Create some matrix which is square and invertible 
# someMatrix <- diag(10)
#2. Wrap the matrix in cache matrix
# someCacheMatrix <- makeCacheMatrix(someMatrix)
#3. Solve for the inverse but check cache first
# someMatrixInverse <- cacheSolve(someCacheMatrix)


#This function wraps around a tradition R matrix in order to allow for caching of the inverse
#it is important to note that the underlying matrix specified here as X is susceptable to dirty writes 
#if the matrix is changed without calling setinverse(NULL)
#Example Usage with identity matrix: 
#someMatrix <- makeCacheMatrix(diag(10))
makeCacheMatrix <- function(x = matrix()) {
  i <<- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function(ival) i <<- ival
  getinverse <- function() i
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


#This function will solve for the inverse of a matrix first checking to see if there is a cached 
#inverse matrix which has already been solved.  
#Note that makeCacheMatrix should be called prior to executing this fuction
#Example Usage with identity matrix:
# cacheSolve(makeCacheMatrix(diag(10)))
cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}
