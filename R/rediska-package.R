#' A simple redis client for R.
#'
#' A thin wrapper around redis-cli that allows you to access redis from R.
#' You need to have redis-cli installed locally to use this package.
#'
#' The is no error handling implemented, so if you send an invalid command
#' you are going to see the error message from redis-cli.
#'
#' @examples
#' \dontrun{
#'   rediska$set("foo", "bar")
#'   rediska$get("foo")
#'
#'   rediska$raw_command('expire foo')
#'   # [1] "ERR wrong number of arguments for 'expire' command" ""
#' }
#'
#' @name rediska_package
#' @author Kirill Sevastyanenko
#' @docType package
NULL
