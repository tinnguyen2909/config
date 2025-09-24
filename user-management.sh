# User management script - Add/Remove users with home directories
# Usage: ./user-management.sh [add|remove] [username]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "ℹ $1"
}

# Function to check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root (use sudo)"
        exit 1
    fi
}

# Function to validate username
validate_username() {
    local username="$1"

    if [[ -z "$username" ]]; then
        print_error "Username cannot be empty"
        return 1
    fi

    # Check if username contains only valid characters
    if [[ ! "$username" =~ ^[a-z][-a-z0-9]*$ ]]; then
        print_error "Username must start with lowercase letter and contain only lowercase letters, numbers, and hyphens"
        return 1
    fi

    # Check username length
    if [[ ${#username} -gt 32 ]]; then
        print_error "Username must be 32 characters or less"
        return 1
    fi

    return 0
}

# Function to add a user
add_user() {
    local username="$1"

    print_info "Adding user: $username"

    # Check if user already exists
    if id "$username" &>/dev/null; then
        print_warning "User $username already exists"
        return 0
    fi

    # Create user with home directory
    if useradd -m -s /usr/bin/zsh "$username"; then
        print_success "Created user $username with home directory"
    else
        print_error "Failed to create user $username"
        return 1
    fi

    # Add user to sudo group
    if usermod -aG sudo "$username"; then
        print_success "Added $username to sudo group"
    else
        print_error "Failed to add $username to sudo group"
        return 1
    fi

    # Set up basic home directory permissions
    chmod 755 "/home/$username"
    chown "$username:$username" "/home/$username"

    print_success "User $username has been created successfully"
    print_info "To set a password for $username, run: sudo passwd $username"

    return 0
}

# Function to remove a user
remove_user() {
    local username="$1"

    print_info "Removing user: $username"

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        print_warning "User $username does not exist"
        return 0
    fi

    # Check if it's a system user (UID < 1000) and warn
    local user_uid
    user_uid=$(id -u "$username" 2>/dev/null)
    if [[ $user_uid -lt 1000 ]]; then
        print_warning "Warning: $username appears to be a system user (UID: $user_uid)"
        read -p "Are you sure you want to remove this user? [y/N]: " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "User removal cancelled"
            return 0
        fi
    fi

    # Kill all processes belonging to the user
    print_info "Terminating processes for user $username..."
    pkill -u "$username" 2>/dev/null || true
    sleep 2
    pkill -9 -u "$username" 2>/dev/null || true

    # Remove user and home directory
    if userdel -r "$username" 2>/dev/null; then
        print_success "Removed user $username and home directory"
    else
        # Try to remove user without home directory if the above fails
        if userdel "$username" 2>/dev/null; then
            print_success "Removed user $username"

            # Manually remove home directory if it still exists
            if [[ -d "/home/$username" ]]; then
                print_info "Manually removing home directory..."
                if rm -rf "/home/$username"; then
                    print_success "Removed home directory for $username"
                else
                    print_error "Failed to remove home directory for $username"
                fi
            fi
        else
            print_error "Failed to remove user $username"
            return 1
        fi
    fi

    # Clean up any remaining mail spool
    [[ -f "/var/mail/$username" ]] && rm -f "/var/mail/$username"
    [[ -f "/var/spool/mail/$username" ]] && rm -f "/var/spool/mail/$username"

    print_success "User $username has been completely removed"
    return 0
}

# Function to show usage
show_usage() {
    cat << EOF
User Management Script

Usage: $0 [COMMAND] [USERNAME]

Commands:
    add USERNAME     Add a new user with home directory and sudo access
    remove USERNAME  Remove user and their home directory
    help            Show this help message

Examples:
    $0 add john      # Creates user 'john' with home directory and sudo access
    $0 remove jane   # Removes user 'jane' and their home directory

Notes:
    - Must be run as root (use sudo)
    - Usernames must start with lowercase letter
    - Usernames can contain lowercase letters, numbers, and hyphens
    - System users (UID < 1000) will prompt for confirmation before removal
EOF
}

# Main script logic
main() {
    local command="$1"
    local username="$2"

    case "$command" in
        add)
            check_root
            if validate_username "$username"; then
                add_user "$username"
            else
                exit 1
            fi
            ;;
        remove)
            check_root
            if validate_username "$username"; then
                remove_user "$username"
            else
                exit 1
            fi
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            print_error "Invalid command: $command"
            echo
            show_usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
