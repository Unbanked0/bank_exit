> [!IMPORTANT]
> This tutorial explains how to create a Monero fundraiser using **Kuno**, an open source platform that allows you to collect donations without relying on a centralized intermediary.

Monero is a cryptocurrency designed to provide strong transaction privacy. Unlike many traditional crowdfunding platforms, a Monero fundraiser allows you to receive funds without the risk of arbitrary blocking by a company or authority.

{{toc}}

<%= video_embed(
url: "https://youtube.com/embed/76vxvYrFar4",
title: "Create an INSTOPPABLE kitty in 10 minutes with Monero and KUNO!",
created_at: "2024-08-07"
) %>

## About Kuno

[Kuno](https://kuno.anne.media) is an open source platform that allows users to create Monero fundraisers.

The platform hosts various types of projects:

- documentaries;
- artistic projects;
- citizen initiatives;
- humanitarian aid;
- translations;
- community projects.

Each fundraiser contains:

- a project description;
- a funding goal;
- the Monero receiving address;
- the donation history;
- information identifying the project creator.

Donors can participate simply by scanning a QR code or copying the Monero address associated with the fundraiser.

### Example of a fundraiser

One of the first fundraisers created by the Collective was dedicated to supporting farmers.

It raised:

- more than 5.65 XMR;
- from around thirty contributors;
- representing several hundred euros depending on the Monero price at the time of donations.

Contributors remain anonymous, but the Monero blockchain allows verification of received amounts and transaction dates.

The fundraiser also contains:

- a description explaining how the funds will be used;
- photos;
- a history of received donations;
- optional comments.

### Why use a Monero fundraiser?

Traditional platforms such as Leetchi or GoFundMe rely on private companies.

They may potentially:

- block a fundraiser;
- request additional documentation;
- suspend an account;
- prevent access to funds.

With a Monero fundraiser:

- received funds cannot be reversed;
- no financial intermediary controls payments;
- the fundraiser remains accessible even if the website disappears.

The Kuno platform itself could theoretically become unavailable, but funds already sent remain permanently recorded on the Monero blockchain.

This technology therefore enables the creation of fundraising tools that are more resistant to censorship.

## Create a Kuno fundraiser

Go to: https://kuno.anne.media, then click **Start a Kuno**. Creating a fundraiser involves several steps.

### General information

You need to provide:

- the fundraiser title;
- a description;
- a funding goal;
- a Monero address;
- a private view key;
- optionally an email address and password.

### Title and description

The description is an essential element.

It should explain:

- why you are creating this fundraiser;
- who you are;
- how the funds will be used;
- what results are expected;
- how people can contact you or verify your identity.

If you already have an existing community, mention it to increase trust.

You can also add:

- images;
- tags;
- contact links.

### Setting a goal

The goal corresponds to the amount of Monero you want to raise.

It is preferable to start with a realistic objective.

An initial success helps:

- demonstrate that the project works;
- reassure contributors;
- build momentum around the fundraiser.

### Create a Monero wallet with Cake Wallet

[See the Cake Wallet tutorial](<%= url_for tutorial_path("cakewallet-monero") %>)

### Retrieve your Monero address

In Cake Wallet:

1. Open the main screen.
2. Click **Receive**.
3. Copy your Monero address.

This address will be used to receive donations.

A standard Monero address generally starts with `4`.

Do not use:

- a subaddress starting with `8`;
- another secondary address.

Kuno must use the primary address in order to correctly track payments.

### Retrieve your private view key

Kuno requires your **private view key** to detect incoming transactions.

This key only allows:

- observing incoming transactions;
- calculating the amount received.

It does not allow:

- sending funds;
- spending your Monero.

In Cake Wallet:

1. Open the settings.
2. Go to **Security and Backup**.
3. Select **Show seed phrase and keys**.
4. Enter your PIN code.
5. Scroll down until you find:

`Secret view key`

Copy only this key.

Never share:

- your recovery phrase;
- your private spend key.

### Finalize the fundraiser

Return to Kuno and provide:

- your Monero address;
- your private view key;
- an optional email address;
- a password.

The email address can allow you to modify the fundraiser later.

You can also enable notifications when new donations are received.

Click **Start**.

Your fundraiser is now created.

## Receiving donations

Your fundraiser will display:

- a QR code;
- your Monero address;
- your funding goal;
- your progress.

Contributors can then:

1. open their Monero wallet;
2. scan the QR code;
3. choose an amount;
4. send the transaction.

Donations will automatically appear on the fundraiser thanks to the private view key.

## Tracking funds

Incoming transactions will be visible on Kuno.

However, Kuno cannot see spending activity from your wallet.

The platform only displays:

- received donations;
- collected amounts;
- incoming transaction history.

Your expenses remain private.

## Best practices

To keep your fundraiser secure:

- keep your recovery phrase offline;
- never share your private keys;
- use a dedicated Monero address for the fundraiser;
- clearly explain how funds will be used;
- provide verification methods for contributors.

A Monero fundraiser allows you to regain control over crowdfunding by removing intermediaries and providing stronger resistance to censorship.
