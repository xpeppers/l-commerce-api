# linking-commerce-api

## project setup

```
$ bundle
$ rake db:migrate
```

## run tests

```
$ rspec
```

## run server

```
$ rails s
```

## seed initial data

```
$ rake db:seed_fu
```

## deploy development environment with vagrant

```
$ vagrant dev up
$ cap dev deploy
$ curl http://192.168.33.100/api
```

## deploy test environment with heroku

Heroku account: whereyoufindyouraccount

```
$ heroku login
$ heroku git:remote -a linkingcommerce
$ git push heroku master
```

Migrate or seed database

```
$ heroku run rake db:migrate
$ heroku run rake db:seed_fu
```

Access to processes and logs

```
$ heroku ps
$ heroku logs
```

Open the application in a browser

```
$ heroku open
```

Test API

```
$ curl https//linkingcommerce.herokuapp.com/api
```

## deploy production environment with vagrant

requirements: `aws-cli` (pip install awscli)

```
$ aws configure
| AWS Access Key ID: yourawskey
| AWS Secret Access Key: yourawssecret
| Default regione name: eu-west-1
| Default output format: json

```

perform deploy

```
$ cap aws deploy
$ curl http://52.19.150.165/api
```

`52.19.150.165` is the elastic IP automatically assigned by ec2, it
will change every time we re-create the instance. To know the new
assigned IP, check the file: `.vagrant/machines/aws/aws/elastic_ip`.

vagrant can be use to create the ec2 instance. To know the status of
the machine, run:

```
$ vagrant status aws
```

to run the provision on that machine:

```
$ vagrant provision aws
```

to re-create the instance:

```
$ vagrant destroy aws
$ vagrant up aws
```
