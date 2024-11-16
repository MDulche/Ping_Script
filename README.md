Made with ChatGPT

# PowerShell Ping Monitoring Script

This PowerShell script allows you to monitor the accessibility of a target host (by IP address or hostname) through continuous ping tests. The script provides two ways to control when it stops:

1. **Time Limit Mode**: The script runs for a specified duration in minutes.
2. **Key Press Mode**: The script runs indefinitely and stops when you press a specific key (default is "Q").

## Features

- **Real-Time Monitoring**: Continuously pings the specified host and logs any failed pings.
- **Log File Creation**: Saves failed ping attempts and a summary report to a log file in the script’s directory.
- **Flexible Control Options**:
  - **Time Limit Mode**: Stops the script after the specified duration (in minutes).
  - **Key Press Mode**: Allows manual interruption by pressing "Q".

## Usage

1. **Run the Script**: Start the script in PowerShell.
2. **Select Mode**: You’ll be prompted to select the stopping method:
   - **1 for Time Limit**: Specify the duration (in minutes) the script should run.
   - **2 for Key Press**: The script will run indefinitely until you press "Q".
3. **Specify the Target Host**: Enter the IP address or hostname of the target for ping monitoring.

## Output

- **Console**: Displays each ping result, showing successful attempts and failed connections.
- **Log File** (`ping_log.txt`): Records all failed ping attempts and, upon exit, provides a summary of successful and failed attempts.

This script is ideal for monitoring network stability, troubleshooting, and testing connectivity over time, with convenient stopping options tailored to user needs.
