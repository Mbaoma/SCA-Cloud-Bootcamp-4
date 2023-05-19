# SCA-Cloud-Bootcamp-4
This is my final project submission for the She Code Africa Cloud School Bootcamp (Cohort 4). My topic is on Containers & Kubernetes. 

I created the infrastructure (Azure managed Kubernetes service, storage account) using Terraform, then I deployed a web app on AKS via Azure Pipelines (CI/CD).

Every time I change my code, the image is built and stored as a build artifact, and then deployed to my AKS cluster.

## Architectural Diagram
<img width="537" alt="Screenshot 2023-05-19 at 06 54 02" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/90c9a66b-3888-4b11-939d-70a787ce57b8">

## Setting Up the app on your local computer
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

<img width="1138" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/faba63a3-1576-4fd5-b803-c458f2695a31">

- [Create](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-using-automated-security) an Azure Resource Manager service connection.

## Setup Azure Pipeline 

### Create a default Agent pool
- [Guide](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops&tabs=yaml%2Cbrowser)

### CI
- Builds the Docker image and saves it as an artifact. Run the command below (to start the agent pool) before making a push to GitHub. EnsureDocker desktop is running in the backgrouund.

```bash
$ ./run.sh 
```

zip folder (.tar), create index.yaml
-create repo
- add helm chart to repo
 helm repo add myhelm https://synth3tic9st0rage.blob.core.windows.net/stack/         
"myhelm" has been added to your repositories
helm repo update - fetch chart information
verify chart is available - helm search repo <chart-name>


### CD
- Deploys the artifact gotten from the CI on AKS cluster.


### Create ARM service connection
- [Guide](https://learn.microsoft.com/en-gb/training/modules/deploy-kubernetes/3-set-up-environment)
- [Guide](https://kristhecodingunicorn.com/techtips/ado_sa_error/)