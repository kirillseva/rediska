#' Execute raw redis command
#'
#' @export
#' @param command character. The command string that sould be executed
#' @return The response from redis-cli
#' @examples
#' \dontrun{
#'   rediska:::raw_command("PING")
#'   # [1] "PONG"
#' }
raw_command <- function(command) {
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
  ll <- length(command_names)
  for(i in 1:ll) {
    fName <- command_names[i]
    assign(fName, eval(substitute(
      function(...) {
        raw_command(paste(tt, paste(..., collapse = " ")))
      },
      list(tt=command_names[i])
     )), envir=parent.frame()
    )
  }
}

# Do not call this function unless you know what you are doing
hacky_documentation <- function() {
  namespace = "NAMESPACE"
  write("\n# PLEASE DON'T REPEAT THIS AT HOME", namespace, append = TRUE)
  for(name in command_names) {
    write(paste0("export(", name, ")"), namespace, append = TRUE)
  }
  write("\n# I DON'T KNOW WHAT I'M DOING", namespace, append = TRUE)
}

generate_functions()
