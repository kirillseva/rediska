#' A simple redis client for R.
#'
#' A thin wrapper around redis-cli that allows you to access redis from R.
#' You need to have redis-cli installed locally to use this package.
#'
#' Rediska provides shortcuts for most of the redis commands. However, since the
#' names of redis commands conflict with a lot of R functions they are not exported.
#' The only exported function is \code{raw_command}.
#'
#' If you want to use functions like \code{zadd}, \code{set}, etc., use them
#' like this: \code{rediska:::get("foo")}.
#'
#' The is no error handling implemented, so if you send an invalid command
#' you are going to see the error message from redis-cli.
#'
#' @examples
#' \dontrun{
#'   rediska:::set("foo", "bar")
#'   rediska:::get("foo")
#'
#'   rediska::raw_command('expire foo')
#'   # [1] "ERR wrong number of arguments for 'expire' command" ""
#' }
#'
#' @name rediska
#' @author Kirill Sevastyanenko
#' @docType package
NULL
