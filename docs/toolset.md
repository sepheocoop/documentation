# SEPHEO's Toolset


- [0. Overview](#Overview)
- [1. The Toolset Table](#1-The-Toolset)
- [2. Onboarding](#2-Onboarding)

# Overview
This document is written to help existing & new members get more involved (e.g. as stewards, matchmakers, etc.) and who need access or be setup on certain platforms for them to contribute. Instead of keeping all the knowledge in the heads of a few members, this is an attempt to capture SEPHEO's digital ecosystem of tools, platforms & services.


# 1. The Toolset

Quickly find the right tool for the task you need. To see info on how to get access, click on tool. 

| What you need | Tool / Platform |
|---------------|-----------------|
| Main chat | [**Matrix / Element**](#Matrix--Element) |
| Code hosting, documentation, meeting notes | [**GitHub**](#Github) |
| Platform for self-hosting many of our apps, also manages our email server | [**Cloudron**](#Cloudron) |
| Email-client (interact with our mailbox) | [**SoGo/Snappy (via Cloudron)**](#SoGoSnappy) |
| Main Database Registry (organisations & freelancers) | [**NocoDB (via Cloudron)**](#NocoDB) |
| CRM | [**EspoCRM (via Cloudron)**](#EspoCRM) |
| Automation / bot service | [**SEB bot (via Cloudron)**](#SEBbot) |
| Video calls | [**Social-coop's Meet**](#Social-Coop)  |
| Social networking | [**Social.coop (Mastodon)**](#Social-Coop’s-Meet-video-calls) |
| Password manager | [**ProtonPass**](#ProtonPass) |

> NOTE: this list is not fully exhuastive, nonetheless, should capture most important bits. If you need access to something that's not here, ask a steward.

# 2. Onboarding

An attempt to document some info & onboarding for the tools in (1). The process may differ at the time of you doing this, but hopefully not by much.

### Matrix / Element
needs documented.

### Github

<details> 
    <summary>Details</summary>
    
Most of the repositories are public, just go ahead and find what you're looking for via here: https://github.com/orgs/sepheocoop/repositories

Noteworthy repos: 

- [Website](https://github.com/sepheocoop/website)
- [Documentation](https://github.com/sepheocoop/documentation)
- [Meeting Minutes](https://github.com/sepheocoop/documentation/discussions)

If there is a private repo that you're needing access, please contact the Stewards via Matrix for someone to invite you in.
    
</details>

### Cloudron

<details> 
    <summary>Details</summary>
Used to host a suite of apps (SoGo, espocrm, nocodb, SEBbot, etc.)

1. Ask a steward to login to their Cloudron account.
2. Steward goes: **Users** -> **New User** -> Enter the primary email address only, the rest can be left as Optional (the new user should receive a sign-up email & complete their details).    

</details>

### SoGo/Snappy

<details>
    <summary>Details</summary>
Cloudron itself manages the email server and the main SEPHEO-wide email is: contact@sepheo.co

> NOTE: you can also create a personal sepheo email for yourself via cloudron, though for now, nobody seems to uses those.

In order to view the SEPHEO mailbox, you'll need an email client, we've got 2 installed at the moment:

1. Via **Cloudron**, go to **My Apps** -> **SoGo** or **Snappy**

*The credentials are on ProtonPass, ask a Steward.*
</details>

### EspoCRM

<details>
    <summary>Details</summary>
    
1. Via **Cloudron** -> **My Apps** -> **EspoCRM**
2. It should sign-in with your Cloudron account, but you won't see anything at first.
3. Ask a steward who has access to EspoCRM, to add you to the 'Stewards' in EspoCRM.

</details>

### NocoDB

<details>
    <summary>Details</summary>
NocoDB is our main db registry of freelancers & organisations.

> NOTE: *aiven.io* is a cloud database service, with a free tier, which we use to store data for the NocoDB directory in PostgreSQL. NocoDB's own offering has limited database export at the time of writing, it seems, so playing safe. 

#### First Time User
1.  via **Cloudron** -> **My Apps** -> **Nocodb** 
2. **sign-up** with cloudrod.username@sepheo.co + (new password) - this is a seperate account, but that email links us to cloudron (we think but not verified).
3. Once in, you'll need to get further access.

#### To Create Bases
Ask someone who has access to nocodb as organisation-level creator:
1. Go to **Team & Settings** (on the left menu) -> **User Management** -> Give **Organisation Level Creator** access, to anyone who we want the ability to create 'Bases'

#### To View Bases

Ask someone who is part of a Base:
1. Go to **Settings** of each Base -> **Members** -> Change the role of the new person to have access to the Base (by default they don't get access to it)

There exists two main bases:

1. **Research**: Capturing data on the organisations we've been/wish-to-be in contact with to perform matchmaking with.
2. **Directory**: The registry of all the freelancers signed-up (affiliates & members).
    
</details>


### SEBbot

needs documented

### Social Coop

SEPHEO is signed-up to Social.Coop on Mastadon, a decentralised social network.

### Social-Coop's Meet (video calls)

<details>
    <summary>Details</summary>

Since we're signed-up with Social.coop (Mastadon) and we are a paying member (to Social.Coop). They provide a video-call platform "meet". This is a standalone service (from our other services). 

https://socialcoop.meet.coop/

1. Just go to the link and sign-in
2. Then you can start a meeting

*The credentials are on ProtonPass, ask a Steward.*

</details>

### ProtonPass
 
<details>
    <summary>Details</summary>
We have not yet formulated the mechanism by which trust is established. So far, it has played out organically by entrusting members who have been active stewards for a while.

For access to any of the services or ProtonPass itself, please speak to Stewards.

</details>