Il est possible d'exporter les commerçants affichés sur la carte et de les importer dans une application de cartographie comme [CoMaps](https://www.comaps.app/fr), qui fonctionne même sans connexion Internet.

Ce tutoriel vous guide étape par étape afin que vous puissiez accéder aux données des commerçants à tout moment, que vous soyez en voyage, dans un train ou hors ligne.

## Exporter les commerçants depuis la carte

Sélectionnez vos filtres de recherche sur la page de la carte, ou laissez-les inchangés pour exporter tous les commerçants.

Dans cet exemple, nous allons exporter les commerçants acceptant Monero situés en France.

Ouvrez le menu en cliquant sur les trois points verticaux, puis cliquez sur **Télécharger les commerçants**.

![Exporter les commerçants au format GPX](<%= image_path("tutorials/import-merchants-in-comaps/fr/00_export_merchants_as_gpx.png") %>)

## Ouvrir CoMaps

Ouvrez l'application **CoMaps** sur votre smartphone.

![Logo de CoMaps](<%= image_path("tutorials/import-merchants-in-comaps/logo_comaps.webp") %>)

## Ouvrir les Favoris et les traces

Depuis la vue de la carte, appuyez sur l'**icône en forme d'étoile** dans le menu inférieur pour accéder à l'écran **Favoris et traces**.

![Carte vide](<%= image_path("tutorials/import-merchants-in-comaps/fr/01_empty_map.png") %>)

## Importer le fichier GPX

Dans le menu des options, sélectionnez **Importer des favoris et des traces**.

![Paramètres d'importation GPX](<%= image_path("tutorials/import-merchants-in-comaps/fr/02_settings_import_gpx.png") %>)

Parcourez les fichiers de votre appareil jusqu'au fichier `.gpx` que vous venez de télécharger (généralement situé dans le dossier **Téléchargements**), puis sélectionnez-le. L'importation démarrera automatiquement.

> [!NOTE]
> Selon le nombre de commerçants contenus dans le fichier, l'importation peut prendre plus ou moins de temps.

## Afficher les commerçants importés

Une fois l'importation terminée, les commerçants apparaîtront sur la carte.

Vous pouvez désormais les consulter ou les modifier afin de les utiliser pour la navigation hors ligne.

![Carte avec un marqueur ouvert](<%= image_path("tutorials/import-merchants-in-comaps/fr/04_maps_with_opened_marker.png") %>)

## Masquer ou afficher les commerçants importés

Pour masquer les commerçants nouvellement importés, appuyez de nouveau sur l'**icône en forme d'étoile** en bas de la carte, puis désactivez la petite **icône en forme d'œil verte** située à gauche de l'entrée correspondant au fichier importé.

Appuyez à nouveau sur cette icône pour les réafficher.

![Paramètres du fichier GPX importé](<%= image_path("tutorials/import-merchants-in-comaps/fr/03_settings_gpx_imported.png") %>)

> [!WARNING]
> Il n'existe pas de synchronisation automatique. Pour mettre à jour les données des commerçants, vous devrez télécharger à nouveau les commerçants puis les importer manuellement dans CoMaps.

## Besoin d'aide ?

Si vous rencontrez un problème, n'hésitez pas à contacter la communauté sur Telegram, Matrix ou Session. 😉

## Liens utiles

- [Site web de CoMaps](https://www.comaps.app/fr)
- [Support technique sur Telegram](http://t.me/SortieDeBanque)
- [Support technique sur Matrix](https://matrix.to/#/#bankexit:matrix.org)
