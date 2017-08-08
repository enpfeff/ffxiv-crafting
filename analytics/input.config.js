/**
 * Created by enpfeff on 8/7/17.
 */

const DUSKLIGHT_PRICE = 11000;

crafts = [{
    name: 'Pork Kukani',
    craft: {
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true},
        koshuPork: {price: 16000},
        OrientalSoySauce: {price: 4787},
        CookingSake: {price: 1000},
        JhammelGinger: {price: 2800}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 14000,
    analyze: true
}, {
    name: 'Infusions',
    craft: {
        crescentSpringWater: {price: 585},
        alaMhiganSaltCrystals: {price: 2100},
        chickweed: {price: 800},
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 9000,
    analyze: true
}, {
    name: 'Persimmon Leaf Sushi',
    craft: {
        koshuStickyRice: {price: 1350},
        riceVinegar: {price: 3000},
        persimmonLeaf: {price: 250},
        ivorySole: {price: 10000},
        motleyBeakFish: {price: 2500},
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 13500,
    analyze: true
}];

module.exports = crafts;