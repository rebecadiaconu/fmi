import bcrypt
import os

def check_password():
    no_of_tries = 3
    f = open("data/input.txt", "r")
    user = f.readline()[:-1].encode('utf-8')
    pwd = f.readline().encode('utf-8')

    while no_of_tries > 0:
        username = input("Username: ").encode('utf-8')
        password = input("Password: ").encode('utf-8')

        if bcrypt.checkpw(password, pwd) and bcrypt.checkpw(username, user):
            print("Welcome!")
            return 1
        else:
            print("Wrong username or password!")
            print("Try again!")
            no_of_tries -= 1

    if no_of_tries == 0:
        print("Seems like you don't know your data account...")
        print("We can't let you in.")
        return 0

    return 0


def get_access():
    path = "data"
    found_file = 0

    entries = os.scandir(path)

    for entry in entries:
        if entry.is_file() and entry.name == "input.txt":
            found_file = 1
            break

    if found_file == 1:
        if check_password() == 1: return 1
        else: return 0
    else:
        print("Ups! You don't have an account! Let's set a password!")
        new_username = input("Username: ").encode('utf-8')
        new_password = input("Your password: ").encode('utf-8')

        hashed_username = bcrypt.hashpw(new_username, bcrypt.gensalt())
        hashed_password = bcrypt.hashpw(new_password, bcrypt.gensalt())

        os.mkdir("notes")
        f_new = open("data/input.txt", "w")
        f_new.write(str(hashed_username)[2:-1] + "\n")
        f_new.write(str(hashed_password)[2:-1])
        f_new.close()

        return 1


def something_new():
    print("Let's start writing!")
    print("Press `111q` to stop and save the note!\n")

    note = ""
    title = input("Note's title: ")

    while True:
        new_line = input("") + "\n"

        if "111q" in new_line:
            print("Start saving your note...")
            break

        else:
            note += new_line

    new_note = open("notes/" + title + ".txt", "w")
    new_note.write(note)
    new_note.close()

    print("Done!")

    return 1


def delete_notes():
    print("Are you sure you want to delete all of your notes?")
    ok = int(input("0 - No, 1 - Yes => "))

    if ok == 1:
        print("Please confirm your identity again: ")

        if check_password() == 1:
            print("Deleting your notes...")
            file_path = 'notes'

            try:
                entries = os.scandir(file_path)
                for entry in entries:
                    os.remove(entry)
                os.rmdir(file_path)

                print("Done!")
            except:
                print("No notes stored yet!")

            return 1

        else:
            return 0

    return 0


def delete_account():
    print("Deleting your account will involve deleting all of your thoughts!")
    print("Are you sure?")
    ok = int(input("0 - No, 1 - Yes => "))

    if ok == 1:
        print("Please confirm your identity again: ")

        if check_password() == 1:
            print("Deleting your data...")
            os.remove('data/input.txt')

            try:
                entries = os.scandir('notes')
                for entry in entries:
                    os.remove(entry)
                os.rmdir('notes')
                print("Done!")

            except:
                print("No notes stored!")

            return 1

        else:
            return 0

    return 0


def meniu():
    print("What do you want to do today?")
    print("1. Write something new!")
    print("2. Delete all my thoughts!")
    print("3. Delete my account!")
    print("4. Exit!")

    global choice
    choice = int(input("Your choice: "))
    looping = True

    while looping:
        if choice == 1:
            something_new()
        elif choice == 2:
            if delete_notes() == 1:
                print("Action completed!")
            else:
                print("Canceled!")
            access = 0
            break
        elif choice == 3:
            if delete_account() == 1:
                print("Action completed!")
            else:
                print("Canceled!")
            access = 0
            break
        elif choice == 4:
            print("Bye-bye!")
            looping = False
            access = 0
            break
        else:
            print("You must choose 1, 2, 3 or 4!")
            choice = int(input("Your choice: "))

        print("-----------------------------")
        choice = int(input("Your choice: "))


print("Hi there! Please log in.")
access = get_access()

if access == 1:
    meniu()