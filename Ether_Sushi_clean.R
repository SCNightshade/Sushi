
#Cleaning workplace
rm(list=ls())

#Source
source("EtherscanR.R") #Put ERC20_Clean in dirkschumacher/etherscanr and import it.
#API KEY
etherscan_set_api_key("KEY")

#Setting address
address <- "0x19B3Eb3Af5D93b77a5619b047De0EED7115A19e7" #Operation address from sushi on ETH chain

#Calling etherscan_transactions
txs_address <- etherscan_transactions(address) #No out transactions so go to ERC20

#Calling ether
balance <- ERC20_transactions(account = address, offset = 10000)

#Sellecitn only out
balance_2 <- balance[balance$from == address, 1:ncol(balance)] 
#Callculating gas in Ether is to_ether("gasUsed*gasPrice")
Gas_ERC20 <- sum(as.numeric(to_ether(as.character(as.numeric(balance_2$gasUsed[]) * as.numeric(balance_2$gasPrice[]))))) #Gass is as string
#Gas_ERC20 contains the total gass used of operation wallet for the ERC20 tokens
  #35.54914 Ether /697 days of ERC20 txs * 365 = 18.61612 Ether used for gas per year for ERC20 tokens

#Internal transactions
balance_internal <- etherscan_internal_transactions(account = address)
