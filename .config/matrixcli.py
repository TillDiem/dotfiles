def password_eval():
    return "hKl-93B-147"

accounts=[{ "server":"https://matrix.ethnobar.xyz/",
              "username":"konradvschwaben",
              "passeval":password_eval }]

# the password_eval function can be named any thing as long as
# it matches the function definition

ignore_rooms = ["room_id", "another_room_id"]
# note: room_id not room_alias (run matrixcli rooms to get the room_id)
