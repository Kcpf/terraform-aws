main_menu = {
    "type": "list",
    "name": "main_option",
    "message": "What do you want to do?",
    "choices": [
        "Create new project",
        "Show summary",
        "List modules",
        "Delete project",
        "Delete module",
        "Exit",
    ],
}

how_many_machines = {
    "type": "input",
    "name": "how_many_machines",
    "message": "How many machines do you want to create?",
    "validate": lambda val: val.isdigit() or "Please enter a number",
}

machine = [
    {
        "type": "list",
        "name": "which_type_of_machine",
        "message": "Which type of machine do you want to create?",
        "choices": [
            "Weak",
            "Medium",
            "Large",
            "Monster",
        ],
    },
    {
        "type": "list",
        "name": "which_security_groups",
        "message": "Which security group do you want to add?",
        "choices": ["MySQL", "PostgreSQL", "Web App"],
    },
]

how_many_users = {
    "type": "input",
    "name": "how_many_users",
    "message": "How many users do you want to create?",
    "validate": lambda val: val.isdigit() or "Please enter a number",
}

username_question = {
    "type": "input",
    "name": "username",
    "message": "What is the username?",
}

delete_module_question = {
    "type": "input",
    "name": "module",
    "message": "Which module do you want to delete?",
}
