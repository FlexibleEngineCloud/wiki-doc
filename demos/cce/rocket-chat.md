<!-- TITLE: 1. Rocket.chat -->
<!-- SUBTITLE: How to deploy Rocket.chat using CCE -->

# Rocket.chat 
Github: https://github.com/RocketChat/Rocket.Chat

The goal of this demo is to deploy a rocket.chat server on CCE using various FE services.
Rocket.Chat is a Web Chat Server, developed in JavaScript, using the Meteor fullstack framework. It is a great solution for communities and companies wanting to privately host their own chat service or for developers looking forward to build and evolve their own chat platforms. Rocket.chat use mongoDB as database.

## Prerequisites 

- Web access to Flexible Engine platform (APIs are not used for now)
- CCE cluster with 2 (or more) nodes. Best practice is to deploy nodes on both AZ (cf. CCE Cluster creation guide: https://docs.prod-cloud-ocb.orange-business.com/en-us/usermanual/cce/en-us_topic_0035200399.htm) 

## Architecture
The CCE cluster is be deployed on 2 availability zones (AZ) and contains 2 nodes (based on Elastic Cloud Servers (ECS)). 1 instance of rocket.chat and 1 instance of mongoDB database (as mongo is not available aaS for now) will be deployed on nodes (note that it is not the best pratice as there is no data persitence for mongoDB). The point here is to deploy a basic rocket.chat taht can be used for demo or training sessions.
![CCE Rocket.chat architecture](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/Wordpress%20CCE%20rocketchat.png)
## Services used

- Cloud Container Engine: to deploy Rocket.chat server and mongoDB database

## Step by Step deployment guide

**1. Create mongoDB CCE component template**
		CCE -> Create Template
		- Template Name: mongodb
		- Container Image: External Container Image. 
		It will use DockerHub registry by default: (https://hub.docker.com/) and we want to use the official mongoDB image (https://hub.docker.com/_/mongo/) so value on the text box will be "mongo"
		- Network: TCP / Port : 27017
		- Memory/CPU: `default value` (no ressources caping)  
		- Volumes: default
		- Environment Variables: none
		
![mongo](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/CCE%20mongo.png)

**2. Create rocket.chat CCE component template**
		CCE -> Create Template
		- Template Name: rocketchat
		- Container Image: External Container Image. 
		It will use DockerHub registry by default: (https://hub.docker.com/) and we want to use the official Rocket.chat image (https://hub.docker.com/r/rocketchat/rocket.chat/) so value on the text box will be "rocketchat.rocket.chat"
		- Network: TCP / Port : 3000
		- Memory/CPU: `default value` (no ressources caping)  
		- Volumes: default
		- Environment Variables: 
		MONGO_URL : mongodb://mongo/mydb (warning: 'mongo' will be the name of the service created on the next step. Please be sure to use the same value as CCE (kubernetes) won't be able to resolve the name ->IP@)
		
![rocket](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/CCE%20rocket.png)
		
**3. Create the Containerized Application**

CCE -> App Manager -> Create a Containerized App
	- Template Type: Component Template
	- Container Cluster: `your CCE cluster`
	- App Name: myrocketchat

-> App Component: Click on "Create Component":
	- Template Name: `the mongoDB template created on previous step (mongodb)`
	- Component Name : mongoDB
	- Component Description: - 		
	- AZ: Automatic (you can chose 'custom' if you want to deploy on specific AZ) 
	- Node: Automatic (you can chose a node if you want to deploy on a specific node on the CCE cluster)
	- Instances: 1 (to match the Architecture described above)
	- Service name: mongo (warning: 'mongo' is the value defined as env variable for RocketChat MONGO_URL. Please be sure to use the same value as CCE (kubernetes) won't be able to resolve the name ->IP@)
	- Public Service: No
	- Click 'OK' on the App component form

-> App Component: Click on "Create Component":
	- Template Name: `the rocket.chat template created on previous step (rocketchat)`
	- Component Name : rocketchat
	- Component Description: - 		
	- AZ: Automatic (you can chose 'custom' if you want to deploy on specific AZ) 
	- Node: Automatic (you can chose a node if you want to deploy on a specific node on the CCE cluster)
	- Instances: 1 (to match the Architecture described above)
	- Service name: rocketchat
	- Public Service: Yes	
	- Service Type: Load Balancer
	- Load Balancer: The load balancer you want to use (cf. prerequisites)
	- Service Parameters: ELB Port: 3000
	- Click 'OK' on the App component form
	- Click 'OK' on the Containerized App form
		
Wait for the App creation and then click on the App name. Here you can find thetwo components (mongo and rocketchat) with 'Running' status:

![rocketapp](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/rocketchat.png)

If you click on 'rocketchat' you can find address and port on which you can access your website:
![rocketchat IP](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/rocketchat%20IP.png)

You can now access the webpage and follow the setup wizzard to configure your Rocket.Chat. For more details please refer to the Rocket.Chat user guide : https://rocket.chat/docs/user-guides/ 

![Wordpress instances](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/rocketchat%20webpage.png)


## Next steps 
- Demonstrate Scalability & HA


