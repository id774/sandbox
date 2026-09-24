// Demonstrates consuming Jev as an MCP-style external decision tool and
// validating its finite route result at the application boundary. A local
// mock returns the MCP tool response, so no MCP server, external process,
// network access, or credentials are needed.
// Run: tsc --target es2020 route.ts && node route.js

const routes = ["fast", "deep"] as const;

type Route = typeof routes[number];

interface McpRequest {
    name: string;
    arguments: {
        task: string;
        candidates: Record<string, string>;
    };
}

interface McpRouteResult {
    route: string;
    confidence: number;
}

const request: McpRequest = {
    name: "jev_route",
    arguments: {
        task: "Write a 2000 word essay with careful reasoning.",
        candidates: {
            fast: "Cheap quick model for simple lookups",
            deep: "Strong model for long careful reasoning",
        },
    },
};

// Local mock of the MCP tool call. Fixed demonstration data, not a live model result.
function callTool(input: McpRequest): McpRouteResult {
    void input;
    return {
        route: "deep",
        confidence: 0.93,
    };
}

function isRoute(value: string): value is Route {
    return routes.includes(value as Route);
}

const result = callTool(request);
if (!isRoute(result.route)) {
    throw new Error(`Unexpected route: ${result.route}`);
}

console.log(`tool: ${request.name}`);
console.log(`route: ${result.route}`);
console.log(`confidence: ${result.confidence}`);
