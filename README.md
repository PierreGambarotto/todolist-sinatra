Exemple d'application Sinatra/base de données
=============================================

## Tester l'application

    rake db:migrate # création de la base de développement
    ruby app.rb # http://localhost:4567

## Utilisation de la base de données

La base de données s'utilise par inclusion de `db/database.rb`.

## Vues

Les vues sont dans le répertoire `views` et sont en erb.

## Tests

Les tests dans `spec` utilisent le matcher `have_tag` fourni par la gem
`rspec-html-matchers`.

Le fichier `spec/spec_helper.rb` donne un exemple de configuration.

Pour exécuter les tests:

    rake db:migrate RACK_ENV=test # création de la base de test
    rake spec


