const app = require('express')();
const _ = require('lodash');
const log = require('./services/log');
const PORT = process.env.PORT || 3000;

const ENABLED_MODULES = [
    require('./ffxiv')
];

_.each(ENABLED_MODULES, module => module(app));

app.listen(PORT, () => log.info('Server Up and Running'));