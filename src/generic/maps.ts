export class TransformKeyMap<K1,K2,V> {
    readonly map:Map<K2,V> 
    readonly transform: (key:K1) => K2

    constructor(transform: (key:K1)=> K2, map:Map<K2,V> = new Map<K2,V>()) {
        this.transform = transform
        this.map = map
    }

    get(k1:K1):V|undefined {
       return this.map.get(this.transform(k1))
    }

    set(k1:K1,value: V) {
       this.map.set(this.transform(k1),value)
    }

    has(key:K1):boolean {
        return this.map.has(this.transform(key))
    }

}

export class UpcaseMap<V> extends TransformKeyMap<String,String,V> {
   constructor(map:Map<String,V> = new Map<String,V>()) {
       super((s:String) => s.toUpperCase(),map)
   }
}