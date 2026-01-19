# Adding People to Matrix

This document aims to describe our process for adding people to our
Matrix space, which we use for quick messaging, general chat, and
notifications.

## About Matrix

Matrix is an open, encrypted messaging platform. In practice it's a
bit like Slack or Whatsapp or Signal. But there are differences:

- It's federated. There is no central server, by design.
- It's open protocol. And many implementations are open source.

The consequences of these are:

- You need to pick a client. In fact you might use several different
  ones.
- You need an account on a server. Again, you might have several
  different ones.
- Despite this, you should be able to communicate with anyone on the
  platform, even if they use different clients and servers. And also
  join "Spaces" or "Rooms" anywhere on the platform, so long as
  they're open to that.

Some terminology:

- A "Room" is a chat group.  The degenerate case is a "Room" with two
  people, which looks like a Whatsapp or Signal chat. With more
  people, this then looks like a Group Chat.
- "Spaces" are collections of Rooms, administered as a unit. This is
  similar to Slack Channels, or Whatsapp Community.

## Recommendations:

This is what we recommend to newcomers.

- Usually most people seem to use the reference client: [Element][element.io]
- This is available as:
  - a web app, which can be the canonical installation at [app.element.io] or a 3rd party installation.
  - a phone app, which you can install using your phone's usual app store.
- Many people then sign up there with an account on [matrix.org], which you can do. Or you can choose another host server. 
- For the purposes of connecting to Sepheo you need to be using the matrix host [spacetu.be], but I don't new accounts are permitted there directly
- Therefore you want to sign up to use another server initially
- Then send us your Matrix handle (which you should see in your profile), and we can invite you.

### When creating your account...

There are very advisable some extra steps.

- Make sure you've saved your recovery code. This is important! It's
  needed if you switch devices, or clients, to be able to decrypt your
  message history on the new device.
- If you skipped that step, you can instead (or in addition) export your encryption keys.
- By default Element stores your (password protected) encryption keys
  on your homeserver, which is what the rescue code will recover
  access to.
- This can be turned off in the settings, in which case you definitely
  should export your encyption keys.
- Store your recovery code / encryption keys somewhere safe! We
  recommend using a password manager, such as Proton Pass (if you use
  Protonmail) or BitWarden.

The recovery key should be given to you when you first sign into your
account via Element (or which ever client you use).

In Element, you can export your encryption keys at any point by
clicking on the cog icon in the bottom left of the screen, selecting:
All Settings -> Encruption, and then scrolling down "Advanced". There
is an "Export keys" button (as well as an "Import keys" button.)

A notable quirk of Element/Matrix is that, if you log into another
device, which may simply be another browser, or the same one after
your session has expired, it will by defualt be marked as
"unverified", because it has not yet proven that it's the same person.

This means your chat will have a red dot next to messages, showing
this status to other people. It will also mean you won't be able to
read your own chat history in encrypted rooms.

To resolve this, you need to prompt your new device, or session, to
validate itself. You can do this in a number of ways.

> [!Warning]
>
> This is partly written from memory, and needs to be both checked and
> clarified.

- On the old device:
  - go into "All Settings" as above
  - Selecting "Sessions".
  - Scroll down to the list of "Other sessions"
  - Find the unverified one(s) corresponding to your new device
  - Request a verification, a process which can be done by QR code or
    by comparing a list of emojies / keywords and confirming they are
    identical on both devices.  list of s
- On the new device:
  - [To be written...]


## Our Matrix Host

The Sepheo matrix space is currently hosted by John Evans'
[spacetu.be] Matrix server. It could in future be hosted directly on
our [Cloudron][cloudron] [server][my.sepheo.co], but that would
require some work.


[cloudron]: https://cloudron.io
[my.sepheo.co]: https://my.sepheo.co
[element.io]: https://element.io
[element.io]: https://app.element.io
[matrix.org]: https://matrix.org
[spacetu/be]: https://spacetu.be
