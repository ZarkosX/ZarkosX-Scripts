#!/bin/bash
clear

# =============================
# Colors
# =============================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
RESET="\e[0m"
BOLD="\e[1m"

cat << "EOF"
███████╗ █████╗ ██████╗ ██╗  ██╗ ██████╗ ███████╗██╗  ██╗██████╗ ███████╗██╗   ██╗
╚══███╔╝██╔══██╗██╔══██╗██║ ██╔╝██╔═══██╗██╔════╝╚██╗██╔╝██╔══██╗██╔════╝██║   ██║
  ███╔╝ ███████║██████╔╝█████╔╝ ██║   ██║███████╗ ╚███╔╝ ██║  ██║█████╗  ██║   ██║
 ███╔╝  ██╔══██║██╔══██╗██╔═██╗ ██║   ██║╚════██║ ██╔██╗ ██║  ██║██╔══╝  ╚██╗ ██╔╝
███████╗██║  ██║██║  ██║██║  ██╗╚██████╔╝███████║██╔╝ ██╗██████╔╝███████╗ ╚████╔╝ 
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝  ╚═══╝  
                                                                                  
EOF

echo
echo -e "${CYAN}1${RESET} - ${RED}Make VPS in Firebase${RESET}"
echo -e "${CYAN}2${RESET} - ${RED}Start VPS in Firebase${RESET}"
echo -e "${CYAN}3${RESET} - ${MAGENTA}Install Proxmox VE (Docker)${RESET}"
echo -e "${CYAN}4${RESET} - ${BLUE}Make xRDP (XFCE + Firefox)${RESET}"
echo -e "${CYAN}5${RESET} - ${BLACK}Install Telebit${RESET}"
echo -e "${CYAN}6${RESET} - ${YELLOW}Install Cloudflare Tunnels${RESET}"
echo -e "${CYAN}7${RESET} - ${GREEN}Install Tailscale Tunnels${RESET}"
echo -e "${RED}0${RESET} - ${RED}Exit${RESET}"
echo

read -p "Enter your choice: " choice


# =============================
# CHOICE HANDLING
# =============================
if [[ "$choice" == "1" ]]; then
    mkdir -p .idx
    echo -e "${BLUE}->¦ Creating .idx folder...${RESET}"

    # dev.nix
    cat > .idx/dev.nix <<'EODEV'
{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = with pkgs; [
    unzip openssh git qemu_kvm sudo cdrkit cloud-utils qemu docker
  ];
  env = {
    EDITOR = "nano";
  };
}
EODEV
    echo -e "${GREEN}[OK] dev.nix created${RESET}"

EOVM

    chmod +x .idx/vm.sh
    echo "[OK] vm.sh created in .idx"
    echo -e "${GREEN}[OK] VM Manager installed${RESET}"
    echo -e "${YELLOW}-> Run it using:${RESET} cd .idx && bash vm.sh"

elif [[ "$choice" == "2" ]]; then
    clear
    echo -e "${CYAN}========================================================${RESET}"
    echo -e "${RED}        Start VM ${RESET}"
    echo -e "${CYAN}========================================================${RESET}"

    bash <(curl -s https://raw.githubusercontent.com/ZarkosX/ZarkosX-Scripts/refs/heads/main/vm.sh)

elif [[ "$choice" == "3" ]]; then
    clear
    echo -e "${CYAN}========================================================${RESET}"
    echo -e "${MAGENTA}        PROXMOX VE (DOCKER VERSION)${RESET}"
    echo -e "${CYAN}========================================================${RESET}"

    echo -e "${YELLOW}ðŸ“¦ Updating system...${RESET}"
    apt update && apt upgrade -y

    echo -e "${YELLOW}ðŸ³ Installing Docker...${RESET}"
    apt install -y docker.io

    echo -e "${YELLOW}ðŸ” Enabling Docker auto-start...${RESET}"
    systemctl enable docker
    systemctl start docker

    echo -e "${YELLOW}ðŸ“¥ Pulling Proxmox Docker image...${RESET}"
    docker pull rtedpro/proxmox:9.0.11

    echo -e "${GREEN}ðŸš€ Starting Proxmox VE container...${RESET}"
    docker run -itd \
        --name proxmoxve \
        --hostname pve \
        -p 8006:8006 \
        --privileged \
        --restart unless-stopped \
        rtedpro/proxmox:9.0.11

    echo -e "${GREEN}[OK] Proxmox VE container started!${RESET}"
    echo -e "${CYAN}-> Access it in your browser: https://<your-server-ip>:8006${RESET}"
    echo -e "${YELLOW}<3  Made by: ZarkosXDev.${RESET}"

elif [[ "$choice" == "4" ]]; then
    clear
    echo -e "${CYAN}========================================================${RESET}"
    echo -e "${BLUE}        Installing xRDP + XFCE + Firefox${RESET}"
    echo -e "${CYAN}========================================================${RESET}"

    apt update && apt upgrade -y
    apt install -y xfce4 xfce4-goodies xrdp firefox-esr

    echo "startxfce4" > ~/.xsession
    sudo chown "$USER:$USER" ~/.xsession

    systemctl enable xrdp
    systemctl start xrdp

    echo -e "${GREEN}✔ xRDP + XFCE + Firefox installed!${RESET}"
    echo -e "${CYAN}-> Connect via RDP client to your server IP${RESET}"

elif [[ "$choice" == "5" ]]; then
    clear
    echo -e "${CYAN}========================================================${RESET}"
    echo -e "${YELLOW}        Installing Telebit${RESET}"
    echo -e "${CYAN}========================================================${RESET}"

    curl -fsSL https://get.telebit.io | bash
    echo -e "${GREEN}[OK] Telebit installed!${RESET}"
    echo -e "${CYAN}-> Run it using: telebit help${RESET}"

elif [[ "$choice" == "6" ]]; then
        clear
        echo -e "${CYAN}========================================================${RESET}"
        echo -e "${YELLOW}        Installing Cloudflare Tunnel (cloudflared)${RESET}"
        echo -e "${CYAN}========================================================${RESET}"

        sudo mkdir -p --mode=0755 /usr/share/keyrings
        curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

        echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list >/dev/null

        sudo apt update && sudo apt install -y cloudflared

        echo -e "${GREEN}[OK] Cloudflare Tunnel installed successfully!${RESET}"
        echo -e "${CYAN}[OK] Login using: cloudflared tunnel login${RESET}"
        echo -e "${CYAN}[OK] Create tunnel: cloudflared tunnel create NAME${RESET}"

elif [[ "$choice" == "7" ]]; then
        clear
        echo -e "${CYAN}========================================================${RESET}"
        echo -e "${YELLOW}        Installing Tailscale${RESET}"
        echo -e "${CYAN}========================================================${RESET}"

        curl -fsSL https://tailscale.com/install.sh | bash
        echo -e "${GREEN}[OK] Tailscale installed!${RESET}"

        read -p "Do you want to start Tailscale now? (y/n): " start_choice
        if [[ "$start_choice" =~ ^[Yy]$ ]]; then
            sudo tailscale up
            echo -e "${GREEN}[OK] Tailscale is now running!${RESET}"
        else
            echo -e "${YELLOW}Tailscale start skipped.${RESET}"
        fi

    elif [[ "$choice" == "0" ]]; then
        echo -e "${RED}Exiting...${RESET}"
        exit 0

    else
        echo -e "${RED}Invalid choice!${RESET}"
        sleep 2
    fi

    read -p "Press Enter to return to the menu..."
done
