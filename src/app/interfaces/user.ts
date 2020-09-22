export interface User {
    lastUpdate:string;
    roles: Roles;
    displayName?: string;
    email?: string;
    photoURL?: string;
    uid?: string;
}

export interface Roles {
    subscriber?: boolean;
    setter?: boolean;
    moderator?:boolean;
    admin?: boolean;
}
