# Assembly-Key-Logger
 
A keylogger, or keystroke logger, is a type of surveillance technology used to monitor and record each keystroke typed on a specific computer's keyboard. While keyloggers can be used for legitimate purposes, such as monitoring employee activity or recovering lost data, they are more commonly associated with malicious activities like stealing sensitive information, including passwords and credit card numbers.

### Historical Background

The concept of keylogging dates back to the early days of computing. Keyloggers have evolved significantly over time, originating from simple hardware devices attached to typewriters and keyboards to sophisticated software applications capable of evading detection by modern security systems.

### How Keyloggers Work

Keyloggers operate by capturing and recording the input from a keyboard. They can be implemented in various forms:

1. **Hardware Keyloggers**: Physical devices plugged into the computer or keyboard.
2. **Software Keyloggers**: Programs installed on the target machine that monitor keyboard activity.
3. **Kernel-based Keyloggers**: Integrated at the operating system level, making them difficult to detect.
4. **API-based Keyloggers**: Use system APIs to intercept keyboard inputs.

### Working of Keyloggers in Assembly Language

Keyloggers written in assembly language are typically more difficult to detect and remove due to their low-level nature. Here is a simplified overview of how a software keylogger can be implemented in assembly language:

1. **Hooking the Keyboard Interrupt**: In a DOS-based system, keyboard input can be intercepted by hooking the keyboard interrupt (usually interrupt 0x09). This involves replacing the default interrupt service routine (ISR) with a custom ISR that logs the keystrokes.
2. **Custom Interrupt Service Routine (ISR)**: The custom ISR captures the scan code of each key pressed. The scan code is then converted to the corresponding ASCII character if needed and stored in a buffer for later retrieval.
3. **Writing to a Log File**: The logged keystrokes are periodically written to a file on the disk, which can be retrieved by the attacker or user monitoring the activity.


### Conclusion

Keyloggers are powerful tools with significant potential for misuse. Understanding their operation, especially at a low level with assembly language, provides insights into both defensive and offensive security measures. While this example demonstrates the basic principles, modern keyloggers are much more sophisticated and often incorporate advanced techniques to avoid detection and capture a broader range of input data.

### Ethical Considerations

The use of keyloggers must be approached with caution and responsibility. Unauthorized use of keyloggers to capture information is illegal and unethical. This report and the accompanying example are intended solely for educational purposes to help understand and defend against such threats.

### References

1. Irvine, Kip R. "Assembly Language for x86 Processors."
2. "The Art of Assembly Language Programming." Randall Hyde.
3. Various online resources on low-level programming and keylogging techniques.
