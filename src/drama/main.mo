
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

import UserDomain "./user/UserDomain";
import UserRepositories "./user/UserRepositories";

shared(msg) actor class Aggregate() = this {

    /// Type alias 
    public type UserId = UserDomain.UserId;
    public type UserProfile = UserDomain.UserProfile;

    /// ID Generator
    stable var idGenerator : Nat = 10001;

    stable var userPersistence = UserRepositories.newUserPersistence();
    var userCache = UserRepositories.newUserCache();
    let userRepository = UserRepositories.newUserRepository();

    /// Canister Upgrades 
    /// Canister停止前把非stable转成stable保存到内存中
    system func preupgrade() {
        userPersistence := UserRepositories.userCacheToPersistence(userCache);

        Debug.print("Preupgrade Done!");
    };

    /// Canister升级完成启动后把stable存储中的加载到缓存中
    system func postupgrade() {
        userCache := UserRepositories.userCacheFromPersistence(userPersistence);
        userPersistence := UserRepositories.newUserPersistence();

        Debug.print("Postupgrade Done!");
    };

    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

    /// 获取当前canister id
    public func getCanisterId() : async Text {
        Principal.toText(Principal.fromActor(this))
    };

    public shared(msg) func registerUser(name: Text) : async UserId {
        let caller = Principal.toText(msg.caller);
        let userId = getIdAndIncrementOne();
        let user = {
            id = userId;
            principal = caller;
            username = name;
            status = "enable";
            createdBy = caller;
            createdAt = Time.now();
        };

        userCache := UserRepositories.saveUser(userCache, userRepository, user);
        userId
    };

    public query(msg) func getUser(userId: UserId) : async ?UserProfile {
        let res = UserRepositories.getUser(userCache, userRepository, userId);
        userCache := UserRepositories.newUserCache();
        res
    };

    // public query(msg) func countUserTotal() : async Nat {
    //     UserRepositories.countUserTotal(userCache, userRepository)
    // };

    /// 获取当前的id，并对id+1,这是有size effects的操作
    private func getIdAndIncrementOne() : Nat {
        let id = idGenerator;
        idGenerator += 1;
        id
    };
};
