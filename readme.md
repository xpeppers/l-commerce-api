# linking-commerce-api

## project setup

## setup db for Mac Users

```
createuser --pwprompt linking_commerce (password: linking_commerce)
createdb -Olinking_commerce -Eutf8 linking_commerce
```

# setup the application

```
bundle
rake db:migrate
```

## run tests

```
rspec
```

## run server

```
rails s
```

## seed initial data

```
rake db:seed_fu
```

## deploy development environment with vagrant

```
vagrant up dev
cap dev deploy
curl http://192.168.33.100/api
```

## deploy test environment with heroku

Setup

Heroku account: whereyoufindyouraccount

```
heroku login
heroku git:remote -a linkingcommerce
```

Deploy

```
git push heroku master
```

Migrate or seed database

```
heroku run rake db:migrate
heroku run rake db:seed_fu
```

Access to processes and logs

```
heroku ps
heroku logs
```

Open the application in a browser

```
heroku open
```

Test API

```
curl https//linkingcommerce.herokuapp.com/api
```

## deploy production environment with vagrant

requirements: `aws-cli` (pip install awscli)

```
vagrant plugin install vagrant-aws
```

```
aws configure
| AWS Access Key ID: yourawskey
| AWS Secret Access Key: yourawssecret
| Default regione name: eu-west-1
| Default output format: json

```

perform deploy

```
cap [aws | aws-vino] deploy
curl [http://52.19.150.165/api | http://54.77.111.102/api]
```

`xx.yy.zzz.www` is the elastic IP automatically assigned by ec2, it
will change every time we re-create the instance. To know the new
assigned IP, check the file: `.vagrant/machines/aws/aws/elastic_ip`.

vagrant can be use to create the ec2 instance. To know the status of
the machine, run:

```
vagrant status [aws | aws-vino]
```

to run the provision on that machine:

```
vagrant provision [aws | aws-vino]
```

to re-create the instance:

```
vagrant destroy [aws | aws-vino]
vagrant up [aws | aws-vino]
```
