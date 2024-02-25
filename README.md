# depazs

The _"Digitale Energie Preis Auskunfts Zentralstelle (DEPAZS)"_ is a small website for distributing and managing energy prices, realized in the context of the _XML & JSON_ module at HSLU. Main goals are to showcase the possibilities of XML-Technologies, thus the use of JavaScript should be kept to a minimum.

## Prerequisites

Please make sure you have the following things installed on your machine:

-   [NodeJS (v21.6.0 or later)](https://nodejs.org/en)
-   _npm_ (std. issue with Node) or [pnpm](https://pnpm.io/installation#using-npm)

## Setup

If you've opened the project for the first time, please install the necessary dependencies as following:

```bash
pnpm i
# or
npm i
```

After installing the dependencies you must generate a local database (with some seed-records) as following:

```bash
pnpm database:seed
# or
npm run database:seed
```

## Run locally

If you want to run the project on your machine, run the command below. If you'd like to change the default port (_3000_) one can adapt it accordingly in the `local.env` file.

```bash
pnpm start #(start:dev -> watch-mode)
# or
npm run start #(start:dev -> watch-mode)
```

# Dependencies

| Package                                          | Usage                                                |
| ------------------------------------------------ | ---------------------------------------------------- |
| [express](https://www.npmjs.com/package/express) | Web Server for hosting XML-Files, IO-operations etc. |
| [dotenv](https://www.npmjs.com/package/dotenv)   | Config management (`.env` files)                     |
| [morgan](https://www.npmjs.com/package/morgan)   | Request logger for development                       |
| [leaflet](https://www.npmjs.com/package/leaflet) | Interactive maps library                             |
