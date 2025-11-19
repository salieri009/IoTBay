# GitHub Actions Workflows

This directory contains GitHub Actions workflows for CI/CD of the IoTBay project.

---

## Workflows

### 1. `deploy.yml` - Build and Deploy
**Purpose**: Build, test, and deploy the application to production server.

**Triggers**:
- Push to `main` or `master` branch
- Pull requests to `main` or `master` (builds only, no deployment)
- Manual trigger via `workflow_dispatch`

**Jobs**:
1. **build**: Compiles code, runs tests, creates WAR artifact
2. **code-quality**: Runs code quality checks (checkstyle, spotbugs)
3. **deploy**: Deploys WAR file to Tomcat server via SSH
4. **database-migration**: Runs database migrations (optional)
5. **health-check**: Verifies application is running after deployment

---

### 2. `ci.yml` - Continuous Integration
**Purpose**: Run tests and checks on pull requests and feature branches.

**Triggers**:
- Pull requests to `main`, `master`, or `develop`
- Pushes to feature branches (not main/master)

**Jobs**:
1. **ci**: Compiles, runs tests, builds WAR file, generates test reports

---

## Required GitHub Secrets

To use the deployment workflow, you need to configure the following secrets in your GitHub repository:

### Settings → Secrets and variables → Actions → New repository secret

1. **`DEPLOY_HOST`**: Server hostname or IP address
   - Example: `192.168.1.100` or `deploy.example.com`

2. **`DEPLOY_USER`**: SSH username for deployment
   - Example: `deploy` or `tomcat`

3. **`DEPLOY_SSH_KEY`**: SSH private key for authentication
   - Generate with: `ssh-keygen -t ed25519 -C "github-actions"`
   - Add public key to server: `~/.ssh/authorized_keys`
   - Copy private key to GitHub Secrets

4. **`DEPLOY_PORT`** (Optional): SSH port, defaults to 22
   - Example: `2222`

5. **`TOMCAT_HOME`** (Optional): Tomcat installation directory, defaults to `/opt/tomcat`
   - Example: `/usr/local/tomcat` or `/opt/tomcat`

6. **`APP_URL`** (Optional): Application URL for health checks
   - Example: `https://iotbay.example.com` or `http://localhost:8080/IoTBay`

---

## Setup Instructions

### 1. Generate SSH Key Pair

```bash
# Generate SSH key for GitHub Actions
ssh-keygen -t ed25519 -C "github-actions-deploy" -f ~/.ssh/github-actions-deploy

# Copy public key to server
ssh-copy-id -i ~/.ssh/github-actions-deploy.pub user@your-server

# Or manually add to server:
# cat ~/.ssh/github-actions-deploy.pub >> ~/.ssh/authorized_keys
```

### 2. Add Secrets to GitHub

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:
   - `DEPLOY_HOST`: Your server IP/hostname
   - `DEPLOY_USER`: SSH username
   - `DEPLOY_SSH_KEY`: Contents of `~/.ssh/github-actions-deploy` (private key)
   - `DEPLOY_PORT`: SSH port (if not 22)
   - `TOMCAT_HOME`: Tomcat directory (if not `/opt/tomcat`)
   - `APP_URL`: Application URL (optional)

### 3. Configure Tomcat on Server

Ensure Tomcat is installed and configured:

```bash
# Example: Install Tomcat (Ubuntu/Debian)
sudo apt update
sudo apt install tomcat9

# Or download and install manually
# https://tomcat.apache.org/download-90.cgi
```

### 4. Configure File Permissions

The deployment script assumes the deployment user can:
- Write to Tomcat webapps directory
- Start/stop Tomcat service

You may need to configure sudo permissions or add user to tomcat group:

```bash
# Add user to tomcat group
sudo usermod -aG tomcat $USER

# Or configure sudo for specific commands
sudo visudo
# Add: deploy ALL=(ALL) NOPASSWD: /bin/systemctl stop tomcat, /bin/systemctl start tomcat
```

---

## Customization

### Change Java Version

Edit `env.JAVA_VERSION` in workflow files:
```yaml
env:
  JAVA_VERSION: '17'  # Change to '11', '21', etc.
```

### Change Maven Goals

Modify the Maven commands:
```yaml
- name: Build with Maven
  run: mvn clean package -DskipTests
  # Change to: mvn clean install
```

### Deploy to Different Server Type

The current workflow deploys to Tomcat. For other servers:

- **Jetty**: Modify deployment script to use Jetty
- **WildFly/JBoss**: Use deployment scanner or management API
- **Docker**: Add Docker build and push steps
- **Cloud Platform**: Use platform-specific deployment actions

### Add Database Migrations

Uncomment and configure the `database-migration` job in `deploy.yml`:

```yaml
- name: Run Database Migrations
  run: mvn flyway:migrate
  # Or use your migration tool
```

---

## Troubleshooting

### Deployment Fails

1. **Check SSH connection**:
   ```bash
   ssh -i ~/.ssh/github-actions-deploy user@your-server
   ```

2. **Verify Tomcat is running**:
   ```bash
   sudo systemctl status tomcat
   ```

3. **Check Tomcat logs**:
   ```bash
   tail -f /opt/tomcat/logs/catalina.out
   ```

4. **Verify file permissions**:
   ```bash
   ls -la /opt/tomcat/webapps/
   ```

### Tests Fail

1. Check test output in Actions tab
2. Review test reports in PR comments
3. Run tests locally: `mvn test`

### Build Fails

1. Check Java version compatibility
2. Verify Maven dependencies: `mvn dependency:tree`
3. Check for compilation errors in Actions logs

---

## Security Best Practices

1. **Use SSH keys, not passwords**
2. **Restrict SSH key permissions** on server
3. **Use least privilege** for deployment user
4. **Rotate SSH keys** periodically
5. **Enable GitHub Actions** only for trusted branches
6. **Review workflow changes** before merging

---

## Workflow Status Badge

Add to your README.md:

```markdown
![CI](https://github.com/your-username/IoTBay/workflows/CI/badge.svg)
![Deploy](https://github.com/your-username/IoTBay/workflows/Build%20and%20Deploy/badge.svg)
```

---

**Last Updated**: 2025

