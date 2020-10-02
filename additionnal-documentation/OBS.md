---
title: Object Storage Service
description: 
published: true
date: 2020-10-02T16:06:07.000Z
tags: 
editor: markdown
---

# Front End
## Use a custom domain name instead of the OBS Endpoint
To use a custom domain name instead of the OBS Endpoint, you can simply use our API Gateway service to proxy the standard OBS Endpoint, here is how to do it.

### Pre-requisite
- External domain name subscribed from your favorite registrar
- Valid SSL Certificate
- Access to OBS Service
- Access to API Gateway Service

### Limitations
- 1 API per bucket and per type of operation (put, get...)
- 1 Architecture possible, with folders, or with root folder only

### How-to
#### Create the custom API 
On the **Flexible Engine console**, click on **API Gateway** Service

1. In the **API Publishing** tabs, click on **API Groups** then click on **Create API Group**
2. Name it and click on **OK**
3. After the creation, click on the groups you created and in the **APIs** tabs, click on **Create API**
4. Name it, select the API Groups you created and select **IAM** in the security section then click on **Next**

> On the next page, **2 architectures are possible** :
You always use folders in the bucket, follow the step 5
You will not use folders in the bucket, go to the step 7
{.is-warning}

##### Folders Architecture
5. Choose HTTPS, fill the path, choose the method you need (Get, Put...) then add the input parameter as below![5-1.png](/5-1.png)

6. For the **backend address** put the URL of the complete URL of the bucket (you can found it in the OBS Console) then follow the image below
![6.png](/6.png)

Go to step 9. 

##### Root folder Architecture
7.  Choose HTTPS, fill the path, choose the method you need (Get, Put...) then add the input parameter as below![5-2.png](/5-2.png)

8. For the **backend address** put the URL of the complete URL of the bucket (you can found it in the OBS Console) then follow the image below![9.png](/9.png)


9. Fill the example response : 
HTTP/1.1 status_code
Server: Server Name
x-amz-request-id: request id
x-reserved: amazon, aws and amazon web services are trademarks or registered trademarks of Amazon Technologies, Inc
x-amz-id-2: id
Content-Type: type
Date: date
Content-Length: length

Then click on **Finish**
On the next page, click on **Publish API**. Your API is now online.

#### Bound the external domain name to the API Group
On the **Flexible Engine console**, click on **API Gateway** Service, then on the **API Groups**, click on the API group you created and click on the domain name tabs
1. In this page, you can find the subdomain name of the API Group created, go to your registrar then create a CNAME entry that redirect to this subdomain
2. Go back on the **Flexible Engine API Gateway Console**, and now click on **Bind Domain Name** then enter your domain name
3. After the domain is added, click on **Add SSL Certificate**

Now you can access to your bucket through your custom domain name 

