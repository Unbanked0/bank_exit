> [!IMPORTANT]
> Cet atelier présente des outils numériques libres et résilients face aux menaces croissantes sur la vie privée : régulations européennes type « Chat Control » (déchiffrement des messages par les institutions), obligation de carte d'identité pour les réseaux sociaux en France à partir de septembre pour les nouveaux comptes et janvier pour les comptes existants, censure institutionnelle. L'objectif est de reprendre le contrôle de ses communications — conversations individuelles, groupes restreints, publications publiques — sans dépendre d'une juridiction ou d'un acteur unique pouvant être contraint de divulguer vos données.

Deux familles d'outils sont explorées : des **messageries chiffrées** (Session, Matrix) et des **réseaux sociaux décentralisés** (Nostr, Mastodon). SimpleX est évoqué en bonus mais non recommandé comme priorité pour éviter la dispersion.

<%= video_embed(
url: "https://www.youtube.com/embed/OWYkYrSJuck",
title: "
Atelier anti-censure #KipInTouche - Session Matrix Nostr Mastodon 07-2026",
created_at: "2026-07-25"
) %>

## Comprendre les deux architectures : décentralisé VS fédéré

Avant de choisir un outil, il est essentiel de distinguer deux modèles d'organisation réseau.

- **Décentralisé** (Session, Nostr) — Le réseau est entièrement horizontal : aucun serveur central n'a de rôle hiérarchique. Votre compte existe indépendamment de tout nœud particulier. Si un relais ferme, votre compte survit. La résilience dépend cependant de la vitalité globale du réseau : si plus personne ne fait tourner de nœuds, le réseau meurt.

- **Fédéré** (Matrix, Mastodon) — Le réseau est composé de serveurs indépendants reliés entre eux. Vous créez votre compte sur un serveur spécifique. Si ce serveur tombe, votre compte tombe avec. En revanche, vous pouvez lancer votre propre serveur et garder un contrôle total. La résilience repose sur la personne ou le collectif qui administre le serveur.

| Critère                  | Décentralisé     | Fédéré                     |
| ------------------------ | ---------------- | -------------------------- |
| Dépendance à un serveur  | Aucune           | Lié au serveur choisi      |
| Mise en route            | Rien à gérer     | Un serveur à administrer   |
| Si un nœud/serveur tombe | Le compte survit | Le compte peut disparaître |
| Auto-hébergement         | Pas nécessaire   | Possible et recommandé     |

## Messageries chiffrées

### Session — Messagerie décentralisée

