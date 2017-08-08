/**
 * Created by enpfeff on 8/7/17.
 */

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const recipeSchema = mongoose.Schema({
    price: Number,
    name: String
}, { _id : false });

const roiSchema = new Schema({
    time: { type: Date, default: new Date() },
    name: String,
    recipe: [recipeSchema],
    values: {
        roi: Number,
        earningsPerCraft: Number,
        marketPerCraft: Number,
        wholesalePerCraft: Number,
        wholsalePerItem: Number
    },
    meta: { type: Schema.Types.Mixed }

});

module.exports = mongoose.model('roi', roiSchema);