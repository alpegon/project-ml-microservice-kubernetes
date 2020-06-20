[![License](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![CircleCI](https://circleci.com/gh/alpegon/project-ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/alpegon/project-ml-microservice-kubernetes)


## Project Overview

In this project you can find the files and scripts to operationalize a Machine Learning Microservice API.
The service uses a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on.

### Project files

```bash
├── app.py : Flask application (microservice to deploy)
├── .circleci
│   └── config.yml : Config file for the circleci environment
├── Dockerfile : File containing the build steps of the docker container
├── kubernetes
│   ├── app-deployment.yml : deployment template for the microservice in kubernetes
│   ├── app-svc.yml : load balancer service deployment template
│   ├── make_prediction_lb.sh : bash script to test the kubernetes microservice with LB capabilities
│   └── run_kubernetes_lb.sh : bash script to deploy the microservice and the LB in kubernetes
├── LICENSE : Apache 2 license
├── Makefile : make script with setup, install, and lint steps
├── make_predictions.sh : bash script to test the microservice locally
├── model_data : data files for the model
│   ├── boston_housing_prediction.joblib
│   └── housing.csv
├── output_txt_files
│   ├── docker_out.txt : expected docker output
│   └── kubernetes_out.txt : expected kubernetes output
├── README.md : this readme
├── requirements.txt : required pip libraries
├── run_docker.sh : script to launch the app as a docker container
├── run_kubernetes.sh : script to launch the app as a kubernetes pod
└── upload_docker.sh : script to upload the container image
```

---

## Setup the Environment

* Create a virtualenv and activate it with `make setup`
* Run `make install` to install the necessary dependencies

## Basic deployments

### Standalone

Run the application with:
```
python app.py
```

### Docker
Make sure that you have docker installed, and that you have the execution rights for containers, then:
```
./run_docker.sh house-price-prediction
```

### Kubernetes
First upload the container image to DockerHub:
```
./upload_docker.sh alpegon house-price-prediction
```

Then with the kubernetes cluster running execute:
```
./run_kubernetes.sh alpegon house-price-prediction
```

## Testing the code
You can check the Dockerfile and the application code with the command:
```
make lint
```
This command executes `hadolint` to verify the Dockerfile and `pylint` to verify the application code.


## Testing the service

To test if the microservice is working in localhost you can use the script `/make_prediction.sh`. It should generate a response like the following:
```
Port: 8000
{
  "prediction": [
    20.35373177134412
  ]
}
```

In the server, the output should look like this:
```
[2020-06-20 22:10:53,882] INFO in app: JSON payload: 
{'CHAS': {'0': 0}, 'RM': {'0': 6.575}, 'TAX': {'0': 296.0}, 'PTRATIO': {'0': 15.3}, 'B': {'0': 396.9}, 'LSTAT': {'0': 4.98}}
[2020-06-20 22:10:53,904] INFO in app: Inference payload DataFrame: 
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2020-06-20 22:10:53,918] INFO in app: Scaling Payload: 
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2020-06-20 22:10:53,923] INFO in app: Output prediction: [20.35373177134412]
172.17.0.1 - - [20/Jun/2020 22:10:53] "POST /predict HTTP/1.1" 200 -
```

## More deployments

### Kubernetes with Load Balancer in minikube
To simulate the load balancer functionality, first, in other console execute:
```
minikube tunnel
```
Then you can create the app deployment and the service with the script:
```
./kubernetes/run_kubernetes_lb.sh
```
And finally test it with the script:
```
./kubernetes/make_prediction_lb.sh
```

