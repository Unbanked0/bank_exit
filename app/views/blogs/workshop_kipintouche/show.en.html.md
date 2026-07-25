> [!IMPORTANT]
> This workshop presents free and resilient digital tools in response to growing threats to privacy: European regulations like "Chat Control" (institutional message decryption), mandatory ID cards for social media in France starting September for new accounts and January for existing accounts, institutional censorship. The goal is to regain control of your communications — individual conversations, restricted groups, public posts — without relying on a single jurisdiction or actor who could be forced to disclose your data.

Two families of tools are explored: **encrypted messaging** (Session, Matrix) and **decentralized social networks** (Nostr, Mastodon). SimpleX is mentioned as a bonus but not recommended as a priority to avoid fragmentation.

<%= video_embed(
url: "https://www.youtube.com/embed/OWYkYrSJuck",
title: "
Anti-censorship Workshop #KipInTouche - Session Matrix Nostr Mastodon 07-2026",
created_at: "2026-07-25"
) %>

## Understanding the Two Architectures: Decentralized vs Federated

Before choosing a tool, it's essential to distinguish between two network organization models.

- **Decentralized** (Session, Nostr) — The network is entirely horizontal: no central server has a hierarchical role. Your account exists independently of any particular node. If a relay goes offline, your account survives. Resilience depends however on the overall vitality of the network: if no one runs nodes anymore, the network dies.

- **Federated** (Matrix, Mastodon) — The network consists of independent servers connected to each other. You create your account on a specific server. If that server goes down, your account goes down with it. However, you can launch your own server and retain full control. Resilience rests on the person or collective that administers the server.

| Criterion                  | Decentralized     | Federated                |
| -------------------------- | ----------------- | ------------------------ |
| Dependency on a server     | None              | Linked to chosen server  |
| Setup                      | Nothing to manage | One server to administer |
| If a node/server goes down | Account survives  | Account may disappear    |
| Self-hosting               | Not necessary     | Possible and recommended |

## Encrypted Messaging

### Session — Decentralized Messaging

Session is a decentralized encrypted messaging app, inspired by Signal's code but without its drawbacks. Signal is centralized and hosted on Amazon servers in the United States, subject to the Cloud Act (the NSA and CIA can demand access to messages). Session adopts Signal's encryption principles but applies them on a decentralized global network.

**Main features:**

- End-to-end encryption (protocol derived from Signal)
- Decentralized network: no central server, no single jurisdiction
- Groups up to 50 people encrypted (beyond that, encryption is limited)
- Available on phone (iOS, Android) and computer (Windows, Mac, Linux)
- Audio calls supported
- No phone number or email required

**Getting started:**

See the complete [Session tutorial](<%= tutorial_path("session-messaging") %>) on Sortie de Banque.

**Censorship resistance:** Session is not based on a domain name, a particular server, or a jurisdiction. Cutting off the network is extremely difficult for a censor.

> [!NOTE]
> **Funding transparency:** The foundation maintaining Session faced funding difficulties but obtained funds to continue for approximately 6 to 12 more months. Even if the foundation stopped, the decentralized network would continue functioning as long as relay nodes remain active — just like the Bitcoin network continues if the Bitcoin foundation disappears.

### Matrix (client: Element) — Federated Messaging

Matrix is a federated messaging protocol. The most well-known client is **Element** (formerly Element Classic, and **Element X** for recent mobile versions).

**Main features:**

- End-to-end encryption
- Federated architecture: you choose a server (or create your own)
- Potentially very large groups (up to tens of thousands of users on a big server)
- Available as web version (no installation needed), desktop application (Windows, Mac, Linux) and mobile (iOS: Element X, Android: Element X)
- Encrypted session backup for multi-device recovery

**Available clients:**

