//! src/repositories/HashMapRepository.mo

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

/// DFINITY使用WebAssembly运行时,其中的runtime memory在升级或重启会丢失,
/// 需要在系统重启前执行的系统方法preupgrade()中把cache中内容store到stable memory,
/// 在系统重启后执行系统方法postupgrade()把stable memory中的数据加载到runtime memory
/// 使用HashMap作为WebAssembly保存runtime memory数据的数据容器
module {

    public type Persistence<K, V> = [(K, V)];

    public type HashMapCache<K, V> = HashMap.HashMap<K, V>;

    public type HashSet<K> = HashMapCache<K, ()>;

    public class HashMapRepository<K, V>() {
        /// 根据id查询，如果对应的id存在，返回?V，否则返回null
        public func get(cache: HashMapCache<K, V>, k: K) : ?V {
            cache.get(k)
        };

        /// 根据过滤条件查询，返回符合条件的数据集
        public func findBy<R>(cache: HashMapCache<K, V>, 
            keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash, mapFn : (K, V) -> ?R): HashMapCache<K, R> {
            HashMap.mapFilter<K, V, R>(cache, keyEq, keyHash, mapFn)
        };

        /// 根据过滤条件统计数量，返回满足条件的记录数，否则返回0
        public func countSize(cache: HashMapCache<K, V>) : Nat {       
            cache.size()
        };

        /// 通过指定的Key和value，更新数据集，返回被更新key的旧value,或者null
        public func update(cache: HashMapCache<K, V>, k: K, v: V) : (HashMapCache<K, V>, ?V) {
            let outdated = cache.replace(k, v);
            (cache, outdated)
        };

        /// 从数据集中删除指定的记录，返回删除指定记录的数据集和被删除的记录（如果id对应的记录存在，否则返回null）
        public func delete(cache: HashMapCache<K, V>, k: K) : (HashMapCache<K, V>, ?V) {
            let outdated = cache.remove(k);
            (cache, outdated)
        };

    };

    /// 把缓存数据转化成持久化数据
    public func cacheToPersistence<K, V>(cache: HashMapCache<K, V>) : Persistence<K, V> {
        Iter.toArray(cache.entries())
    };

    public func peristenceToCache<K, V>(arr: Persistence<K, V>, keyEq: (K, K) -> Bool, keyHash: K -> Hash.Hash) : HashMapCache<K, V> {  
        var cache = newHashMapCache<K, V>(keyEq, keyHash);
        for ((k, v) in arr.vals()) {
            cache.put(k, v);
        };
        cache
    };

    public func newPersistence<K, V>() : Persistence<K, V> {
        []
    };
    
    public func newHashMapCache<K, V>(keyEq: (K, K) -> Bool, keyHash: K -> Hash.Hash) : HashMapCache<K, V> {
        HashMap.HashMap(0, keyEq, keyHash)
    };

    public func newHashSet<K>(keyEq: (K, K) -> Bool, keyHash: K -> Hash.Hash) : HashSet<K> {
        newHashMapCache<K,()>(keyEq, keyHash)
    };

    public func getEntityByIds<K, V>(cache: HashMapCache<K, V>, repository: HashMapRepository<K, V>, ids: HashSet<K>) : [V] {
        let size = ids.size();
        var tempBuffer = Buffer.Buffer<V>(size);

        for ((id, _) in ids.entries()) {
            switch (repository.get(cache, id)) {
                case (?e) { tempBuffer.add(e); };
                case (null) { }
            }
        };

        tempBuffer.toArray()     
    };

    public func arrayToHashSet<K>(arr: [K], keyEq: (K, K) -> Bool, keyHash: K -> Hash.Hash) : HashSet<K> {
        var cache = newHashMapCache<K, ()>(keyEq, keyHash);
        for (k in arr.vals()) {
            cache.put(k, ());
        };
        cache
    };
};