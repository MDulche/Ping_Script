Made with ChatGPT

This PowerShell script is designed to monitor the network connectivity of a specified IP address or hostname through repeated ping tests and log any failures to a log file. Here’s a summary of its main functionalities and purpose:

1. **Initial Configuration and Execution**: 
   - The script sets the execution policy to *Unrestricted* to allow unrestricted command execution within the current session.
   - It prompts the user to input a target IP address or hostname for pinging.

2. **Log File Creation**:
   - A log file, `ping_log.txt`, is created in the same directory as the script to record only failed pings. The file is configured with UTF-8 encoding.

3. **Ping Loop**:
   - The script uses an infinite loop to send a ping every second to the specified host.
   - For each ping test:
     - On success, a message with a timestamp is displayed, and a counter for successful pings is incremented.
     - On failure, an error message with the date and time is displayed, and the same message is recorded in the log file. A counter for failed pings is also incremented.

4. **Final Summary**:
   - When the script is stopped (e.g., manually), a `finally` block logs a final summary of the pings, including the total number of successful and failed pings.

### Purpose:
This script is particularly useful for monitoring the availability of a server or network device:
- **Continuous Monitoring**: Ideal for network administrators who need basic, continuous monitoring of a host’s connectivity.
- **Failure Logging**: Failed pings are logged with timestamps, allowing for easy analysis of any downtime.
- **Final Report**: At the end, a summary of the results provides an overview of the host's connectivity performance.

In summary, this script is a simple tool for tracking the availability of a network host and detecting connectivity interruptions in real-time.
