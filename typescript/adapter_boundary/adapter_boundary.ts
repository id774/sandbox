// adapter_boundary.ts: Adapter boundary with a single composition root
//
// Description:
// Demonstrates keeping external dependencies behind interfaces and limiting
// the choice of execution mode to one composition root. The application
// service depends only on the adapter interfaces and does not know which mode
// is running. The local and cloud adapters are demonstration implementations
// that only write to stdout; the cloud adapters do not access any network
// service, account, or credential.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     tsc --target es2020 adapter_boundary.ts && node adapter_boundary.js
//
// Requirements:
// - Node.js 20 or later
// - TypeScript 5.0 or later
// - No third-party package is required

// Adapter interfaces

interface IdentityProvider {
    currentUser(): string;
}

interface ObjectStorage {
    put(key: string, content: string): void;
}

interface Notifier {
    notify(requestId: string): void;
}

// Application service

class RequestService {
    constructor(
        private readonly identity: IdentityProvider,
        private readonly storage: ObjectStorage,
        private readonly notifier: Notifier,
    ) {}

    createRequest(): string {
        const owner = this.identity.currentUser();
        const requestId = "request-1";
        this.storage.put(
            `requests/${requestId}.json`,
            JSON.stringify({ id: requestId, owner }),
        );
        this.notifier.notify(requestId);
        return requestId;
    }
}

// Local adapters

class LocalIdentityProvider implements IdentityProvider {
    currentUser(): string {
        const user = "demo-user";
        console.log(`identity: local ${user}`);
        return user;
    }
}

class LocalObjectStorage implements ObjectStorage {
    put(key: string, content: string): void {
        console.log(`storage: local ${key}`);
    }
}

class LocalNotifier implements Notifier {
    notify(requestId: string): void {
        console.log(`notification: local ${requestId}`);
    }
}

// Cloud demonstration adapters (no network access)

class CloudIdentityProvider implements IdentityProvider {
    currentUser(): string {
        const user = "demo-user";
        console.log(`identity: cloud ${user}`);
        return user;
    }
}

class CloudObjectStorage implements ObjectStorage {
    put(key: string, content: string): void {
        console.log(`storage: cloud ${key}`);
    }
}

class CloudNotifier implements Notifier {
    notify(requestId: string): void {
        console.log(`notification: cloud ${requestId}`);
    }
}

// Composition root

type Mode = "local" | "cloud";

function createRequestService(mode: Mode): RequestService {
    switch (mode) {
        case "local":
            return new RequestService(
                new LocalIdentityProvider(),
                new LocalObjectStorage(),
                new LocalNotifier(),
            );
        case "cloud":
            return new RequestService(
                new CloudIdentityProvider(),
                new CloudObjectStorage(),
                new CloudNotifier(),
            );
    }
}

function run(mode: Mode): void {
    console.log(`${mode} mode`);
    const service = createRequestService(mode);
    console.log(`result: ${service.createRequest()}`);
}

function main(): void {
    run("local");
    console.log("");
    run("cloud");
}

main();
