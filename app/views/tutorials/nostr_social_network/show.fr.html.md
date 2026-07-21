> [!IMPORTANT]
> **Nostr** (_Notes and Other Stuff Transmitted by Relays_) est un protocole réseau décentralisé qui agit comme un réseau social distribué. N'importe qui peut faire fonctionner son propre relais (serveur), permettant ainsi de limiter la censure grâce à la redondance des messages publiés.

Dans ce tutoriel, nous allons utiliser le client **Snort**, mais le processus reste similaire sur la plupart des sites et applications Nostr.

Une fois votre compte créé avec Snort, vous pourrez changer d'application ou de site à tout moment en important votre compte à l'aide de la clé privée générée lors de la création.

<%= video_embed(
url: "https://youtube.com/embed/yHMxIHuUu1w",
title: "Tuto NOSTR - le twitter décentralisé incensurable !",
created_at: "2024-08-17"
) %>

## Créer votre compte Nostr

Rendez-vous sur https://snort.social et cliquez sur **S'inscrire**.

Le processus d'inscription commencera alors à travers plusieurs étapes détaillées ci-dessous.

![Accueil Snort](<%= image_path("tutorials/nostr-social-network/1_home.jpg") %>)

Choisissez un pseudonyme.

![Création du compte](<%= image_path("tutorials/nostr-social-network/2_create_account.jpg") %>)

Choisissez un avatar.

![Choix de l'image](<%= image_path("tutorials/nostr-social-network/3_choose_picture.jpg") %>)

Sélectionnez vos centres d'intérêt.

![Sélection des centres d'intérêt](<%= image_path("tutorials/nostr-social-network/4_select_interests.jpg") %>)

Sélectionnez les contacts Nostr que vous souhaitez suivre.

![Suivre des contacts](<%= image_path("tutorials/nostr-social-network/5_follow_friends.jpg") %>)

Choisissez les options permettant de masquer certains types de contenus dans votre fil (contenus pour adultes, politique, etc.).

Une fois cette étape validée, votre inscription sera terminée, mais vous pourrez toujours modifier vos informations par la suite.

## Votre compte vous appartient

> [!NOTE]
> Vous remarquerez que le site ne vous demande jamais votre adresse email ni votre numéro de téléphone.
>
> Cela s'explique par le fait que Nostr repose sur la cryptographie et ne nécessite aucune information personnelle. Votre compte vous appartient entièrement !

![Fil épuré](<%= image_path("tutorials/nostr-social-network/6_clean_feed.jpg") %>)

## Découvrir votre fil Nostr

Félicitations 🎉 ! Vous êtes maintenant sur la page d'accueil de votre fil Nostr.

Vous pouvez commencer à rechercher du contenu en cliquant sur **Chercher** dans le menu.

![Recherche de contenu](<%= image_path("tutorials/nostr-social-network/7_search_content.jpg") %>)

Vous pouvez maintenant suivre n'importe quel profil en cliquant sur le bouton **Suivre**.

![Suivre des profils](<%= image_path("tutorials/nostr-social-network/8_follow_profiles.jpg") %>)

## Sauvegarder votre clé privée

Il est maintenant temps de sauvegarder votre clé privée.

Pour cela, cliquez sur **Export keys** depuis les paramètres.

> [!CAUTION]
> Il est extrêmement important de noter votre clé privée et/ou votre phrase mnémonique. C'est la seule façon de restaurer votre compte.
> Si vous les perdez, vous ne pourrez plus accéder à vos messages et contacts Nostr.
>
> **Ne partagez jamais cette clé avec qui que ce soit.**

![Exporter les clés](<%= image_path("tutorials/nostr-social-network/9_export_keys.jpg") %>)

![Confirmation de l'export des clés](<%= image_path("tutorials/nostr-social-network/10_export_keys.jpg") %>)

## Modifier votre profil

Vous pouvez modifier votre profil à tout moment pour changer votre photo ou votre description.

![Modifier le profil](<%= image_path("tutorials/nostr-social-network/11_edit_your_profile.jpg") %>)

## Publier votre premier message

Il est maintenant temps de publier votre premier message.

Cliquez sur le bouton **Nouvelle note** en bas à gauche, saisissez votre contenu dans la fenêtre qui apparaît, puis confirmez.

> [!NOTE]
> À partir de maintenant, vous devez considérer que tout contenu publié sur un relais Nostr peut rester disponible de manière permanente.
> Même si une fonctionnalité de suppression existe, rien ne garantit que les relais respecteront cette demande.
>
> De plus, comme un message peut être republié sur n'importe quel relais, il devient difficile de savoir où celui-ci est réellement stocké.
> C'est également l'une des forces de Nostr.

![Publier un message](<%= image_path("tutorials/nostr-social-network/12_publish_message.jpg") %>)

![Confirmation de publication](<%= image_path("tutorials/nostr-social-network/13_publish_message.jpg") %>)

## Votre premier message Nostr est publié

Félicitations 🎉 ! Votre premier message vient d'être publié sur le réseau Nostr !

![Message diffusé](<%= image_path("tutorials/nostr-social-network/14_message_broadcasted.jpg") %>)

## Liens utiles

- [Nostr](https://nostr.com)
- [Nostr Directory](https://nostr.directory) — Trouver des contacts Twitter ayant rejoint Nostr
- [Amethyst](https://www.amethyst.social) — Application Android pour Nostr
- [Damus](https://damus.io) — Application iOS pour Nostr