Session est une messagerie chiffrée décentralisée, inspirée du code de Signal mais sans ses inconvénients. Signal est centralisé et hébergé sur des serveurs Amazon aux États-Unis, soumis au Cloud Act (la NSA et la CIA peuvent exiger l'accès aux messages). Session reprend les principes de chiffrement de Signal mais les applique sur un réseau décentralisé et mondial.

**Caractéristiques principales :**

- Chiffrement de bout en bout (protocole issu de Signal)
- Réseau décentralisé : aucun serveur central, pas de juridiction unique
- Groupes jusqu'à 50 personnes chiffrés (au-delà, chiffrement limité)
- Disponible sur téléphone (iOS, Android) et ordinateur (Windows, Mac, Linux)
- Appels audio pris en charge
- Pas de numéro de téléphone ni d'email requis

**Comment démarrer :**

Voir le [tutoriel Session](<%= tutorial_path("session-messaging") %>) complet sur Sortie de Banque.

**Résilience à la censure :** Session n'est pas basé sur un nom de domaine, un serveur particulier ou une juridiction. Couper le réseau est extrêmement difficile pour un censeur.

> [!NOTE]
> **Transparence sur le financement :** La fondation qui maintient Session a rencontré des difficultés de financement mais a obtenu des fonds pour continuer environ 6 à 12 mois supplémentaires. Même si la fondation s'arrêtait, le réseau décentralisé continuerait de fonctionner tant que les nœuds relais sont actifs — comme le réseau Bitcoin continue si la fondation Bitcoin disparaît.

### Matrix (client : Element) — Messagerie fédérée

Matrix est un protocole de messagerie fédérée. Le client le plus connu est **Element** (anciennement Element Classic, et **Element X** pour les versions mobiles récentes).

**Caractéristiques principales :**

- Chiffrement de bout en bout
- Architecture fédérée : vous choisissez un serveur (ou créez le vôtre)
- Groupes potentiellement très larges (jusqu'à des dizaines de milliers d'utilisateurs sur un gros serveur)
- Disponible en version web (sans installation), application bureau (Windows, Mac, Linux) et mobile (iOS : Element X, Android : Element X)
- Sauvegarde chiffrée des sessions pour la récupération multi-appareils

**Clients disponibles :**

| Plateforme            | Client recommandé                                           |
| --------------------- | ----------------------------------------------------------- |
| Web                   | [app.element.io](https://app.element.io) (rien à installer) |
| Windows / Mac / Linux | Element Desktop                                             |
| iOS                   | Element X                                                   |
| Android               | Element X                                                   |
| F-Droid               | Element                                                     |

**Comment démarrer :**

1. Rendez-vous sur [matrix.org](https://matrix.org) ou utilisez la version web [app.element.io](https://app.element.io).
2. Cliquez sur « Créer un compte ».
3. **Choisissez votre serveur d'accueil** (homeserver) :

> [!IMPORTANT]
> Par défaut, Matrix.org est le serveur principal, basé au Royaume-Uni. Si ce serveur se soumet à une injonction juridique, tous ses utilisateurs sont concernés. Le mieux à terme est d'utiliser un serveur indépendant (collectif, association) ou de lancer le vôtre. Exemple : le serveur de la communauté « Sortie de Banque » est [matrix.bank-exit.org](https://matrix.to/#/#go:matrix.bank-exit.org).

4. Saisissez un nom d'utilisateur et un mot de passe robuste.
5. Confirmez votre email via le lien reçu.
6. Choisissez vos préférences (notifications, partage de données — désactivez si vous souhaitez limiter les métadonnées).

**Utilisation :**

- **Rejoindre un salon public :** Recherchez un salon (ex. : Matrix Community à l'adresse `community2.matrix.org`) et cliquez sur « Rejoindre ».
- **Créer votre propre groupe :** Choisissez « Créer un espace », définissez-le en public ou privé, puis suivez les étapes.
- **Partager votre contact :** Cliquez sur votre profil en haut à gauche, copiez votre lien personnel et partagez-le.
- **Sauvegarde de sécurité :** Matrix vous demandera de créer une clé de récupération pour restaurer vos sessions et messages en cas de perte d'appareil.

> [!WARNING]
> Sauvegardez précieusement votre clé de récupération. Elle permet de gérer vos sessions entre plusieurs appareils et de révoquer une session compromise (ex. : téléphone volé) pour empêcher l'usurpation d'identité.

**Auto-hébergement :**

Pour héberger votre propre serveur Matrix : un script d'installation automatique est disponible auprès de la communauté « Sortie de Banque ». Il suffit d'indiquer le nom souhaité pour le serveur, et le script configure l'ensemble. Une configuration standard (environ 100 Go de disque et 4 Go de RAM) peut accueillir plusieurs milliers d'utilisateurs. Matrix fonctionne comme une base de données (pas une blockchain) : sauvegarder les fichiers suffit pour migrer vers un nouveau serveur de manière transparente.

## Réseaux sociaux décentralisés

### Nostr — Réseau social décentralisé

Nostr (Notes and Other Stuff Transmitted by Relays) est un protocole de réseau social décentralisé. Il fonctionne comme Twitter (likes, reposts, commentaires, profil personnel) mais sans serveur central. Une fois un message publié, il devient **incensurable** : même l'auteur ne peut pas le retirer. C’est la force principale de Nostr face à la censure institutionnelle.

> [!NOTE]
> **Protocole vs client :** Nostr est le protocole (le réseau), pas une application. Les clients sont les logiciels/applications que vous utilisez pour y accéder — comme Outlook ou Thunderbird sont des clients pour le protocole email. Par exemple, le site web [phoenix.social](https://phoenix.social) est un client Nostr, tout comme Damus sur iOS ou Amethyst sur Android.

**Clients disponibles :**

| Plateforme   | Client recommandé                        | Remarque                                                                          |
| ------------ | ---------------------------------------- | --------------------------------------------------------------------------------- |
| Web          | [phoenix.social](https://phoenix.social) | Accès direct, sans compte requis                                                  |
| iPhone / iOS | Damus ou Primal                          | Primal = plus fluide, Damus = plus résilient                                      |
| Android      | Amethyst ou Primal                       | Amethyst = plus lent mais résilient, Primal = fluide mais dépend du cache serveur |

> [!TIP]
> Pour un usage quotidien, **Primal** offre une expérience fluide proche de Twitter. Pour une résilience maximale, **Amethyst** est préférable car il ne dépend pas d'un serveur de cache centralisé.

**Comment démarrer :**

Voir la [présentation du protocole Nostr](<%= blog_path("nostr-protocol") %>) et le [tutoriel Snort](<%= tutorial_path("nostr-social-network") %>) complet sur Sortie de Banque.

**Fonctionnalités notables :**

- **Zaps en Bitcoin Lightning :** Nostr intègre des micropaiements directs en Bitcoin Lightning. Vous pouvez soutenir un auteur ou un média en cliquant sur l'icône de zap et en choisissant un montant. Pas de carte bancaire, paiement en crypto directement.

> [!NOTE]
> La communauté privilégie **Monero** plutôt que Bitcoin Lightning pour des raisons de souveraineté financière. Des versions de Nostr permettant des zaps en Monero sont en développement.

- **Relais de médias :** Des ponts entre Nostr et des médias traditionnels (journaux connus) existent. Même si Twitter est bloqué ou suspendu, vous pouvez continuer à suivre l'actualité de manière incensurable via Nostr.

**Trouver la communauté « Sortie de Banque » sur Nostr :**

Recherche le hashtag [#KipInTouche](https://phoenix.social/t/Kipintouche) de la communauté dans la barre de recherche du client Nostr pour accéder directement aux publications, abonnés et abonnements.

### Mastodon — Réseau social fédéré

Mastodon fonctionne sur le même modèle fédéré que Matrix : vous créez un compte sur un serveur choisi, et les serveurs communiquent entre eux.

**Caractéristiques principales :**

- Architecture fédérée (comme Matrix)
- Interface proche de Twitter
- Modération par serveur : administrateurs et modérateurs gèrent les règles, expulsent les perturbateurs
- Salons/groupes configurables en public, sur invitation uniquement, etc.
- Nombreux clients disponibles (Android, iPhone, web, ordinateur, voire vieux systèmes)

**Comment démarrer :**

1. Rendez-vous sur [mastodon.social](https://mastodon.social) (serveur principal) ou choisissez un autre serveur.
2. Cliquez sur « Rejoindre ».
3. Choisissez une application cliente parmi les nombreuses options listées sur le site.

> [!IMPORTANT]
> Comme pour Matrix, le choix du serveur est crucial. Le serveur principal ([mastodon.social](https://mastodon.social)) est soumis à une juridiction. Si le serveur se soumet à une pression légale, tous ses utilisateurs sont concernés. L'idéal est d'avoir un serveur géré par votre collectif pour un contrôle total sur la modération et la résilience.

**Modération :**

> [!TIP]
> Mastodon n'est pas anarchique malgré sa nature libre. Chaque serveur a ses propres administrateurs, modérateurs et règles. Vous pouvez configurer vos groupes en mode public, sur invitation uniquement, ou restreint. En cas de comportement abusif, les administrateurs peuvent supprimer les utilisateurs, comme sur Telegram.

## Bonus : SimpleX

SimpleX est mentionné comme option bonus. Il s'agit d'une messagerie techniquement avancée permettant de gérer plusieurs identités. La communauté ne le pousse pas en priorité pour éviter la dispersion : trop d'outils diluent les efforts et empêchent la masse critique de se former sur chaque plateforme.

## Tableau récapitulatif des outils

| Outil                 | Type                                                     | Architecture                                       | Usage                       | Tutoriel                                             |
| --------------------- | -------------------------------------------------------- | -------------------------------------------------- | --------------------------- | ---------------------------------------------------- |
| **Session**           | <span class="badge badge-primary">Messagerie</span>      | <span class="badge badge-info">Décentralisé</span> | 1-to-1 et groupes ≤ 50      | [Lien](<%= tutorial_path("session-messaging") %>)    |
| **Matrix / Element**  | <span class="badge badge-primary">Messagerie</span>      | <span class="badge badge-success">Fédéré</span>    | Groupes larges, scalable    | /                                                    |
| **Nostr**             | <span class="badge badge-secondary">Réseau social</span> | <span class="badge badge-info">Décentralisé</span> | Publication incensurable    | [Lien](<%= tutorial_path("nostr-social-network") %>) |
| **Mastodon**          | <span class="badge badge-secondary">Réseau social</span> | <span class="badge badge-success">Fédéré</span>    | Alternative Twitter modérée | /                                                    |
| **SimpleX** _(bonus)_ | <span class="badge badge-primary">Messagerie</span>      | <span class="badge badge-info">Décentralisé</span> | Multi-identités             | /                                                    |

## Recommandations pratiques

- **Priorité de migration :** Commencez par **Session** pour la messagerie quotidienne (simple, rien à gérer) et **Nostr** pour suivre l'actualité de manière incensurable. Ajoutez **Matrix** si vous avez un collectif capable d'administrer un serveur, et **Mastodon** pour une présence type Twitter avec modération.

- **Sur iOS (Apple) :** L'App Store est un environnement fermé. Apple décide unilatéralement des applications autorisées. C'est une impasse pour la résilience. Si vous souhaitez aller loin, envisagez de quitter iOS. Android est plus ouvert mais commence aussi à resserrer l'étau sur les applications libres. Les prochaines années pourraient voir Google restreindre l'installation d'applications hors Play Store. Les ordinateurs restent les plateformes les plus ouvertes.

- [OnlyOffice](https://www.onlyoffice.com/fr) : Mentionné pendant l'atelier comme alternative libre et gratuite à Microsoft Office (documents, classeurs, présentations, formulaires PDF). Design moderne, remplace avantageusement les abonnements Office à 7–12 €/mois. LibreOffice est aussi une option valable, bien que son design soit plus archaïque.

> [!IMPORTANT]
> L'objectif n'est pas d'utiliser tous ces outils simultanément mais de se concentrer sur quelques-uns pour atteindre une masse critique. Si Pierre est sur Session, Paul sur SimpleX et Jacques sur Matrix, personne ne se retrouve. Choisissez collectivement et convergez.
