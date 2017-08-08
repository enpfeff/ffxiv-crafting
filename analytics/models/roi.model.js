/**
 * Created by enpfeff on 8/7/17.
 */

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const roiSchema = new Schema({
    time:  Date,
    roi: Number,
    name: String,
    recipe: [{
        price: Number,
        name: String
    }],
    meta: { type: Schema.Types.Mixed }

});

module.exports = mongoose.model('roi', roiSchema);