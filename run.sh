#!/bin/bash

ruby app.rb > hosts

ansible-playbook -i hosts update.yml
