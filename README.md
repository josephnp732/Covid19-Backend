# Covid19-Backend
Northeastern University MS IS DevOps Spring 2020 - Final Project

## To deploy and run application just run `bash create.sh`

_Note:_
Will take about 20 minutes to provision and about Endpoints will be ready to access in about another 10 minutes

#### Expected Outputs:
* External Backend API Hostname
* Grafana Dashboard Hostname (Append `:3000` to the hostname)
* Kubernetes Dashboard Hostname
* Front-end Hostname (Open frontend with _Chrome Securities Disabled_) <br/>
MacOS Command: `open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security`

### <ins> Pre-requisites</ins>:
* Make sure to run Bash scripts on UNIX based system, MacOS or Windows WSL
* Install Terraform CLI Tool in installed (https://learn.hashicorp.com/terraform/getting-started/install.html)
* Install AWS CLI Tool (https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* Install kubectl CLI Tool (https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* Install jq CLI Tool (https://stedolan.github.io/jq/download/)

#### Using the Endpoint for Frontend:

* **GET** All Data : `http://<ExternalIP>/all`
* **GET** All Country : `http://<ExternalIP>/countries`
* **GET** Country Specific : `http://<ExternalIP>/countries/<country>`

_Note:_
`External IP`: Public facing DNS Name generated at the end of the script
`country`: Example: USA, India, Bahrain, etc.

### To destroy resouces, run: `bash destroy.sh`

Real time data generated using: 
https://documenter.getpostman.com/view/8854915/SzS7R6uu?version=latest
