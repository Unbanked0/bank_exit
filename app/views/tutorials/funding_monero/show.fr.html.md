> [!IMPORTANT]
> Ce tutoriel explique comment créer une cagnotte en Monero grâce à **Kuno**, une plateforme open source permettant de collecter des dons sans dépendre d'un intermédiaire centralisé.

Monero est une cryptomonnaie conçue pour offrir une forte confidentialité des transactions. Contrairement à de nombreuses plateformes de financement participatif classiques, une cagnotte Monero permet de recevoir des fonds sans risque de blocage arbitraire par une entreprise ou une autorité.

{{toc}}

<%= video_embed(
url: "https://youtube.com/embed/76vxvYrFar4",
title: "Créez une cagnotte INSTOPPABLE en 10 min avec Monero et KUNO !",
created_at: "2024-08-07"
) %>

## Présentation de Kuno

[Kuno](https://kuno.anne.media/lang/fr) est une plateforme open source permettant de créer des cagnottes en Monero.

Le site propose différents types de projets :

- documentaires ;
- projets artistiques ;
- initiatives citoyennes ;
- aides humanitaires ;
- traductions ;
- projets communautaires.

Chaque cagnotte contient :

- une description du projet ;
- l'objectif financier ;
- l'adresse Monero de réception ;
- l'historique des dons ;
- les informations permettant d'identifier le porteur du projet.

Les donateurs peuvent participer simplement en scannant un QR code ou en copiant l'adresse Monero associée à la cagnotte.

### Exemple de cagnotte

Une première cagnotte créée par le Collectif concernait le soutien aux agriculteurs.

Elle a permis de collecter :

- plus de 5,65 XMR ;
- auprès d'une trentaine de contributeurs ;
- soit plusieurs centaines d'euros selon le cours du Monero au moment des dons.

Les contributeurs restent anonymes, mais la blockchain Monero permet de vérifier les montants reçus et les dates des transactions.

La cagnotte contient également :

- une description détaillant l'utilisation des fonds ;
- des photos ;
- un historique des dons reçus ;
- des commentaires éventuels.

### Pourquoi utiliser une cagnotte Monero ?

Les plateformes traditionnelles comme Leetchi ou GoFundMe reposent sur des entreprises privées.

Elles peuvent potentiellement :

- bloquer une collecte ;
- demander des justificatifs ;
- suspendre un compte ;
- empêcher l'accès aux fonds.

Avec une cagnotte Monero :

- les fonds reçus ne peuvent pas être annulés ;
- aucun intermédiaire financier ne contrôle les paiements ;
- la collecte reste accessible même si le site disparaît.

La plateforme Kuno pourrait théoriquement être indisponible, mais les fonds déjà envoyés restent définitivement sur la blockchain Monero.

Cette technologie permet donc de créer des outils de financement plus résistants à la censure.

## Créer une cagnotte Kuno

Rendez-vous sur [Kuno](https://kuno.anne.media/lang/fr). Cliquez ensuite sur **Start a Kuno**. La création d'une cagnotte se déroule en plusieurs étapes.

### Les informations générales

Vous devez renseigner :

- le titre de la cagnotte ;
- une description ;
- un objectif financier ;
- une adresse Monero ;
- une clé de vue privée Monero ;
- éventuellement un email et un mot de passe.

### Le titre et la description

La description est un élément essentiel.

Elle doit expliquer :

- pourquoi vous créez cette cagnotte ;
- qui vous êtes ;
- comment les fonds seront utilisés ;
- quels résultats sont attendus ;
- comment vous contacter ou vérifier votre identité.

Si vous possédez une communauté existante, indiquez-la également afin de renforcer la confiance.

Vous pouvez ajouter :

- des images ;
- des tags ;
- des liens de contact.

### Définir un objectif

L'objectif correspond au montant que vous souhaitez collecter en Monero.

Il est préférable de commencer avec un objectif réaliste.

Une première réussite permet :

- de montrer que le projet fonctionne ;
- de rassurer les contributeurs ;
- de créer une dynamique autour de la collecte.

### Créer un portefeuille Monero avec Cake Wallet

[Voir le tutoriel Cake Wallet](<%= url_for tutorial_path("cakewallet-monero") %>)

### Récupérer l'adresse Monero

Dans Cake Wallet :

1. Ouvrez l'écran principal.
2. Cliquez sur **Recevoir**.
3. Copiez votre adresse Monero.

Cette adresse sera utilisée pour recevoir les dons.

Une adresse Monero standard commence généralement par `4`.

N'utilisez pas :

- une sous-adresse commençant par `8` ;
- une autre adresse secondaire.

Kuno doit utiliser l'adresse principale afin de pouvoir suivre correctement les paiements.

### Récupérer la clé de vue privée

Kuno a besoin de votre **clé de vue privée** afin de détecter les transactions reçues.

Cette clé permet uniquement :

- d'observer les transactions entrantes ;
- de calculer le montant reçu.

Elle ne permet pas :

- d'envoyer des fonds ;
- de dépenser votre Monero.

Dans Cake Wallet :

1. Ouvrez les paramètres.
2. Allez dans **Sécurité et sauvegarde**.
3. Sélectionnez **Afficher la phrase secrète et les clés**.
4. Entrez votre code PIN.
5. Descendez jusqu'à trouver :

`Secret view key`

Copiez uniquement cette clé.

Ne partagez jamais :

- votre phrase de récupération ;
- votre clé privée de dépense.

### Finaliser la cagnotte

Retournez sur Kuno et renseignez :

- votre adresse Monero ;
- votre clé de vue privée ;
- un email optionnel ;
- un mot de passe.

L'email peut permettre de modifier la cagnotte plus tard.

Vous pouvez également activer les notifications lors de nouveaux dons.

Cliquez ensuite sur **Start**.

Votre cagnotte est maintenant créée.

## Recevoir des dons

Votre cagnotte affichera :

- un QR code ;
- votre adresse Monero ;
- votre objectif ;
- votre progression.

Les contributeurs peuvent alors :

1. ouvrir leur portefeuille Monero ;
2. scanner le QR code ;
3. choisir un montant ;
4. envoyer la transaction.

Les dons apparaîtront automatiquement sur la cagnotte grâce à la clé de vue privée.

## Suivre les fonds

Les transactions entrantes seront visibles sur Kuno.

En revanche, Kuno ne voit pas les dépenses effectuées depuis votre portefeuille.

La plateforme affiche uniquement :

- les dons reçus ;
- les montants collectés ;
- l'historique des transactions entrantes.

Vos dépenses restent privées.

## Bonnes pratiques

Pour conserver une cagnotte sécurisée :

- gardez votre phrase de récupération hors ligne ;
- ne partagez jamais votre clé privée ;
- utilisez une adresse Monero dédiée à la cagnotte ;
- expliquez clairement l'utilisation des fonds ;
- fournissez des moyens de vérification aux contributeurs.

Une cagnotte Monero permet de reprendre le contrôle du financement participatif en supprimant les intermédiaires et en offrant une meilleure résistance à la censure.
