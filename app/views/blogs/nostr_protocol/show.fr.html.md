> [!IMPORTANT]
> Internet repose aujourd’hui sur de grandes plateformes qui centralisent une grande partie de nos échanges : réseaux sociaux, services de messagerie, plateformes de publication ou espaces communautaires.
>
> Nostr propose une approche différente : un protocole ouvert permettant de publier et d’échanger des informations sans dépendre d’un serveur ou d’une entreprise unique. Pensé comme une infrastructure simple et décentralisée, Nostr donne aux utilisateurs davantage de contrôle sur leur identité numérique et leurs contenus.

## Qu’est-ce que Nostr ?

Nostr signifie **Notes and Other Stuff Transmitted by Relays**. Il ne s’agit pas d’un réseau social particulier, mais d’un **protocole** : un ensemble de règles permettant à différentes applications de communiquer entre elles.

Comme HTTP pour le web ou SMTP pour les emails, Nostr définit une manière standardisée d’échanger des informations entre utilisateurs.

L’objectif est de permettre à chacun de :

- posséder son identité numérique ;
- publier des messages sans dépendre d’une plateforme centrale ;
- choisir ses applications ;
- conserver son réseau en changeant d’outil.

> [!NOTE]
> Nostr n’est pas une application. C’est une technologie sur laquelle différentes applications peuvent être construites.

## Pourquoi un nouveau protocole ?

Les réseaux sociaux traditionnels fonctionnent généralement avec une architecture centralisée :

Cette architecture offre une expérience simple, mais elle crée une dépendance envers une plateforme unique.

Une entreprise peut modifier ses règles, limiter l’accès à un compte ou changer la manière dont les contenus sont distribués.

Nostr propose une architecture différente :

Dans ce modèle, les utilisateurs communiquent grâce à plusieurs relais indépendants.

## Comment fonctionne Nostr ?

Nostr permet de publier des messages sans dépendre d'une plateforme centrale. Au lieu d'envoyer vos publications vers un seul serveur, votre application les transmet à un ou plusieurs **relais**. Les autres utilisateurs peuvent ensuite les consulter à partir de ces relais.

Le fonctionnement est simple :

1. vous rédigez un message dans votre application ;
2. votre application signe automatiquement ce message avec votre **clé privée** ;
3. le message signé est publié sur un ou plusieurs **relais** ;
4. les autres utilisateurs peuvent vérifier son authenticité grâce à votre **clé publique**, puis le consulter avec l'application de leur choix.

## Une identité numérique basée sur la cryptographie

Contrairement aux réseaux sociaux traditionnels, Nostr ne nécessite pas de créer un compte avec une adresse e-mail et un mot de passe.

Votre identité est représentée par une **paire de clés cryptographiques** :

- **la clé privée** est votre secret. Elle reste sur votre appareil et permet de signer vos publications ;
- **la clé publique** est votre identifiant. Vous pouvez la partager librement afin que les autres puissent retrouver votre profil et vérifier que vos publications proviennent bien de vous.

Les relais ne connaissent jamais votre clé privée. Ils stockent et transmettent simplement les messages signés. Chaque application peut ensuite vérifier la signature à l'aide de votre clé publique afin de garantir l'authenticité des publications.

## Les événements

Dans Nostr, les actions sont représentées sous forme d’événements :

- publication d’un message ;
- réaction ;
- abonnement ;
- mise à jour d’un profil ;
- partage de contenu.

Chaque événement contient notamment :

- un auteur ;
- un contenu ;
- une date ;
- une signature cryptographique.

## Les relais

Les relais sont des serveurs qui transportent les événements.

Ils peuvent :

- recevoir des messages ;
- stocker des informations ;
- transmettre des contenus.

Un utilisateur peut utiliser plusieurs relais en même temps.

> [!TIP]
> Cette architecture permet de créer des relais publics, privés ou spécialisés selon les besoins.

## Utiliser Nostr au quotidien

Pour découvrir Nostr :

1. choisir une application compatible ;
2. créer une identité ;
3. suivre d’autres utilisateurs ;
4. publier des messages.

L’expérience ressemble à celle d’un réseau social classique, mais l’identité appartient à l’utilisateur.

## Les avantages de Nostr

### Une identité portable

L’utilisateur garde la même identité même lorsqu’il change d’application.

### Un protocole ouvert

N’importe qui peut créer :

- une application ;
- un relais ;
- un service complémentaire.

### Une infrastructure distribuée

Le réseau ne dépend pas d’un serveur unique.

### De nouveaux usages possibles

Nostr peut servir de base à :

- des réseaux sociaux décentralisés ;
- des communautés spécialisées ;
- des outils de publication ;
- de nouveaux services numériques.

## Les limites de Nostr

### La gestion des clés

La clé privée est indispensable.

> [!WARNING]
> Une clé privée Nostr doit rester secrète. Sa perte peut entraîner la perte de l’identité associée.

### Une expérience encore technique

La création d’une identité et la compréhension des relais peuvent demander un apprentissage.

### La modération

Il n’existe pas de modération centrale unique.

Les applications et les relais doivent donc mettre en place leurs propres mécanismes de filtrage.

## Nostr et les technologies ouvertes

| Technologie                | Approche                                                    |
| -------------------------- | ----------------------------------------------------------- |
| Email                      | Plusieurs fournisseurs compatibles avec un protocole commun |
| Web                        | Des sites indépendants reliés par des standards ouverts     |
| Nostr                      | Des identités et messages échangés via un protocole ouvert  |
| Réseaux sociaux classiques | Une plateforme contrôle généralement les comptes            |

Le principe fondamental de Nostr est de séparer le protocole des applications.

## Quel avenir pour Nostr ?

Nostr est encore une technologie émergente.

Son développement dépendra notamment de sa capacité à devenir accessible au grand public tout en conservant ses principes :

- ouverture ;
- portabilité ;
- contrôle utilisateur ;
- absence de dépendance envers une plateforme unique.

## Aller plus loin

Si vous souhaitez découvrir Nostr de manière pratique, un [tutoriel dédié](<%= tutorial_path("nostr-social-network") %>) est déjà disponible sur ce site pour vous accompagner dans vos premiers pas.

Ce guide explique notamment comment démarrer avec Nostr en utilisant le client web Snort, créer votre identité, configurer vos premiers relais et publier vos premiers messages.

Une fois ces bases acquises, vous pourrez explorer les différentes applications compatibles avec Nostr et découvrir un écosystème en constante évolution.

## Liens utiles

- Site officiel de Nostr : https://nostr.com/
- Trouver des contacts Twitter ayant rejoint Nostr : https://nostr.directory/
- Spécifications du protocole Nostr (NIPs) : https://github.com/nostr-protocol/nips
- Ressources Nostr : https://nostr.net/
- Client web Nostr Primal : https://primal.net/
- Client Android Nostr Amethyst : https://github.com/vitorpamplona/amethyst
- Client iOS Nostr Damus : https://damus.io/
