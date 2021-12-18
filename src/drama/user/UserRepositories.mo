//! src/users/Repository.mo

import Text "mo:base/Text";

import HashMapRepositories "../repositories/HashMapRepositories";
import UserDomain "./UserDomain";

module {

    public type UserPrincipal = UserDomain.UserPrincipal;
    public type UserId = UserDomain.UserId;
    public type UserProfile = UserDomain.UserProfile;

    public type Persistence<K, V> = [(K, V)];
    public type Cache<K, V> = HashMapRepositories.HashMapCache<K, V>;
    public type HashSet<K> = HashMapRepositories.HashSet<K>;

    public type UserPersistence = Persistence<UserId, UserProfile>;
    public type UserCache = Cache<UserId, UserProfile>;
    public type UserRepository = HashMapRepositories.HashMapRepository<UserId, UserProfile>;

    public let userEq = UserDomain.userEq;
    public let userHash = UserDomain.userHash;


    public func newUserPersistence() : UserPersistence {
        []
    };

    public func newUserCache() : UserCache {
        HashMapRepositories.newHashMapCache<UserId, UserProfile>(userEq, userHash)
    };

    public func newUserRepository() : UserRepository{
        HashMapRepositories.HashMapRepository<UserId, UserProfile>()
    };

    public func saveUser(cache: UserCache, repository: UserRepository, userProfile: UserProfile) : UserCache {
        updateUser(cache, repository, userProfile).0
    };

    public func updateUser(cache: UserCache, repository: UserRepository, userProfile: UserProfile) : (UserCache, ?UserProfile) {
        repository.update(cache, userProfile.id, userProfile)
    };

    public func deleteUser(cache: UserCache, repository: UserRepository, userId: UserId) : UserCache {
        repository.delete(cache, userId).0
    };

    public func getUser(cache: UserCache, repository: UserRepository, userId: UserId) : ?UserProfile {
        repository.get(cache, userId)
    };

    public func countUserTotal(cache: UserCache, repository: UserRepository) : Nat {
        repository.countSize(cache)
    };

    public func userCacheFromPersistence(userPersistence: UserPersistence) : UserCache {
        HashMapRepositories.peristenceToCache<UserId, UserProfile>(userPersistence, userEq, userHash)
    };

    public func userCacheToPersistence(userCache: UserCache) : UserPersistence {
        HashMapRepositories.cacheToPersistence<UserId, UserProfile>(userCache)
    };

}