| Platform              | Recommended Client                                            |
| --------------------- | ------------------------------------------------------------- |
| Web                   | [app.element.io](https://app.element.io) (nothing to install) |
| Windows / Mac / Linux | Element Desktop                                               |
| iOS                   | Element X                                                     |
| Android               | Element X                                                     |
| F-Droid               | Element                                                       |

**Getting started:**

1. Visit [matrix.org](https://matrix.org) or use the web version [app.element.io](https://app.element.io).
2. Click "Create Account".
3. **Choose your homeserver:**

> [!IMPORTANT]
> By default, Matrix.org is the main server, based in the United Kingdom. If this server complies with a legal injunction, all its users are affected. Ideally, use an independent server (collective, association) or launch your own. Example: the "Bank-Exit" community server is [matrix.bank-exit.org](https://matrix.to/#/#go:matrix.bank-exit.org).

4. Enter a username and a strong password.
5. Confirm your email via the received link.
6. Choose your preferences (notifications, data sharing — disable if you wish to limit metadata).

**Usage:**

- **Join a public room:** Search for a room (e.g., Matrix Community at `community2.matrix.org`) and click "Join".
- **Create your own group:** Choose "Create Space", set it as public or private, then follow the steps.
- **Share your contact:** Click your profile in the top left, copy your personal link and share it.
- **Security backup:** Matrix will ask you to create a recovery key to restore your sessions and messages in case of device loss.

> [!WARNING]
> Safely save your recovery key. It allows you to manage sessions across multiple devices and revoke compromised sessions (e.g., stolen phone) to prevent identity theft.

**Self-hosting:**

To host your own Matrix server: an automated installation script is available from the "Sortie de Banque" community. Simply specify the desired server name, and the script configures everything. A standard configuration (approximately 100 GB disk and 4 GB RAM) can accommodate several thousand users. Matrix works like a database (not a blockchain): backing up the files is enough to migrate to a new server transparently.

## Decentralized Social Networks

### Nostr — Decentralized Social Network

Nostr (Notes and Other Stuff Transmitted by Relays) is a decentralized social network protocol. It works like Twitter (likes, reposts, comments, personal profile) but without a central server. Once a message is published, it becomes **uncensorable**: even the author cannot remove it. This is Nostr's main strength against institutional censorship.

> [!NOTE]
> **Protocol vs client:** Nostr is the protocol (the network), not an application. Clients are the software/apps you use to access it — just as Outlook or Thunderbird are clients for the email protocol. For example, the website [phoenix.social](https://phoenix.social) is a Nostr client, just like Damus on iOS or Amethyst on Android.

**Available clients:**

| Platform     | Recommended Client                       | Note                                                                        |
| ------------ | ---------------------------------------- | --------------------------------------------------------------------------- |
| Web          | [phoenix.social](https://phoenix.social) | Direct access, no account required                                          |
| iPhone / iOS | Damus or Primal                          | Primal = smoother, Damus = more resilient                                   |
| Android      | Amethyst or Primal                       | Amethyst = slower but resilient, Primal = fluid but depends on cache server |

> [!TIP]
> For daily use, **Primal** offers a smooth Twitter-like experience. For maximum resilience, **Amethyst** is preferable because it doesn't depend on a centralized cache server.

**Getting started:**

See the complete [Nostr tutorial](<%= tutorial_path("nostr-social-network") %>) on Sortie de Banque.

**Notable features:**

- **Zaps in Bitcoin Lightning:** Nostr integrates direct micropayments in Bitcoin Lightning. You can support an author or media outlet by clicking the zap icon and selecting an amount. No credit card, crypto payment directly.

> [!NOTE]
> The community prefers **Monero** over Bitcoin Lightning for financial sovereignty reasons. Nostr versions enabling Zaps in Monero are in development.

- **Media relays:** Bridges between Nostr and traditional media (well-known newspapers) exist. Even if Twitter is blocked or suspended, you can continue following news uncensorably via Nostr.

**Finding the "Bank-Exit" community on Nostr:**

Search the community's [#KipInTouche](https://phoenix.social/t/Kipintouche) hashtag in the Nostr client's search bar to access their posts, followers, and followings directly.

### Mastodon — Federated Social Network

Mastodon operates on the same federated model as Matrix: you create an account on a chosen server, and servers communicate with each other.

**Main features:**

- Federated architecture (like Matrix)
- Interface similar to Twitter
- Server-level moderation: administrators and moderators enforce rules and expel disruptors
- Rooms/groups configurable as public, invitation-only, etc.
- Numerous clients available (Android, iPhone, web, computer, even retro systems)

**Getting started:**

1. Visit [mastodon.social](https://mastodon.social) (main server) or choose another server.
2. Click "Join".
3. Choose a client application among the many options listed on the site.

> [!IMPORTANT]
> As with Matrix, server choice is crucial. The main server ([mastodon.social](https://mastodon.social)) is subject to a jurisdiction. If the server complies with legal pressure, all its users are affected. Ideally, have a server managed by your collective for full control over moderation and resilience.

**Moderation:**

> [!TIP]
> Mastodon is not anarchic despite its open nature. Each server has its own administrators, moderators, and rules. You can configure your groups as public, invitation-only, or restricted. In case of abusive behavior, administrators can remove users, just like on Telegram.

## Bonus: SimpleX

SimpleX is mentioned as a bonus option. It is a technically advanced messaging app allowing multiple identities. The community does not prioritize it to avoid fragmentation: too many tools dilute efforts and prevent critical mass from forming on each platform.

## Summary Table of Tools

| Tool                  | Type                                                      | Architecture                                        | Usage                         | Tutorial                                             |
| --------------------- | --------------------------------------------------------- | --------------------------------------------------- | ----------------------------- | ---------------------------------------------------- |
| **Session**           | <span class="badge badge-primary">Messaging</span>        | <span class="badge badge-info">Decentralized</span> | 1-to-1 and groups ≤ 50        | [Link](<%= tutorial_path("session-messaging") %>)    |
| **Matrix / Element**  | <span class="badge badge-primary">Messaging</span>        | <span class="badge badge-success">Federated</span>  | Large groups, scalable        | /                                                    |
| **Nostr**             | <span class="badge badge-secondary">Social Network</span> | <span class="badge badge-info">Decentralized</span> | Uncensorable publication      | [Link](<%= tutorial_path("nostr-social-network") %>) |
| **Mastodon**          | <span class="badge badge-secondary">Social Network</span> | <span class="badge badge-success">Federated</span>  | Moderated Twitter alternative | /                                                    |
| **SimpleX** _(bonus)_ | <span class="badge badge-primary">Messaging</span>        | <span class="badge badge-info">Decentralized</span> | Multi-identities              | /                                                    |

## Practical Recommendations

- **Migration priority:** Start with **Session** for daily messaging (simple, nothing to manage) and **Nostr** for following news uncensorably. Add **Matrix** if you have a collective capable of administering a server, and **Mastodon** for a Twitter-like presence with moderation.

- **On iOS (Apple):** The App Store is a closed environment. Apple decides unilaterally which applications are allowed. This is a dead end for resilience. If you want to go further, consider leaving iOS. Android is more open but also begins tightening restrictions on free apps. The coming years may see Google restrict installing apps outside the Play Store. Computers remain the most open platforms.

- **[OnlyOffice](https://www.onlyoffice.com/en):** Mentioned during the workshop as a free alternative to Microsoft Office (documents, spreadsheets, presentations, PDF forms). Modern design, advantageously replaces Office subscriptions at 7–12 €/month. LibreOffice is also a viable option, though its design is more archaic.

> [!IMPORTANT]
> The goal is not to use all these tools simultaneously but to focus on a few to reach critical mass. If Pierre is on Session, Paul on SimpleX, and Jacques on Matrix, no one finds each other. Choose collectively and converge.
