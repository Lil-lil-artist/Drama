
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module {

    public type Timestamp = Int;
    public type StatusEnum = Text;

    /// 用户数据
    public type UserId = Nat;
    public type UserPrincipal = Text;

    public type UserProfile = {
        id : UserId;
        principal : UserPrincipal;
        username : Text;
        status : StatusEnum;
        createdBy : UserPrincipal;
        createdAt : Timestamp;
    };


    /// User eq
    public let userEq = Nat.equal;
    public let userHash = Hash.hash


}
