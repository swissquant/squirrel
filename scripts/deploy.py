from brownie import Squirrel, accounts

def main():
    account = accounts.load('dev')
    Squirrel.deploy(
        "0x50f3D0826d4E3c3d49007DBa664727B9885Dd734", # Controller's address
        {'from': account},
        publish_source=True,
    )
