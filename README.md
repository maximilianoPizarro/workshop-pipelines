# WorkShop OpenShift Pipelines with Helm Charts Example on Red Hat OpenShift

<p align="left">
<img src="https://img.shields.io/badge/redhat-CC0000?style=for-the-badge&logo=redhat&logoColor=white" alt="Redhat">
<img src="https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white" alt="kubernetes">
<img src="https://img.shields.io/badge/helm-0db7ed?style=for-the-badge&logo=helm&logoColor=white" alt="Helm">
<img src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="shell">
<a href="https://www.linkedin.com/in/maximiliano-gregorio-pizarro-consultor-it"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="linkedin" /></a>
<a href="https://artifacthub.io/packages/search?repo=workshop-pipelines"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/workshop-pipelines" alt="Artifact Hub" /></a>
</p>

<p align="left">
<img src="https://maximilianopizarro.github.io/ocp-pipelines.png" width="900" title="Run On Openshift">  
</p>


<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/ecommerce-architect.png" width="900" title="Run On Openshift">
</p>

# Getting Started: Fork and Personalize Your Environment

Before starting the workshop, it is recommended to **fork this repository** into your own GitHub account. This allows you to work independently and save your progress.

After forking, you must **configure the values in `values.yaml`** with your personal OpenShift namespace and registry information. By default, the configuration uses `maximilianopizarro5-dev` as the namespace. You should update these values in the `values.yaml` file.

<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/namespaces-dev.png" width="900" title="Run On Openshift">
</p>

## Configuration in values.yaml

Before installing the chart, you need to configure the following values in `values.yaml`:

```yaml
# Namespace configuration
namespace: <YOUR-NAMESPACE>  # Replace with your OpenShift namespace (e.g., yourusername-dev)

# Pipeline configuration
pipeline:
  # Source image in OpenShift internal registry
  sourceImage: image-registry.openshift-image-registry.svc:5000/<YOUR-NAMESPACE>/workshop-pipelines:latest
  # Target image in external registry (e.g., Quay.io)
  targetImage: quay.io/<YOUR-QUAY-USERNAME>/workshop-pipelines

# Route configuration
route:
  enabled: true  
  host: workshop-pipelines-<YOUR-NAMESPACE>.apps.rm2.thpm.p1.openshiftapps.com
```

**Example configuration:**
```yaml
namespace: maximilianopizarro5-dev

pipeline:
  sourceImage: image-registry.openshift-image-registry.svc:5000/maximilianopizarro5-dev/workshop-pipelines:latest
  targetImage: quay.io/maximilianopizarro/workshop-pipelines

route:
  enabled: true  
  host: workshop-pipelines-maximilianopizarro5-dev.apps.rm2.thpm.p1.openshiftapps.com
```

This step is essential to ensure that all routes, URLs, and deployments work correctly in your personal Developer Sandbox environment.

