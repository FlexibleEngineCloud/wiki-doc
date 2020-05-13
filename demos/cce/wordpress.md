<!-- TITLE: 2. Wordpress -->
<!-- SUBTITLE: A quick summary of Cce -->

# Wordpress Website 

The goal of this demo is to deploy a wordpress website on CCE using various FE services.
WordPress is a free and open-source content management system (CMS) based on PHP and MySQL. Features include a plugin architecture and a template system. It is most associated with blogging, but supports other types of web content including more traditional mailing lists and forums, media galleries, and online stores. Used by more than 60 million websites, including 30.6% of the top 10 million websites as of April 2018, WordPress is the most popular website management system in use.

## Prerequisites 
- Web access to Flexible Engine platform (APIs are not used for now)
- CCE cluster with 3 (or more) nodes. Best practice is to deploy nodes on both AZ (cf. CCE Cluster creation guide: https://docs.prod-cloud-ocb.orange-business.com/en-us/usermanual/cce/en-us_topic_0035200399.htm) 
- an Elastic Load Balancer  (cf. classic or enhanced load blancer creation guide: https://docs.prod-cloud-ocb.orange-business.com/en-us/usermanual/elb/en-us_elb_02_0000.html . Just create the ELB, no Listeners are requested).
- a mySQL RDS database that can be reached by the CCE Cluster (network and Security Groups) (cf. mySQL RDS creation guide: https://docs.prod-cloud-ocb.orange-business.com/en-us/usermanual/rds/en-us_topic_0046585334.html). You will need the DB password on the next step.

## Architecture
The CCE cluster is be deployed on 2 availability zones (AZ) and contains 3 nodes (based on Elastic Cloud Servers (ECS)). 3 instances of wordpress (frontends) will be deployed on nodes and interconnected to a mySQL RDS database. Static files can be hosted on a OBS bucket (not included on this tutorial as it can be done by installing a Wordpress s3 plugin like https://wordpress.org/plugins/wp2cloud-wordpress-to-cloud/) 
![Web App Reference Architecture](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/Wordpress%20CCE%20RDS%20S3%20%281%29.png)

## Services used
- Cloud Container Engine: to deploy Wordpress frontends 
- Relational Database Service (RDS): for mySQL database 
- Domain Name Service (DNS): used as private registry to point on RDS database adress
- Elastic Load Balancer (ELB): used as Load Balancer above CCE cluster

## Step by Step deployment guide
**1. Create a private DNS record set:**		
		DNS service -> Create Private Zone
		- Name: services.fe.
		- VPC: same as CCE cluster
		DNS service -> Private Zones -> services.fe. -> Add Record Set
		- Name: mysql
		- Type: A-Map domains to IPV4 addresses
		- TTL: 300 / 5 minutes
		- Value: `ip of your RDS database`
		You should have something like this 
		![DNS](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/DNS.png)
		
**2. Create CCE component template**
		CCE -> Create Template
		- Template Name: wordpress-rds
		- Container Image: External Container Image. 
		It will use DockerHub registry by default: (https://hub.docker.com/) and we want to use the official Wordpress image (https://hub.docker.com/_/wordpress/ ) so value on the text box will be "wordpress"
		- Network: TCP / Port : 80
		- Memory/CPU: `default value` (no ressources caping)  
		- Volumes: default
		- Environment Variables: 
		WORDPRESS_DB_HOST : mysql.services.fe:8635 (warning: change the RDS database port if needed)
		WORDPRESS_DB_PASSWORD : `your database password` (the one you have set during RDS creation)
		![DNS](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/CCE%20wordpress.png)

**3. Create the Containerized Application**

CCE -> App Manager -> Create a Containerized App
	- Template Type: Component Template
	- Container Cluster: `your CCE cluster`
	- App Name: mywordpress

-> App Component: Click on "Create Component":
	- Template Name: `the template created on previous step (wordpress-rds)`
	- Component Name : wordpress-rds
	- Component Description: - 		
	- AZ: Automatic (you can chose 'custom' if you want to deploy on specific AZ) 
	- Node: Automatic (you can chose a node if you want to deploy on a specific node on the CCE cluster)
	- Instances: 3 (to match the Architecture described above)
	- Service name: wordpress-rds
	- Public Service: Yes
	- Service Type: Load Balancer
	- Load Balancer: The load balancer you want to use (cf. prerequisites)
	- Service Parameters: ELB Port: 80
	- Click 'OK' on the App component form
	- Click 'OK' on the Containerized App form
		
Wait for the App creation and then click on the App name. Here you can find the ELB ip adress and port on which you can access your website:
![Wordpress App](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/App%20CCE.png)

You can see that Wordpress is now running on 3 containers hosted on 3 CCE nodes :
![Wordpress instances](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/wordpress%20CC%20instances.png)


## Next steps 
- Demonstrate Scalability & HA


