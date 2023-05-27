# SCA-Cloud-Bootcamp-4
This is my final project submission for the She Code Africa Cloud School Bootcamp (Cohort 4). My topic is **Containers & Kubernetes**. 

I created the infrastructure:
- Azure managed Kubernetes service (AKS)
- Storage account (to keep my Terraform state files, Helm repo) using Terraform, then I deployed a web app on AKS via Azure Pipelines (CI/CD).

Every time I make a push to my git repo, the image is re-built, stored as a build artifact, and then deployed to my AKS cluster.

## Architectural Diagram
<img width="545" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/ab3a62a9-adae-47c6-95a6-4ae48b7ceb30">

## Setting Up the app on my local computer
The application fetches and displays a GitHub user's profile. It calls the Github API, to display the profile of any username typed in the search box. 

```python
$ python3-m venv venv
$ source venv/bin/activate
$ pip install --upgrade pip
$ pip install -r requirements.txt
$ python3 main.py
```

<img width="909" alt="image" src="https://github.com/Mbaoma/AKS-Demo/assets/49791498/578c85d2-d3dd-4755-96bc-2fe99f62c978">

<img width="1043" alt="image" src="https://github.com/Mbaoma/AKS-Demo/assets/49791498/ba5d030d-55d3-4e50-8761-544a64be12cf">

``` http://127.0.0.1:5500/```

## Dockerize the app
```docker
$ docker login
$ docker build -t <docker-hub-username>/<image-name>:tag .
$ docker push <docker-hub-username>/<image-name>:tag
```

## Setting up my Azure Devops Workspace
- Create a [project](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=browser) in your workspace.

<img width="1087" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/43becad4-76c9-4187-81db-cb4bdcaf7adc">

### Create infrastructure using Terraform
- Run the scripts in the ```infrastructure``` folder.
```bash
$ cd terraform
$ az login
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform plan
$ terraform apply
```

<img width="966" alt="Screenshot 2023-05-20 at 04 52 50" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/d719492f-5c70-4121-9980-240f7463ac16">

## Setup Azure Pipeline 
- [Create](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-using-automated-security) an Azure Resource Manager service connection.

### Create a default Agent pool
- [Guide](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops&tabs=yaml%2Cbrowser).
This means the tasks and jobs will be executed on your local machine. This allows you to leverage the resources and capabilities of your local machine for building, testing, and deploying your applications.

I did this because I had to request for ```free parallelism``` and it will take some days before my request is approved.

<img width="1300" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/0e19153a-6953-4abe-b5c8-4aaa64865aab">

### CI
- Builds the Docker image and saves it as an artifact. Run the command below (to start the agent pool) before making a push to GitHub. Also, ensure Docker desktop is running in the backgrouund.

```bash
$ ./run.sh 
```

- Connect your GitHub Repo to Azure DevOps

<img width="1117" alt="Screenshot 2023-05-18 at 13 30 25" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/77ce3371-28f6-4577-8b6c-c17fe69e67db">

<img width="1117" alt="Screenshot 2023-05-18 at 13 33 31" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/34a71265-b408-4b86-af08-c8ab0ab481da">

- Configuring my CI pipeline: start with a simple workflow option and add extra configuration as needed.

<img width="1300" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/852660b5-ebd2-438d-83c7-c7aea9321588">

### CD (Release Pipeline)
Use [Helm](https://helm.sh/docs/intro/install/) to deploy your image on the AKS cluster.
- First, [install](https://helm.sh/docs/intro/install/) Helm, the config files can be found in the ```myhelm``` folder.
- Create and apply a ```secrets.yaml``` file in the ```myhelm/templates``` folder.
```bash
$ touch secrets.yaml
$ kubectl -f apply myhelm/templates secrets.yaml
```

- Then create a Helm repo and add a Chart to the repo:
```helm
$ cd myhelm
$ helm package .
$ helm repo index .
```
- Upload the ```index.yaml``` and the folder with the ```.tgz``` extension, to your Azure storage container created above. Then run:

```
$ helm repo add <repository-name> <repository-url>
```
**Notes**:
- The <repository-url> is the URL of the ```index.yaml``` file stored in the storage container.
- For every change  made to the config files, push the index and zip to storage account
- Verify chart is available
```helm
$ helm search repo <chart-name>
```
- Fetch chart information
```helm
$ helm repo update 
```

- Configuring the CD pipeline
**Stage 1**

<img width="1140" alt="Screenshot 2023-05-18 at 18 50 48" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/f9d9b1bd-4110-4976-bd63-b05a13318d11">

**Stage 2**
<img width="1300" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/5606e622-585f-48b7-a3aa-69c6f094847d">

- Setting the trigger

<img width="1294" alt="Screenshot 2023-05-20 at 04 21 05" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/dbf6be3b-fafb-4b67-acaa-f8421906d1b1">

## Putting it all together
- Whenever a push is made to the GitHub repository, the CI pipeline is triggered, once the build is successful, the CD pipeline kicks off.
- You can access your cluster's external IP and port by running:
```bash
$ kubectl get services
```

<img width="1300" alt="Screenshot 2023-05-20 at 05 15 33" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/9a21cc40-e7af-4c3d-83a8-d11bf18f5be6">

Live link: ```http://52.189.27.203:5500/```
