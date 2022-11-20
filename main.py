from PyInquirer import prompt
from dotenv import load_dotenv
import os
import json

from templates import *
from questions import *

load_dotenv()
os.chdir("terraform")


def create_new_project():
    new_tf_file = ""
    new_tf_file += terraform_default_config
    new_tf_file += aws_provider.substitute(region="us-east-1")
    new_tf_file += vpc_subnet.substitute()
    new_tf_file += security_group_mysql.substitute()
    new_tf_file += security_group_postgres.substitute()
    new_tf_file += security_group_web.substitute()

    answer = prompt(how_many_machines)

    for i in range(int(answer["how_many_machines"])):
        answers = prompt(machine)

        if "MySQL" in answers["which_security_groups"]:
            security_group_id = "module.sg-mysql.security_group_id"

        elif "PostgreSQL" in answers["which_security_groups"]:
            security_group_id = "module.sg-postgres.security_group_id"

        elif "Web App" in answers["which_security_groups"]:
            security_group_id = "module.sg-web.security_group_id"

        if answers["which_type_of_machine"] == "Weak":
            new_tf_file += ec2_weak.substitute(
                number=i, security_group_id=security_group_id
            )
        elif answers["which_type_of_machine"] == "Medium":
            new_tf_file += ec2_medium.substitute(
                number=i, security_group_id=security_group_id
            )
        elif answers["which_type_of_machine"] == "Large":
            new_tf_file += ec2_large.substitute(
                number=i, security_group_id=security_group_id
            )
        elif answers["which_type_of_machine"] == "Monster":
            new_tf_file += ec2_monster.substitute(
                number=i, security_group_id=security_group_id
            )

    answer = prompt(how_many_users)

    for i in range(int(answer["how_many_users"])):
        answer = prompt(username_question)

        new_tf_file += user.substitute(number=i, username=answer["username"])

    with open("main.tf", "w") as f:
        f.write(new_tf_file)

    os.system("terraform init")
    os.system("terraform plan")
    os.system("terraform apply -auto-approve")


def summary():
    with open("terraform.tfstate", "r") as f:
        data = json.load(f)

    for resource in data["resources"]:
        if resource["type"] == "aws_instance":
            print("===INSTANCE===")
            print(f"Name: {resource['instances'][0]['attributes']['tags']['Name']}")
            print(f"Module: {resource['module']}")
            print(f"ID: {resource['instances'][0]['attributes']['id']}")
            print(f"Type: {resource['instances'][0]['attributes']['instance_type']}")
            print(f"Private IP: {resource['instances'][0]['attributes']['private_ip']}")
            print(
                f"Security Groups: {resource['instances'][0]['attributes']['vpc_security_group_ids']}"
            )
            print(f"ARN: {resource['instances'][0]['attributes']['arn']}")
            print(f"AMI: {resource['instances'][0]['attributes']['ami']}")
            print(f"Region: us-east-1")
            print()

        elif resource["type"] == "aws_security_group":
            print("===SECURITY GROUP===")
            print(f"Name: {resource['instances'][0]['attributes']['name']}")
            print(f"Module: {resource['module']}")
            print(f"ID: {resource['instances'][0]['attributes']['id']}")
            print()

        elif resource["type"] == "aws_security_group_rule":
            print("===SECURITY GROUP RULE===")
            print(f"Module: {resource['module']}")
            print(f"ID: {resource['instances'][0]['attributes']['id']}")
            print(
                f"Security Group ID: {resource['instances'][0]['attributes']['security_group_id']}"
            )
            print(f"Type: {resource['instances'][0]['attributes']['type']}")
            print(f"From Port: {resource['instances'][0]['attributes']['from_port']}")
            print(f"To Port: {resource['instances'][0]['attributes']['to_port']}")
            print(f"Protocol: {resource['instances'][0]['attributes']['protocol']}")
            print(f"Source: {resource['instances'][0]['attributes']['cidr_blocks']}")
            print()

        elif resource["type"] == "aws_iam_user":
            print("===IAM USER===")
            print(f"Name: {resource['instances'][0]['attributes']['name']}")
            print(f"Module: {resource['module']}")
            print(f"ID: {resource['instances'][0]['attributes']['id']}")
            print(f"ARN: {resource['instances'][0]['attributes']['arn']}")
            print()

        elif resource["type"] == "aws_vpc":
            print("===VPC===")
            print(f"Name: {resource['instances'][0]['attributes']['tags']['Name']}")
            print(f"ID: {resource['instances'][0]['attributes']['id']}")
            print(f"CIDR: {resource['instances'][0]['attributes']['cidr_block']}")
            print(f"ARN: {resource['instances'][0]['attributes']['arn']}")
            print()

        elif resource["type"] == "aws_subnet":
            print("===SUBNET===")
            print(f"Name: {resource['instances'][0]['attributes']['tags']['Name']}")
            print(f"ID: {resource['instances'][0]['attributes']['id']}")
            print(f"VPC ID: {resource['instances'][0]['attributes']['vpc_id']}")
            print(f"CIDR: {resource['instances'][0]['attributes']['cidr_block']}")
            print(
                f"Availability Zone: {resource['instances'][0]['attributes']['availability_zone']}"
            )
            print(f"ARN: {resource['instances'][0]['attributes']['arn']}")
            print()


def list_modules():
    with open("terraform.tfstate", "r") as f:
        data = json.load(f)

    for resource in data["resources"]:
        print(resource["module"])


def delete_module():
    with open("terraform.tfstate", "r") as f:
        data = json.load(f)

    delete_module_question["choices"] = [
        {"name": resource["module"]} for resource in data["resources"]
    ]

    if len(delete_module_question["choices"]) == 0:
        print("No modules to delete")
        return

    answer = prompt(delete_module_question)

    for module in answer["module"]:
        os.system(f"terraform destroy -target {module} -auto-approve")


def delete_project():
    os.system("terraform destroy -auto-approve")


while True:
    answers = prompt(main_menu)

    if answers["main_option"] == "Create new project":
        create_new_project()

    elif answers["main_option"] == "Show summary":
        summary()

    elif answers["main_option"] == "List modules":
        list_modules()

    elif answers["main_option"] == "Delete project":
        delete_project()

    elif answers["main_option"] == "Delete module":
        delete_module()

    elif answers["main_option"] == "Exit":
        break
