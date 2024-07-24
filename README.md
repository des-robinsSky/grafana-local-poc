# Local Grafana back up 

## Overview

The script performs the following tasks:

Executing `./scripts/copy-datasources.sh`: Clones **core-platform-config** and if the repository is already cloned, it pulls the latest changes and resets to the latest commit on `master`.
- If the repository is not cloned, it clones the repository with submodules.
- Copies specific files into `/datasources` from **core-platform-config**'s `datasources` directory.

## Usage

1. **Ensure you have the necessary permissions**:
    - Make the script executable:
      ```bash
      chmod +x copy-datasources.sh
      ```

2. **Run the script**:
   ```bash
   ./setup_datasources.sh

3. `core-platform-config` is cloned and checks out the latest commit. We then read to copy team-specific grafana dashboards into `./datasources`

4. Run grafana locally by executing its docker image `./docker-compose.yml`

5. Run your grafana dashboard publish job against locak grafana to restore all dashboards.