- [GitHub Repo](https://github.com/maximilianoPizarro/workshop-pipelines)

# What is OpenShift Pipelines?

OpenShift Pipelines is a Kubernetes-native CI/CD solution based on Tekton. It allows you to define and run build, test, and deployment workflows using custom resources. Pipelines are composed of several objects:

- **Pipeline**: Defines the sequence of tasks to execute.
- **PipelineRun**: An instance of a Pipeline execution.
- **Task**: A reusable step in a pipeline (e.g., build, test, deploy).
- **TaskRun**: An instance of a Task execution.
- **PipelineResource**: Defines resources (e.g., Git repositories, images) used by tasks.
- **TriggerTemplate**: Template for creating PipelineRuns from events.
- **TriggerBinding**: Maps event parameters to PipelineRun parameters.
- **EventListener**: Listens for external events (e.g., GitHub webhook) and triggers pipelines.

In this Helm chart, the template includes objects related to pipelines such as `Pipeline`, `PipelineRun`, `Task`, `EventListener`, and `TriggerTemplate` to automate the CI/CD process for your application.

# Prerequisites

To deploy this example, you need a free subscription to [Red Hat Developer Sandbox](https://developers.redhat.com/developer-sandbox). Register with your Red Hat account to access an OpenShift environment for testing and development.

# Installation from OpenShift Dev Spaces

## Open in OpenShift Dev Spaces

[![Open](https://img.shields.io/static/v1?label=Open%20in&message=Developer%20Sandbox&logo=eclipseche&color=FDB940&labelColor=525C86)](https://workspaces.openshift.com/#https://github.com/maximilianoPizarro/workshop-pipelines/tree/main?storageType=ephemeral)


# Setup with OpenShift Dev Spaces

You can set up and deploy this project directly from OpenShift Dev Spaces, a cloud-based development environment integrated with OpenShift. Dev Spaces provides a pre-configured workspace and automates common development tasks using the `devfile.yaml` included in this repository.

## Devfile Tasks Overview

The `devfile.yaml` defines a comprehensive set of tasks that streamline the deployment, management, and cleanup of the application and its supporting services. These tasks are accessible from the Dev Spaces workspace interface under the "Run Tasks" menu.

### Available Tasks

- **1. Helm repo add**  
  Adds the `workshop-pipelines` Helm chart repository to your environment, making the chart available for installation.

- **2. Helm install workshop-pipelines**  
  Installs the main e-commerce application using the `workshop-pipelines` Helm chart from the packaged version (0.1.6) in the `docs/` directory.

- **3. Helm uninstall workshop-pipelines**  
  Uninstalls the `workshop-pipelines` Helm chart, removing the deployed application and its resources.

- **4. Helm upgrade workshop-pipelines local**  
  Upgrades the installed chart to your local development version. This allows you to test changes without uninstalling and reinstalling. **Note:** You can skip step 3 and go directly from step 2 to step 4 to upgrade without uninstalling.

- **a. Install Package of the application**  
  Installs all required npm packages for the application located in the `/app` directory.

- **b. Start Ecommerce**  
  Starts the backend e-commerce application using Maven Wrapper (`./mvnw`).

- **5. Helm add repo Developer Hub**  
  Adds the official OpenShift Helm charts repository, which includes the Red Hat Developer Hub chart.

- **6. Helm install Developer Hub v1.7.0**  
  Installs the Red Hat Developer Hub using Helm, applying custom values from `values.yaml`.

- **c. Helm package workshop-pipelines**  
  Packages the Helm chart for `workshop-pipelines`, builds dependencies, and updates the local Helm repository index.

- **7. Helm uninstall Developer Hub**  
  Uninstalls the Red Hat Developer Hub from your environment.

### How to Use

1. Open the workspace in OpenShift Dev Spaces using the provided link.
2. In the workspace, click on **Workspace** > **Run Tasks**.
3. Select the desired task from the list. Each task executes the corresponding commands and scripts defined in `devfile.yaml`.
4. Monitor the output in the integrated terminal or output pane.

Each task is modular and can be run independently or in sequence, allowing you to deploy, configure, and clean up resources as needed for your development

<p align="left">  
  <img src="https://maximilianopizarro.github.io/workshop-pipelines/tasks-helm-chart.png" width="900" title="Run On Openshift">
</p>


## Open OpenShift Console

- [Developer Sandbox](https://developers.redhat.com/developer-sandbox)

View the OpenShift Topology.

<p align="left">  
<img src="https://maximilianopizarro.github.io/workshop-pipelines/workshop-pipelines-topology.PNG" width="900" title="Run On Openshift">
</p>

Access the Web App Home Page.

<p align="left">  
<img src="https://maximilianopizarro.github.io/workshop-pipelines/workshop-pipelines-home.PNG" width="900" title="Run On Openshift">  
</p>

Get the Web App route with the following command:

```bash
oc get routes workshop-pipelines
```

```bash
Output
workshop-pipelines (main) $ oc get routes workshop-pipelines.
NAME               HOST/PORT                                                                            PATH   SERVICES           PORT   TERMINATION     WILDCARD
workshop-pipelines   workshop-pipelines-maximilianopizarro5-dev.apps.rm2.thpm.p1.openshiftapps.com          workshop-pipelines   http   edge/Redirect   None
```

# Configure Triggers Web Hook

Access the WebHook settings and configure the `ci-github` route.

<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/webhook-github.PNG" width="900" title="Run On Openshift">  
</p>

```bash
oc get routes ci-github
```

```bash
Output
workshop-pipelines (main) $ oc get routes ci-github
NAME        HOST/PORT                                                          PATH   SERVICES       PORT            TERMINATION     WILDCARD
ci-github   ci-github-mpizarro-dev.apps.rm2.thpm.p1.openshiftapps.com          el-ci-github   http-listener   edge/Redirect   None
```

# Configure Quay.io Repository and Robot Account for Image Promotion

The pipeline includes a `promote-to-quay` task that copies images from the OpenShift internal registry to Quay.io. To enable this functionality, you need to:

1. Create a repository in Quay.io
2. Create a robot account with write permissions
3. Configure the secret in your OpenShift namespace
4. Update the `values.yaml` file with your credentials

## Step 1: Create a Repository in Quay.io

1. Log in to [Quay.io](https://quay.io) with your account
2. Click on **Create New Repository** (or navigate to your organization/user account)
3. Fill in the repository details:
   - **Repository Name**: `workshop-pipelines` (or your preferred name)
   - **Visibility**: Choose **Public** or **Private** based on your needs
   - **Description**: Optional description for your repository
4. Click **Create Public Repository** (or **Create Private Repository**)

<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/quay-1.png" width="900" title="Create Quay.io Repository">  
</p>

## Step 2: Create a Robot Account in Quay.io

A robot account is a special type of account designed for automated access to Quay.io repositories. It's more secure than using your personal credentials.

1. In your Quay.io account, navigate to **Account Settings** (click on your username in the top right)
2. Go to **Robot Accounts** in the left sidebar
3. Click **Create Robot Account**
4. Enter a name for the robot account (e.g., `workshop-pipelines`)
5. Click **Create Robot Account**

<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/quay-2.png" width="900" title="Create Robot Account">  
</p>

## Step 3: Grant Permissions to the Robot Account

1. After creating the robot account, you'll see it listed under **Robot Accounts**
2. Click on the robot account name to view its details
3. In the **Repository Permissions** section, click **Add Permission**
4. Select your repository (`workshop-pipelines`)
5. Set the permission level to **Write** (this allows the robot to push images)
6. Click **Add Permission**

<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/quay-3.png" width="900" title="Grant Robot Account Permissions">  
</p>

## Step 4: Get Robot Account Credentials

1. On the robot account details page, you'll see the credentials:
   - **Robot Username**: This will be in the format `<your-username>+<robot-name>` (e.g., `maximilianopizarro+workshoppipelines`)
   - **Robot Password**: Click **Regenerate Token** if needed, then copy the password
2. **Important**: Save these credentials securely. You'll need them for the next step.

## Step 5: Configure values.yaml

Update your `values.yaml` file with the Quay.io configuration:

```yaml
pipeline:
  # Target image in external registry (e.g., Quay.io)
  targetImage: quay.io/<YOUR-QUAY-USERNAME>/workshop-pipelines
  
  # Quay.io secret configuration for promote-to-quay task
  quaySecret:
    # Secret name (must match the pattern: <quay-username>-workshoppipelines-pull-secret)
    name: <YOUR-QUAY-USERNAME>-workshoppipelines-pull-secret
    # Quay.io robot account username (format: username+robotname)
    username: "<YOUR-USERNAME>+<ROBOT-NAME>"
    # Quay.io robot account password (from Step 4)
    password: "<ROBOT-ACCOUNT-PASSWORD>"
    # Email for docker registry secret
    email: "<YOUR-EMAIL>"
```

**Example:**
```yaml
pipeline:
  targetImage: quay.io/maximilianopizarro/workshop-pipelines
  
  quaySecret:
    name: maximilianopizarro-workshoppipelines-pull-secret
    username: "maximilianopizarro+workshoppipelines"
    password: "PASSWORD-ROBOT"
    email: "maximiliano.pizarro.5@gmail.com"
```

## Step 6: Install or Upgrade the Chart

When you install or upgrade the Helm chart, it will automatically create the Docker registry secret in OpenShift using the credentials from `values.yaml`:

```bash
helm install workshop-pipelines . -f values.yaml
```

or

```bash
helm upgrade workshop-pipelines . -f values.yaml
```

The secret will be created automatically if `pipeline.quaySecret.username` and `pipeline.quaySecret.password` are provided in `values.yaml`.

## Step 7: Verify Configuration

After installing the chart, verify that the secret was created:

```bash
oc get secret <YOUR-QUAY-USERNAME>-workshoppipelines-pull-secret -n <YOUR-NAMESPACE>
```

The `promote-to-quay` task in the pipeline will automatically:
1. Authenticate with Quay.io using the robot account credentials from the secret
2. Authenticate with the OpenShift internal registry using the service account token
3. Copy the image from the internal registry to Quay.io after a successful build

The task runs after the `s2i-binary-build` task completes successfully, ensuring images are only promoted when the build succeeds.

# Install Developer Hub with Helm CLI (Optional)

See the pipelines.
<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/developer-hub-ecommerce.PNG" width="900" title="Run On Openshift">  
</p>

Review the documentation.
<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/developer-hub-ecommerce-documentation.PNG" width="900" title="Run On Openshift">  
</p>

See the App Topology.
<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/developer-hub-ecommerce-kubernetes.PNG" width="900" title="Run On Openshift">  
</p>

See the Web App Logs.
<p align="left">
<img src="https://maximilianopizarro.github.io/workshop-pipelines/developer-hub-ecommerce-kubernetes-logs.PNG" width="900" title="Run On Openshift">  
</p>



## Add OpenShift Helm Charts repo

Open the OpenShift Web Terminal and run:
```bash
helm repo add openshift-helm-charts https://charts.openshift.io/
```

```bash
Output:
bash-5.1 ~ $ helm repo add openshift-helm-charts https://charts.openshift.io/
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/user/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/user/.kube/config
"openshift-helm-charts" has been added to your repositories
```

## Deploy Developer Hub using Helm Charts Values

### OAuth GitHub Client
[https://github.com/settings/developers](https://github.com/settings/developers)

```bash
-->developer-hub/app-config-rhdh.yaml
        ...
        github:
          development:
            clientId: <<CLIENT-ID>>
            clientSecret: <<CLIENT-SECRET>>
        ...
```

### Base URL

```bash
-->developer-hub/app-config-rhdh.yaml
      ...
      baseUrl: <<URL>> https://redhat-developer-hub- <NAMESPACE> .apps.rm2.thpm.p1.openshiftapps.com/
      ...
```
```bash
Example:
      ...
      baseUrl: <<URL>> https://redhat-developer-hub-maximilianopizarro5-dev.apps.rm2.thpm.p1.openshiftapps.com/
      ...
```

Install the chart:

```bash
helm install redhat-developer-hub openshift-helm-charts/redhat-developer-hub -f developer-hub/values.yaml --version 1.2.2
```

Access the Developer Portal with GitHub access.

<p align="left">
  <img src="https://github.com/maximilianoPizarro/developer-hub-on-developer-sandbox/blob/main/screenshot/developer-hub-github-access.PNG?raw=true" width="900" title="Run On Openshift">
</p>

Register the WorkShop Pipelines component:

```bash
https://github.com/maximilianoPizarro/workshop-pipelines/blob/main/catalog-info.yaml
```

# Install From Helm Charts Command

## Add repository

```bash
helm repo add workshop-pipelines https://maximilianopizarro.github.io/workshop-pipelines/
```

## Install Chart with parameters

```bash
helm install workshop-pipelines workshop-pipelines/workshop-pipelines --version "VERSION" --set route.host=workshop-pipelines-<NAMESPACE>.apps.rm2.thpm.p1.openshiftapps.com
```

Example:
```bash
helm install workshop-pipelines workshop-pipelines/workshop-pipelines --version 0.1.6
```

## Uninstall Chart

```bash
helm uninstall workshop-pipelines
```

# Links

- [Home Page](https://maximilianopizarro.github.io/workshop-pipelines/)
- [GitHub Repo](https://github.com/maximilianoPizarro/workshop-pipelines)



