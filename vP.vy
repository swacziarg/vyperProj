odds: public(uint256)
playersTurn: public(uint256)
players: public(DynArray[address, 100])
creator: public(address)
losers: public(DynArray[address, 100])
numP: public(uint256)

@external
def __init__():
    self.creator = tx.origin

@external
def setOdds(__odds: uint256):
    self.odds = __odds

@external
def addPlayer(__player: address):
    assert __player not in self.players
    assert __player not in self.losers
    self.players[self.numP] = __player
    self.numP = self.numP +1


@internal
def lose(__player: address):
    self.players.clear
    self.losers.push(__player)

@internal
def random ():
    return self.odds - 1

@external
def play ():
    ran : uint256
    ran = self.random()
    nex : address = self.players.pop()
    if ran == 1:
        self.lose(nex)
    if ran != 1:
        self.playersTurn = self.playersTurn + 1
        if self.playersTurn == len(self.players) - 1:
            self.playersTurn = 0

@external
def isALoser (person:address):
    if person in self.losers:
        return true
    return false
