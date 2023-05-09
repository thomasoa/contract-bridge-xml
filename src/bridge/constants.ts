/**
 * A set of constant describing things related to bridge deals.
 * 
 * Types: Seat, Rank, Suit, 
 * Class: Card
 * Global: Deck, Seats
 * 
 *     Seats.all : Seat[] - Array of all seat objects
 *     Seats.each         - alias for Seats.all.forEach
 *     Seats.map          - alias for Seats.all.map
 *    
 *     Deck.suits.all : Suit[] - Array of all suits
 *     Deck.suits.each, Deck.suits.map 
 *                             - aliases
 * 
 *     Deck.ranks.all: Rank[] - Array of all ranks
 *     Deck.ranks.each, Deck.ranks.map 
 *                            - aliases
 * 
 *     Deck.cards.all: Card[] - All 52 different card values
 *     Deck.cards.each, Deck.cards.map 
 * 
 *     Deck.card(suit:Suit, rank:Rank):Card - returns the card
 * 
 *     Deck.cardByName(name:string):Card - Expects suit first, then rank: 'ST' or 'd10' 
 * 
 *     Seats.nprth, Seats.east, Seats.south, Seats.west
 *     Deck.Ranks.ace, ..., Deck.Ranks.two
 *     Deck.Suits.spades, ..., Deck.Suits.clubs
 * 
 */

import {UpcaseMap} from "../generic/maps"

function f<T>(obj: T): T {
    Object.freeze(obj)
    return obj
}


type Seat = {
    name: string;
    letter: string;
    order: number
}

const North = { name: "north", letter: "N", order: 0 }
const East = { name: "east", letter: "E", order: 1 }
const South = { name: "south", letter: "S", order: 2 }
const West = { name: "west", letter: "W", order: 3 }
const AllSeats: readonly Seat[] = [North, East, South, West]
AllSeats.forEach(Object.freeze)
Object.freeze(AllSeats)
const SeatNameMap = new UpcaseMap<Seat>()
AllSeats.forEach((seat:Seat) => {
    SeatNameMap.set(seat.name, seat)
    SeatNameMap.set(seat.letter, seat)
})

const Seats = {
    north: North,
    east: East,
    south: South,
    west: West,
    all: AllSeats,
    each: AllSeats.forEach.bind(AllSeats),
    map: AllSeats.map.bind(AllSeats),
    byText: SeatNameMap.get.bind(SeatNameMap)
}

Object.freeze(Seats)

type Suit = {
    name: string;
    singular: string,
    letter: string;
    symbol: string;
    order: number,
    summand: number
}

class Rank {
    brief: string
    order: number
    bit: number
    letter: string
    summand: number
    constructor(brief: string, order: number, letter: string | undefined = undefined) {
        this.brief = brief
        this.order = order
        this.bit = 1 << (12 - order)
        this.letter = letter || brief
        this.summand = order
        Object.freeze(this)
    }
}

const Spades: Suit = f({ name: 'spades', singular: 'spade', letter: 'S', symbol: '\U+2660', order: 0, summand: 0 })
const Hearts: Suit = f({ name: 'hearts', singular: 'heart', letter: 'H', symbol: '\U+2665', order: 1, summand: 13 * 1 })
const Diamonds: Suit = f({ name: 'diamonds', singular: 'diamond', letter: 'D', symbol: '\U+2666', order: 2, summand: 13 * 2 })
const Clubs: Suit = f({ name: 'clubs', singular: 'club', letter: 'C', symbol: '\U+2663', order: 3, summand: 13 * 3 })
const AllSuits: readonly Suit[] = [Spades, Hearts, Diamonds, Clubs]
Object.freeze(AllSuits)

const SuitNameMap  = new UpcaseMap<Suit>()
AllSuits.forEach((suit) => {
    SuitNameMap.set(suit.name,suit)
    SuitNameMap.set(suit.letter,suit)
    SuitNameMap.set(suit.singular,suit)
})

const Suits = {
    spades: Spades,
    hearts: Hearts,
    diamonds: Diamonds,
    clubs: Clubs,
    all: AllSuits as readonly Suit[],
    each: AllSuits.forEach.bind(AllSuits),
    map: AllSuits.map.bind(AllSuits),
    byText: SuitNameMap.get.bind(SuitNameMap)
}

Suits.each(Object.freeze)
Object.freeze(Suits)



class Card {
    suit: Suit;
    rank: Rank;
    short: string;
    shortRS: string;
    order: number;
    constructor(suit: Suit, rank: Rank) {
        this.suit = suit
        this.rank = rank
        this.short = suit.letter + rank.brief
        this.order = rank.order + 13 * suit.order
        Object.freeze(this)
    }
}

