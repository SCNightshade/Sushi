
#Making the ERC20-transaction function that pulls all transactions based on the address
#It is based on dirkschumacher/etherscanr

ERC20_transactions <- function(account, startblock = 0,
                               endblock = 999999999,
                               offset = 1000,
                               page = 1,
                               api_key = etherscan_get_api_key()) {
  stopifnot(length(account) == 1, is.character(account))
  stopifnot(startblock >= 0)
  stopifnot(endblock > startblock)
  url <- append_api_key(paste0("https://api.etherscan.io/api?module=account&action=tokentx",
                               "&address=", account,
                               "&startblock=", as.integer(startblock),
                               "&endblock=", as.integer(endblock),
                               "&sort=asc",
                               "&page=", as.integer(page),
                               "&offset=", as.integer(offset)), api_key)
  res <- jsonlite::fromJSON(url)
  data.frame(
    blockNumber = as.integer(res$result$blockNumber),
    timeStamp = as.POSIXct(as.numeric(res$result$timeStamp), origin = "1970-01-01"),
    hash = res$result$hash,
    nonce = as.integer(res$result$nonce),
    blockHash = res$result$blockHash,
    from = res$result$from,
    to = res$result$to,
    value = res$result$value,
    tokenName = res$result$tokenName,
    tokenSymbol = res$result$tokenSymbol,
    tokenDecimal = as.integer(res$result$tokenDecimal),
    transactionIndex = as.integer(res$result$transactionIndex),
    gas = res$result$gas,
    gasPrice = res$result$gasPrice,
    #isError = res$result$isError == "1",
    input = res$result$input,
    contractAddress = res$result$contractAddress,
    cumulativeGasUsed = res$result$cumulativeGasUsed,
    gasUsed = res$result$gasUsed,
    confirmations = as.integer(res$result$confirmations),
    stringsAsFactors = FALSE
  )
}
