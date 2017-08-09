/**
 * Created by enpfeff on 8/7/17.
 */

const DUSKLIGHT_PRICE = 9000;

crafts = [{
    name: 'Pork Kukani',
    craft: {
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true},
        koshuPork: {price: 11000},
        OrientalSoySauce: {price: 1300},
        CookingSake: {price: 2100},
        JhammelGinger: {price: 900}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 8998,
    analyze: true
}, {
    name: 'Infusions',
    craft: {
        crescentSpringWater: {price: 490},
        alaMhiganSaltCrystals: {price: 1900},
        chickweed: {price: 394},
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 7500,
    analyze: true
}, {
    name: 'Persimmon Leaf Sushi',
    craft: {
        koshuStickyRice: {price: 850},
        riceVinegar: {price: 2100},
        persimmonLeaf: {price: 300},
        ivorySole: {price: 13990, sourced: true},
        motleyBeakFish: {price: 2000},
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: false}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 12999,
    analyze: true
}, {
    name: "Supra Max",
    craft: {
        powderedMermanHorn: {price: 3800 * 2, sourced: true},
        nobleSage: {price: 1500 * 3},
        rue: {price: 750 * 3},
        DuskborneAethersand: {price: 1100 * 2}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 15500,
    analyze: true
}];

module.exports = crafts;