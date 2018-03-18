/**
 * Created by enpfeff on 8/7/17.
 */

const DUSKLIGHT_PRICE = 8799;

crafts = [{
    name: 'Pork Kukani',
    craft: {
        dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: false},
        koshuPork: {price: 11000, sourced: true},
        OrientalSoySauce: {price: 1300},
        CookingSake: {price: 2100},
        JhammelGinger: {price: 900}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 10999,
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
    marketValuePerItem: 10500,
    analyze: true
}, {
    name: 'Tempura Platter',
    craft: {
        gyrAbanianFlour: {price: 700},
        gaganaEgg: {price: 400},
        cottonseedOil: {price: 1500},
        yanxianTigerPrawn: {price: 500},
        swordTip: {price: 5200},
        lotusRoot: {price: 2900}
    },
    itemsPerCraft: 3,
    marketValuePerItem: 7000,
    analyze: true
}, {
    name: 'High Mythrite Scythe',
    craft: {
        'Luminous Fiber': {price: 39500 * 3, sourced: true},
        'High Mythrite Ingot': {price: 24999 * 2},
        'Treated Camphorwood Lumber': {price: 30000},
        'Wolfram Ingot': {price: 9999},
        'Gold Ingot': {price: 5000},
        'Mastercraft Demimateria': {price: 31000}
    },
    itemsPerCraft: 1,
    marketValuePerItem: 280000,
    analyze: true
}, {
    name: 'Palladium Circlet of Maiming',
    craft: {
        PalladiumIngot: {price: 28500 * 2, sourced: true},
        ChromiteIngot: {price: 19000},
        GazelleHorn: {price: 40},
        Rhodonite: {price: 7000},
        EverbrightAethersand: {price: 400 * 2},
        Grade2ReisuiOfStrength: {price: 6500}
    },
    itemsPerCraft: 1,
    marketValuePerItem: 214000,
    analyze: true
}, {
    name: 'Palladium Earring of Slaying',
    craft: {
        PalladiumIngot: {price: 28500 * 2, sourced: true},
        starSpinel: {price: 12000},
        Triphane: {price: 4000},
        EverbrightAethersand: {price: 400 * 2},
        Grade2ReisuiOfStrength: {price: 6500}
    },
    itemsPerCraft: 1,
    marketValuePerItem: 164000,
    analyze: true
}];


module.exports = crafts;