from brownie import Squirrel, accounts

def main():
    account = accounts.load('dev')
    Squirrel.deploy(
        "0x65D66c76447ccB45dAf1e8044e918fA786A483A1",
        "0x8ad599c3A0ff1De082011EFDDc58f1908eb6e6D8",
        "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
        "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
        {'from': account},
        publish_source=True,
    )
