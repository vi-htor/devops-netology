Description
=========

Ох и запарила интеграция python >3.7 версии в centos 7, а точнее установка зависимостей `flask flask-jsonpify flask-restful`. Ну и деплой самого кубика в яндексе, там документация местами совсем не понятная (ведёт на битые файлы, не указывает явно что откуда брать, честно говоря, даже будучи senior-специалистом, не хотел бы платить за такой продукт не малые деньги чтобы получать такую неявную документацию).   
Но по итогу всё вышло, весьма интересно получилось.  
Итак, по порядку:  
- файл [gitlab-ci.yml](https://gitlab.com/vi-htor/09-ci-06-gitlab/-/blob/main/.gitlab-ci.yml);
- [Dockerfile](https://gitlab.com/vi-htor/09-ci-06-gitlab/-/blob/main/Dockerfile);
- любой на выбор [pipeline](https://gitlab.com/vi-htor/09-ci-06-gitlab/-/pipelines)(кроме первого);
- решённый [issue](https://gitlab.com/vi-htor/09-ci-06-gitlab/-/issues/1).  
Ну и на всякий, ссылка на сам gitlab [repo](https://gitlab.com/vi-htor/09-ci-06-gitlab).