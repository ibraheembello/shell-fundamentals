#!/bin/bash

# Path to the todo file in the home directory
TODO_FILE="$HOME/todo.txt"

# Ensure the file exists
touch "$TODO_FILE"

while true; do
    echo -e "\n--- To-Do List Manager ---"
    echo "1. View all tasks"
    echo "2. Add a new task"
    echo "3. Delete a task"
    echo "4. Exit"
    read -p "Choose an option (1-4): " choice

    case $choice in
        1)
            echo -e "\nYour Tasks:"
            if [ ! -s "$TODO_FILE" ]; then
                echo "No tasks found."
            else
                nl -w2 -s'. ' "$TODO_FILE"
            fi
            ;;
        2)
            read -p "Enter the task: " task
            echo "$task" >> "$TODO_FILE"
            echo "Task added successfully!"
            ;;
        3)
            echo -e "\nYour Tasks:"
            if [ ! -s "$TODO_FILE" ]; then
                echo "No tasks to delete."
            else
                nl -w2 -s'. ' "$TODO_FILE"
                read -p "Enter the task number to delete: " task_num
                # Validate input is a number
                if [[ $task_num =~ ^[0-9]+$ ]]; then
                    # Check if line exists
                    line_count=$(wc -l < "$TODO_FILE")
                    if [ "$task_num" -le "$line_count" ] && [ "$task_num" -gt 0 ]; then
                        sed -i "${task_num}d" "$TODO_FILE"
                        echo "Task deleted successfully!"
                    else
                        echo "Invalid task number."
                    fi
                else
                    echo "Please enter a valid number."
                fi
            fi
            ;;
        4)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
