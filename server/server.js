const app = require('express')();
const _ = require('lodash');
const log = require('./services/log');
const C = require('./services/constants');

const ENABLED_MODULES = [
    require('./ffxiv')
];

_.each(ENABLED_MODULES, module => module(app));

app.listen(C.PORT, () => log.info('Server Up and Running'));