# Test Tokens

## Init

```bash
$ npm run init
$ npm run build
```

## Deploy to local

Networks l1, l2, localhost, hardhat already configured.
See [hardhat.config.ts](./hardhat.config.ts).
If no `MNEMONIC` environment var, the typical test account `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` run a deploy script.

```bash
$ npx hardhat run --network localhost script/hardhat/deploy.ts
```
