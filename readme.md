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

## deploy on heroku

Account heroku: whereyoufindyouraccount

```
$ heroku login
$ heroku git:remote -a linkingcommerce
$ git push heroku master
```

Per migrare e/o popolare il database

```
$ heroku run rake db:migrate
$ heroku run rake db:seed_fu
```

Per accedere ai processi e ai logs

```
$ heroku ps
$ heroku logs
```

Per vede l'applicazione

```
$ heroku open
```

## configure and test the aws-cli
utilizziamo i dati dell'utente `linking-commerce` associato al gruppo `provisioners` per configurare
il terminale aws:
```
$ aws configure
| AWS Access Key ID: yourawskey
| AWS Secret Access Key: yourawssecret
| Default regione name: eu-west-1
| Default output format: json

$ aws sts get-session-token --duration-seconds <900-129600>
| {
|    "Credentials": {
|        "AccessKeyId": "ASIAIWO2C7GONPCNNADA"
|        "SecretAccessKey": "YpgrVQIEY7gr75IBAW7N9wwiX8z95HDXbEi5zNzh",
|        "SessionToken": "AQoDYXdzEOz//////////wEa8AGogVZaFXz74St4aga49WgFiFwEzeM75OWtoLO5/Wluuv/DM5sMOzcibuq3wR5GJ3NJNraz6URUe/n1de3wax7drL68b/3Zd6+VIDsSjXqVvTGkCmeVVrYWc7XJFhYh1zJgl63ooTHVCLd+hUGDaiF7WzttD7usveYmDCUIrVtEF/BO8tSnrDnvXA1BhoKsTIczYhl0rQapMZrF3tvRP2exxgDFw30poVQB1h50r7aHFdwgUNKXjysr2KTBwLLVAywxZ2E/zceWr4RKIrLgSZN9EU5kPUo+X5M008vWbmullWmIUSTZHMRSHB4df3arpo8gxMqgrwU=",
|        "Expiration": "2015-09-03T11:02:32Z",
|    }
| }

```
