# Simple HTTP Server Deployment

![Architecture](.github/arch-image.PNG)

This repository demonstrates a practical example of deploying a simple HTTP server written in Go to AWS using GitHub Actions for CI/CD.
this project is part of an article. You can see the whole process throght this link: https://medium.com/@pauloradea/a-whole-journey-about-how-to-deploy-an-application-for-production-e295cb2e6bfc

![systemd](.github/forget-docker.PNG)

# Describing Unit service file
1. [Unit]
    - After=network-online.target (specifies that the service (or unit) should start only after the system's network is fully operational)
    - Wants=network-online.target (Ensures network-online.target is pulled in if it is not explicitly started)

2. [Service]
    - Type=exec (Is a command execution)
    - User=root (User who will execute the action)
    - WorkingDirectory=/root (Directory)
    - ExecStart=/root/simple-http-server (the command that should be installed, its a binary in this case)

    - Restart=on-failure (Restart service on failure)
    - RestartSec=5 (Restart every 5 seconds)

3. [Install]
    - WantedBy=multi-user.target (Will be started automatically started when system reaches that state)

4. Put this file in /etc/systemd/system

5. sudo systemctl enable http-server

6. sudo systemctl restart http-server

7. Generate a SSH key for Github
