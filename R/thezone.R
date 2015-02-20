zone_fn <- function(...) {
  if(rediska$get(getOption("rediska.exitthezone")) == "EXIT") {
    rediska$set(getOption("rediska.exitthezone"), "START")
    return(FALSE)
  }

  channel <- getOption("rediska.channel")
  threshold <- as.numeric(getOption("rediska.msg_threshold"))
  messages <- c()
  while(as.numeric(rediska$llen(channel)) > 0) {
    messages <- c(messages, rediska$rpop(channel))
  }
  if (length(messages) > threshold)
    message(paste("You have a lot of messages. Only showing last", threshold))
  count <- ifelse(length(messages) > threshold, threshold, length(messages))
  for (i in 1:count) {
    message(messages[i])
  }
  TRUE
}

#' Live in the zone
#'
#' This function adds a callback to every task that will read messages from
#' a redis list and write them to your R console. Useful to pipe notifications
#' from other processes and stay in the zone.
#'
#' @usage
#' Set the following parameters:
#' rediska.channel - the name of the list to which other processes should lpush.
#' rediska.msg_threshold - maximum number of messages to be shown. If there are more messages a warning will be shown.
#' rediska.exitthezone - name of the variable through which one can signal rediska to exit the zone.
#'
#' @export
enterthezone <- function() {
  rediska$set(getOption("rediska.exitthezone"), "START")
  invisible(addTaskCallback(zone_fn))
}

#' Exit the zone
#'
#' @export
exitthezone <- function() {
  message("Enjoy the reality")
  invisible(rediska$set(getOption("rediska.exitthezone"), "EXIT"))
}