const Ace = new Rank('A', 0)
const King = new Rank('K', 1)
const Queen = new Rank('Q', 2)
const Jack = new Rank('J', 3)
const Ten = new Rank('10', 4, 'T')
const Nine = new Rank('9', 5)
const Eight = new Rank('8', 6)
const Seven = new Rank('7', 7)
const Six = new Rank('6', 8)
const Five = new Rank('5', 9)
const Four = new Rank('4', 10)
const Three = new Rank('3', 11)
const Two = new Rank('2', 12)
const AllRanks: readonly Rank[] = f([Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two])

function ranksFromBits(bits: number): Rank[] {
    const ranks = new Array<Rank>()
    AllRanks.forEach((rank) => {
        if (rank.bit & bits) {
            ranks.push(rank)
        }
    })
    return ranks
}

interface RankLookupResult {
    rank: Rank,
    rest: string
}

class RankParser {
    letter: string
    full: string
    rank: Rank
    constructor(text: string, rank: Rank) {
        this.letter = text.slice(0, 1)
        this.full = text
        this.rank = rank
    }

    get length() { return this.full.length }

    apply(text: string): RankLookupResult {
        if (text.slice(0, this.length) == this.full) {
            return { rank: this.rank, rest: text.slice(this.length) }
        }
        throw new Error('Invalid card rank ' + text)
    }
}

function createRankParser(): (text: string) => RankLookupResult {
    const map = new UpcaseMap<RankParser>()

    const add = (parser: RankParser): void => {
        map.set(parser.letter, parser)
    }

    AllRanks.forEach((rank) => {
        add(new RankParser(rank.letter, rank))
        if (rank.brief != rank.letter) {
            add(new RankParser(rank.brief, rank))
        }
    })

    return function (text: string): RankLookupResult {
        const parser = map.get(text.slice(0, 1))
        if (parser) {
            return parser.apply(text)
        }
        throw new Error('Invalid rank ' + text)
    }
}

const rankParser = createRankParser()

function rankByText(text: string): Rank {
    text = text.toUpperCase()
    const result = rankParser(text)
    if (result.rest != "") {
        throw new Error('Invalid rank: ' + text)
    }
    return result.rank
}

function ranksByText(text: string) {
    const ranks = new Array<Rank>()
    if (text == '-') {
        return ranks
    }
    let lastOrder = -1
    let rest = text
    while (rest != '') {
        const result = rankParser(rest)
        if (result.rank.order <= lastOrder) {
            throw new Error('Invalid rank order in ' + text)
        }
        ranks.push(result.rank)
        rest = result.rest.trimStart()
        lastOrder = result.rank.order
    }
    return ranks

}

const Ranks = f({
    ace: Ace,
    king: King,
    queen: Queen,
    jack: Jack,
    ten: Ten,
    nine: Nine,
    eight: Eight,
    seven: Seven,
    six: Six,
    five: Five,
    four: Four,
    three: Three,
    two: Two,
    all: AllRanks,
    each: AllRanks.forEach.bind(AllRanks),
    map: AllRanks.map.bind(AllRanks),
    fromBits: ranksFromBits,
    byName: rankByText,
    parse: ranksByText
})

function make_cards(): Card[] {
    const cards = new Array<Card>(52)
    Ranks.each((rank) => {
        Suits.each((suit) => {
            const index = suit.summand + rank.summand
            cards[index] = f(new Card(suit, rank))
        })
    })
    return f(cards)
}

const AllCards: readonly Card[] = make_cards()
const CardsByName = new UpcaseMap<Card>()
AllCards.forEach((card:Card) => {
    const rank = card.rank
    const suit = card.suit
    [ rank.brief, rank.letter].forEach((rankStr: string) => {
        CardsByName.set(suit.letter + rankStr,card)
        CardsByName.set(rankStr + suit.letter,card)
    })
})

function cardBySuitRank(suit: Suit, rank: Rank): Card {
    return AllCards[suit.summand + rank.summand]
}

interface Rank {
    of(suit: Suit): Card
}

Rank.prototype.of = function (suit: Suit): Card { return cardBySuitRank(suit, this) }

function lookupCardByName(name: string): Card {
    name = name.toUpperCase()
    const card: Card | undefined = CardsByName.get(name)
    if (card) { return card }
    throw Error('Invalid card name ' + name)
}

function lookupCardsByNames(...names: string[]): Card[] {
    return names.map(lookupCardByName)
}

const Cards = f({
    all: AllCards,
    each: AllCards.forEach.bind(AllCards),
    map: AllCards.map.bind(AllCards),
    byName: lookupCardByName,
    byNames: lookupCardsByNames
})


const Deck = {
    ranks: Ranks,
    suits: Suits,
    cards: Cards,
    card: cardBySuitRank,
    c: Cards.byName
}
Object.freeze(Deck)

export {
    Deck, Seats, /* constants */
    Suit, Rank, Card, Seat /* types */
}
