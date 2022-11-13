from brownie import Squirrel, accounts

def main():
    account = accounts.load('dev')
    Squirrel.deploy({'from': account})