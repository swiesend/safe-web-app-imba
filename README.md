# safe-web-app-imba

A small TODO-app with CRUD capabilities for testing out [Imba](http://imba.io) for the [SAFE Network](https://safenetwork.tech) from [Maidsafe](https://maidsafe.net).

<p align='center'>
  <img alt="Safe Browser - TODO App with Imba" src="img/safe-browser-example.png">
</p>

## Getting started

```bash
# install dependencies
npm install
# start webpack-dev-server and compiler
npm run dev
```

Open in any browser:

http://localhost:8080/

## Running in Production - SAFE Network

1. [Update your IP Address](http://invite.maidsafe.net/) for the test network.

2. [Download](https://github.com/maidsafe/safe_browser/releases) and open the Safe Brower
```bash
safe-browser
```

3. Enter your SAFE Network credentials

4. Put the app into production mode

Set `production=true` in the last line of `src/client.imba`:
```javascript
Imba.mount <App[{items: null}] production=true>
```

Run the app:
```bash
# start webpack-dev-server and compiler
npm run dev
```

Open in the Safe Browser:

http://localhost:8080/

## Development

Check out the [SAFE Dev Forum](https://forum.safedev.org) to come in contact with other community members:

* [imba - web apps](https://forum.safedev.org/t/imba-web-apps/2504)
* [Svelte Web component framework](https://forum.safedev.org/t/svelte-web-component-framework/2483)

And check the Tutorials for app development for the SAFE Network:

https://hub.safedev.org/docs/
