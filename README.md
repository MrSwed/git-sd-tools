# Git SD Tools

Collection of useful Git utility scripts for daily development workflow.

## Installation

Clone this repository to your tools directory:

```bash
cd ~/tools
git clone <repository-url> git-sd-tools
```

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$HOME/tools/git-sd-tools:$PATH"
```

Or create aliases for frequently used scripts:

```bash
alias gsd='~/tools/git-sd-tools/git-status-detailed.sh'
alias gcnm='~/tools/git-sd-tools/git-commit-newest-mod.sh'
alias gusub='~/tools/git-sd-tools/git-update-sub.sh'
```

---

## Status and Information

### git-status-detailed.sh

Shows detailed information about modified files in git repository:
- File modification date and time
- File size
- Number of added/deleted lines for modified files
- **NEW:** Shows number of added lines for new/untracked files (`+N`)
- Total statistics for all files

**Usage:**

```bash
cd /path/to/your/git/repo
./git-status-detailed.sh
```

**Example output:**

```
TOTAL: 5 files modified | +287/-45 lines

README.md                              12,3KiB  2025-10-31 15:42:10  +245
git-status-detailed.sh                  1,2KiB  2025-10-31 15:30:22  +17/-5
git-update-sub.sh                       0,8KiB  2025-10-31 14:20:15  +15/-35
git-commit-newest-mod.sh                0,5KiB  2025-10-31 13:10:08  +10/-5
```

### git-authors.sh

Lists all commit authors sorted by number of commits.

**Usage:**

```bash
./git-authors.sh
```

**Example output:**

```
42 John Doe <john@example.com>
23 Jane Smith <jane@example.com>
15 Bob Johnson <bob@example.com>
```

### git-day-by-day.sh

Generates a changelog grouped by date, showing commits for each day.

**Usage:**

```bash
./git-day-by-day.sh
```

**Example output:**

```
CHANGELOG
----------------------

[2025-10-31]
 * Add new feature X
 * Fix bug in module Y

[2025-10-30]
 * Update documentation
 * Refactor codebase
```

### git-sub-status.sh

Shows git status for all subdirectories containing git repositories.

**Usage:**

```bash
./git-sub-status.sh
```

**Example output:**

```
./project1
M  src/main.go
?? README.md

./project2
M  package.json
```

---

## Submodules Management

### git-submodules-restore.sh

Restores git submodules from `.gitmodules` configuration file. Useful when submodules were removed but need to be re-added.

**Usage:**

```bash
./git-submodules-restore.sh
```

### git-fetch-sub.sh

Recursively fetches all remotes for all git repositories in subdirectories.

**Usage:**

```bash
./git-fetch-sub.sh
```

### git-update-sub.sh

Recursively updates (fetch + pull) all git repositories in subdirectories. Supports `changed` mode to show only repositories with actual changes.

**Usage:**

```bash
# Update all submodules
./git-update-sub.sh

# Show only changed repositories
./git-update-sub.sh changed
```

---

## Commit Tools

### git-commit-newest-date.sh

Creates a commit with the date of the newest file in the directory. Useful for backdating commits to match file modification times.

**Usage:**

```bash
git add .
./git-commit-newest-date.sh -m "Your commit message"
```

### git-commit-newest-mod.sh

Creates a commit with the date of the newest **modified** (not untracked) file. Only considers files shown in `git status` as modified.

**Usage:**

```bash
git add .
./git-commit-newest-mod.sh -m "Your commit message"
```

### git-commit-version.sh

Interactive tool that searches for version information in PHP files or `style.css`, creates a commit with this information, optionally creates a git tag, and pushes to remote.

**Usage:**

```bash
./git-commit-version.sh
```

The script will:
1. Find version and description in PHP files or style.css
2. Ask for confirmation to commit with this info
3. Optionally create a version tag
4. Optionally push changes to remote

---

## Utilities

### git-add-r.sh

Recursively adds files matching a pattern to git staging area. Alternative to `git add` with glob patterns.

**Usage:**

```bash
# Add all .go files recursively
./git-add-r.sh "*.go"

# Add with additional git add options
./git-add-r.sh "*.js" -f
```

### git-trash.sh

Shows the command to remove all untracked files from git status. **Warning:** This is destructive!

**Usage:**

```bash
# Shows the command (doesn't execute)
./git-trash.sh

# Execute the shown command manually if you're sure
```

### git-hooks.sh

Enable or disable git hooks in the current repository by renaming them.

**Usage:**

```bash
# Show current status
./git-hooks.sh

# Disable all hooks (renames them to *.off)
./git-hooks.sh off

# Enable all hooks (removes .off extension)
./git-hooks.sh on

# Show help
./git-hooks.sh --help
```

### git-gc-all.sh

Aggressive git garbage collection with immediate expiration of all reflogs and unreachable objects. Use to minimize repository size.

**Usage:**

```bash
./git-gc-all.sh
```

### git-local.sh

Shows instructions for setting up local git object alternates (mirrors) to save disk space when working with multiple clones of the same repository.

**Usage:**

```bash
./git-local.sh /path/to/mirror
```

### git-no-filemode-and-bare.sh

Recursively removes `filemode=true` and `bare=true` settings from all git config files in subdirectories. Creates `.bak` backups before modification.

**Usage:**

```bash
./git-no-filemode-and-bare.sh
```

---

## Additional Tools

### gitpoller.sh

Daemon script that periodically clones/updates a git repository and optionally runs a build command. Useful for continuous deployment scenarios.

**Usage:**

```bash
# Basic usage
./gitpoller.sh -d /var/www/mysite -r https://github.com/user/repo.git

# With branch and build command
./gitpoller.sh -d /var/www/blog \
               -r https://github.com/user/blog.git \
               -b publish \
               -c "jekyll build" \
               -i 300

# With OAuth token for private repo
./gitpoller.sh -d /var/www/private \
               -r https://github.com/user/private.git \
               -t YOUR_OAUTH_TOKEN
```

**Options:**

- `-d` - Target directory
- `-r` - Git repository URL (https only)
- `-b` - Branch to checkout (default: master)
- `-t` - OAuth token for private repositories
- `-i` - Update interval in seconds (default: 300)
- `-c` - Command to run after checkout/update

### mkpasswd.sh

Generates a random 32-character password using current timestamp, SHA256 hash, and base64 encoding.

**Usage:**

```bash
./mkpasswd.sh
```

**Example output:**

```
Mjk3NjQ1YWJjZGVmMTIzNDU2Nzg5MA==
```

---

## License

MIT License - feel free to use and modify these scripts for your needs.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

---

**Note:** Some scripts perform destructive operations (like `git-trash.sh`). Always review what the script does before running it on important repositories.
