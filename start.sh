#!/usr/bin/bash
                            set -e
# ****************************************************************
# *                                                              *
# *                       *10-09-2024*                           *
# *                                                              *
# ****************************************************************

info="Please get help with $0 --help"
help(){
    echo 
    echo "# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "# +   10                   /////09///////              24        +"
    echo "# |   =>    =>    =>       Cyber missile     =>   =>   =>        |"
    echo "# +                       //////////////                         +"
    echo "# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo 
    echo "USAGE: --email your_git_email@domain.com --username your_git_username"
    echo 
    echo
}
        #get help
#-------------------------#
if [[ $1 == "--help" ]];
then
    help
    exit
fi







######################### Stop script if .env file does not exist ##################################
if [ ! -f '.env' ]
then
echo ".env file does not exist. Please create .env file in current directory and set the variable mentionned in readme."
exit
fi
#############  Please make sure that .env file exist in current directory ##########################







args=$#
filename=$0

email_flag=$1
email=$2

username_flag=$3
username=$4



build_image(){ #build docker image symfo:1.0
    # this function takes 4 args to build image symfo:1.0 :
    # --email exemple@gmail.com --username exemple --appname exemple.

    # if args given to this function not egal to 4 
    # then print info and stop script
    if [[ $args -ne 4 ]];
    then
        echo "$filename takes 4 arguments"
        echo $info
        exit 1
    fi


    # if arg 1 egal to email flag and 
    # arg 3 egal to flag username and
    # then build image with these info
    # otherwise print info
    if [[ $email_flag == '--email' && $username_flag == '--username' ]];
    then
        docker build --no-cache --build-arg USERNAME=$username \
                                --build-arg EMAIL=$email \
                                -t symfo:1.0 .
    else
        echo "Flag incorrect. check your flag names"
        echo $info
    fi
}






create_containers(){ # create containers with docker-compse
    # this function create containers by launching docker-compose 

    # check if image symfo already exist 
    # if so then create containers 
    # otherwise build image symfo and create containers
    if [[ ! $(docker images | grep symfo) ]]
    then
        build_image
    fi


    # check if conatiners already exist 
    # if so then start containers 
    # otherwise create containers
    if [[ ! $(docker-compose ps | grep myapp) ]]
    then
        docker-compose --env-file .env up -d
    else
        docker-compose start
    fi
    
}




create_containers