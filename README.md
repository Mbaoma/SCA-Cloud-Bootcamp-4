# SCA-Cloud-Bootcamp-4
This is my final project submission for the She Code Africa Cloud School Bootcamp (Cohort 4). My topic is on Containers & Kubernetes. I will deploy a web app on an Azure managed Kubernetes service (AKS) via Azure Pipelines (CI/CD).

Every time I change my code, the image is pushed to my Azure Container Registry, and the manifests are then deployed to my AKS cluster.

## Architectural Diagram

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

### Create an Azure Container Registry (ACR) using Azure Resource Manager Template (ARM)
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

## Create the Docker image
-  Build the image 
```docker
$ docker login
$ docker build -t <docker-hub-username>/<image-name> .
```

- Push the image to Docker Hub
```docker
$ docker push <docker-hub-username>/<image-name>
```

- Run the image (the image will be run as a container)
```docker
$ docker run -p 5500:5500 <docker-hub-username>/<image-name>
```

<img width="909" alt="image" src="https://github.com/Mbaoma/AKS-Demo/assets/49791498/578c85d2-d3dd-4755-96bc-2fe99f62c978">

<img width="1043" alt="image" src="https://github.com/Mbaoma/AKS-Demo/assets/49791498/ba5d030d-55d3-4e50-8761-544a64be12cf">

## Architecture Diagram
<img width="587" alt="image" src="https://github.com/Mbaoma/SCA-Cloud-Bootcamp-4/assets/49791498/fed86ed4-6431-4ead-857f-1ef05c04580e">