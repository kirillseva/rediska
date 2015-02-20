#' An environment that contains methods for reading from / writing to redis
#'
#' You can see the list of all available functions by executing \code{rediska:::command_names}.
#'
#' @usage
#' rediska$ping()
#' rediska$set("foo", "bar")
#' rediska$set(c("bar", "baz"))
#' rediska$get("foo")
#'
#' # You can also use
#' rediska$raw_command("SET foo bar")
#'
#' @export
rediska <- new.env()

rediska$raw_command <- function(command) {
  command_string <- paste("redis-cli", command)
  system(command_string, intern = TRUE)
}

# multi and exec are not supported for now
# subscribe and monitor are not supported for now. But you can publish!
command_names <- unique(c(
  "get", "set", "setnx", "setex", "append", "strlen", "del", "exists", "setbit", "getbit", "setrange", "getrange", "substr",
  "incr", "decr", "mget", "rpush", "lpush", "rpushx", "lpushx", "linsert", "rpop", "lpop", "brpop", "brpoplpush", "blpop", "llen", "lindex",
  "lset", "lrange", "ltrim", "lrem", "rpoplpush", "sadd", "srem", "smove", "sismember", "scard", "spop", "srandmember", "sinter", "sinterstore",
  "sunion", "sunionstore", "sdiff", "sdiffstore", "smembers", "zadd", "zincrby", "zrem", "zremrangebyscore", "zremrangebyrank", "zunionstore",
  "zinterstore", "zrange", "zrangebyscore", "zrevrangebyscore", "zcount", "zrevrange", "zcard", "zscore", "zrank", "zrevrank", "hset", "hsetnx",
  "hget", "hmset", "hmget", "hincrby", "hdel", "hlen", "hkeys", "hvals", "hgetall", "hexists", "incrby", "decrby", "getset", "mset", "msetnx",
  "randomkey", "select", "move", "rename", "renamenx", "expire", "expireat", "keys", "dbsize", "auth", "ping", "echo", "save", "bgsave",
  "bgrewriteaof", "shutdown", "lastsave", "type", "discard", "sync", "flushdb", "flushall", "sort", "info", "ttl",
  "persist", "slaveof", "debug", "config", "publish", "restore", "migrate", "dump", "object", "client"
))

generate_functions <- function() {
  for(i in 1:length(command_names)) {
    assign(command_names[i], eval(substitute(
      function(...) {
        rediska$raw_command(paste(tt, paste(..., collapse = " ")))
      },
      list(tt=command_names[i])
     )), envir=rediska
    )
  }
}

generate_functions()
