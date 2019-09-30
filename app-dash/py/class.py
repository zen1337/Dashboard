class userStatus:
    
    userCounter = 1

    def __init__(self, name, team_n, status, time = 0):

        # User details
        self.name = name
        self.team_n = team_n
        self.status = status
        self.time = time

        # Keep track of user id
        self.id = userStatus.userCounter
        userStatus.userCounter +=1

        # Keep track of all user in simple list:
        self.users = []

    def printStatus(self):
        print("User name: %s" % self.name)
        print("Team: %d" % self.team_n)
        print("Status: %s" % self.status)
        print("Online time: %d" % self.time)
        for user in self.users:
            print(user.name)

    def changeStatus(self):
        usr = input("To edit a user, enter username : ")
        try: 
            if usr == self.name: 
                sts = input("Y/N to change status: ")
                if sts == "Y":
                    print("done")
        except:
            print("Wrong username")

    def changeTeam(self):
        usr = input("To edit a user, enter a username: ")
        try:
            if usr == self.name:
                number = input("Enter team id, 1 = WAF, 2 = AF, 3 = DDOS: ")
                try:
                    if number == 1 or 2 or 3:
                        self.team_n = number
                        print("Team id for " + self.name + " changed to " + self.team_n)
                except:
                    print("Only numbers from 1 - 3 allowed")
        except:
            print("Wrong username")
    def changeTime(self, time):
        self.time = int(time)
        print("Online time for user " + self.name + " changed to " + str(self.time))

    def add_user(self, u):
        self.users.append(u)
        u.user_id = self.id

class user:

    def __init__(self, name):
        self.name = name

def main():

    u1 = userStatus("adam", 1, "Online")
    stat = input("Would you like to change status?(Y/N)")
    if stat == "Y":
        u1.changeStatus()
    else:
        pass
    tm = input("Would you like to change team?(Y/N)")
    if tm == "Y":
        u1.changeTeam()
    else:
        pass
    time_one = input("Would you like to change online time?(Y/N)")
    if time_one == "Y" or time_one == "y":
        time_change = input("Input time in minutes: ")
        u1.changeTime(time_change)
    else:
        pass
    usr = input("Enter name of new user or exit :")
    if type(usr) == str:
        usr = user(usr)
        u1.add_user(usr)
    else:
        return "Woop no numbers dude"
    u1.printStatus()
if __name__ == "__main__":
    main()
