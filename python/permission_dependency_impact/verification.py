# verification.py: Permission and dependency impact scope comparison
#
# Description:
#   Compare the configuration-write scope of one principal and the business
#   service outage scope of a shared identity service in fixed scenarios.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/permission_dependency_impact/verification.py
#
# Requirements:
#   - Python 3.10 or later
#   - Python standard library only
#   - Assertions must be enabled (do not run with -O).

# Permission grants: (principal, resource, operation)
grants_before = {
    ("ops-admin", "order-config", "config:write"),
    ("ops-admin", "billing-config", "config:write"),
    ("ops-admin", "report-config", "config:write"),
    ("order-admin", "order-config", "config:write"),
    ("billing-admin", "billing-config", "config:write"),
}

grants_after = {
    grant
    for grant in grants_before
    if grant[0] != "ops-admin" or grant[1] == "order-config"
}


def writable_resources(grants, principal):
    return {
        resource
        for actor, resource, operation in grants
        if actor == principal and operation == "config:write"
    }


# Dependencies: service -> mandatory dependencies
dependencies_before = {
    "identity-a": (),
    "orders": ("identity-a",),
    "billing": ("identity-a",),
    "portal": ("orders",),
    "reports": ("billing",),
}

dependencies_after = {
    **dependencies_before,
    "identity-b": (),
    "billing": ("identity-b",),
}

business_services = {"orders", "billing", "portal", "reports"}


def impacted_services(dependencies, failed_service):
    # Traverse reversed dependency edges from the failed service.
    dependents = {service: set() for service in dependencies}
    for service, required_services in dependencies.items():
        for required in required_services:
            dependents.setdefault(required, set()).add(service)

    reached = {failed_service}
    pending = [failed_service]
    while pending:
        current = pending.pop()
        for dependent in dependents.get(current, ()):
            if dependent not in reached:
                reached.add(dependent)
                pending.append(dependent)

    return reached & business_services


before_access = writable_resources(grants_before, "ops-admin")
after_access = writable_resources(grants_after, "ops-admin")
before_outage = impacted_services(dependencies_before, "identity-a")
after_outage = impacted_services(dependencies_after, "identity-a")

assert before_access == {
    "order-config", "billing-config", "report-config"
}
assert after_access == {"order-config"}
assert before_outage == {
    "orders", "billing", "portal", "reports"
}
assert after_outage == {"orders", "portal"}

print(f"Permission scope: {len(before_access)} -> {len(after_access)}")
print(f"Dependency scope: {len(before_outage)} -> {len(after_outage)}")
