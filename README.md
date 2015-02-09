# Recall App

「[tuts+](ode.tutsplus.com)」というサイトの[sinatra](http://www.sinatrarb.com)のチュートリアル記事である「[Singing with Sinatra](http://code.tutsplus.com/series/singing-with-sinatra--net-19113)」で作成するウェブアプリ「The Recall App」を再現したものである。

上記のチュートリアル記事の通りにウェブアプリを作成した後、記事の理解度を確認するために、チュートリアル記事を見ないで同じウェブアプリを再現した。

チュートリアル記事のオリジナルのウェブアプリとは以下の点が異なっている。

- sinatraの使用スタイル。Classic Styleではなく、Modular Applicationにしている。
- CSSフレームワークとして、[Bootstrap](http://getbootstrap.com)を使用している。
- ORMとして、[DataMapper](http://datamapper.org)ではなく[ActiveRecord](https://github.com/rails/rails/tree/master/activerecord)を使用している。
- flashの表示のために、rack-flashではなく、[sinatra-flash](https://github.com/SFEley/sinatra-flash)を使用している。
