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
$ heroku git:remote -a guarded-everglades-2095
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
