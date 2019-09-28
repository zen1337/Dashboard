class userStatus:

    def __init__(self, name, team_n, status):
        self.name = name
        self.team_n = team_n
        self.status = status

    def printStatus(self):
        print("User name: %s" % self.name)
        print("Team: %d" % self.team_n)
        print("Status: %s" % self.status)
    
def main():

    u1 = userStatus("adam", 1, "Online")
    u1.printStatus()

if __name__ == "__main__":
    main()
