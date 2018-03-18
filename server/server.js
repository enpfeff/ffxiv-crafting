const app = require('express')();
const _ = require('lodash');
const log = require('./services/log');
const C = require('./services/constants');

const ENABLED_MODULES = [
    require('./ffxiv')
];

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

_.each(ENABLED_MODULES, module => module(app));

app.listen(C.PORT, () => log.info('Server Up and Running'));